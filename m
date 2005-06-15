Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261591AbVFOV23@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261591AbVFOV23 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Jun 2005 17:28:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261586AbVFOV22
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Jun 2005 17:28:28 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:45256 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S261590AbVFOV2G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Jun 2005 17:28:06 -0400
From: Russ Anderson <rja@sgi.com>
Message-Id: <200506152127.j5FLRvvl1466135@clink.americas.sgi.com>
Subject: Re: [RFC] Linux memory error handling
To: haveblue@us.ibm.com (Dave Hansen)
Date: Wed, 15 Jun 2005 16:27:57 -0500 (CDT)
Cc: rja@sgi.com (Russ Anderson), rmk+lkml@arm.linux.org.uk (Russell King),
       linux-kernel@vger.kernel.org (Linux Kernel Mailing List)
In-Reply-To: <1118868302.6620.34.camel@localhost> from "Dave Hansen" at Jun 15, 2005 01:45:02 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Hansen wrote:
> On Wed, 2005-06-15 at 15:28 -0500, Russ Anderson wrote:
> > Russell King wrote:
> > > On Wed, Jun 15, 2005 at 04:26:13PM +0100, Maciej W. Rozycki wrote:
> > > > On Wed, 15 Jun 2005, Russ Anderson wrote:
> > > > > 	Memory DIMM information & settings:
> > > > > 
> > > > > 	    Use a /proc/dimm_info interface to pass DIMM information to Linux.
> > > > > 	    Hardware vendors could add their hardware specific settings.
> > > > 
> > > >  I'd recommend a more generic name rather than "dimm_info" if that is to 
> > > > be reused universally.
> > > 
> > I really don't care what it's called, as long as it's descriptive.
> > /proc/meminfo is taken.  :-)
> > 
> > One idea would follow the concept of /proc/bus/ and have /proc/memory/
> > with different memory types.  /proc/memory/dimm0 /proc/memory/dimm1
> > /proc/memory/flash0 .  
> 
> Please don't do this in /proc.  If it's a piece of hardware, and it
> needs to have some information about it exported, then you need to use
> kobjects and sysfs.  

How about /sys/devices/system/memory/dimmX with links in
/sys/devices/system/node/nodeX/ ?  Does that sound better?


-- 
Russ Anderson, OS RAS/Partitioning Project Lead  
SGI - Silicon Graphics Inc          rja@sgi.com
