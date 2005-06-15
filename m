Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261567AbVFOVDC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261567AbVFOVDC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Jun 2005 17:03:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261553AbVFOUpn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Jun 2005 16:45:43 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:65235 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261565AbVFOUpL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Jun 2005 16:45:11 -0400
Subject: Re: [RFC] Linux memory error handling
From: Dave Hansen <haveblue@us.ibm.com>
To: Russ Anderson <rja@sgi.com>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200506152028.j5FKSuw91463066@clink.americas.sgi.com>
References: <200506152028.j5FKSuw91463066@clink.americas.sgi.com>
Content-Type: text/plain
Date: Wed, 15 Jun 2005 13:45:02 -0700
Message-Id: <1118868302.6620.34.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-06-15 at 15:28 -0500, Russ Anderson wrote:
> Russell King wrote:
> > On Wed, Jun 15, 2005 at 04:26:13PM +0100, Maciej W. Rozycki wrote:
> > > On Wed, 15 Jun 2005, Russ Anderson wrote:
> > > > 	Memory DIMM information & settings:
> > > > 
> > > > 	    Use a /proc/dimm_info interface to pass DIMM information to Linux.
> > > > 	    Hardware vendors could add their hardware specific settings.
> > > 
> > >  I'd recommend a more generic name rather than "dimm_info" if that is to 
> > > be reused universally.
> > 
> I really don't care what it's called, as long as it's descriptive.
> /proc/meminfo is taken.  :-)
> 
> One idea would follow the concept of /proc/bus/ and have /proc/memory/
> with different memory types.  /proc/memory/dimm0 /proc/memory/dimm1
> /proc/memory/flash0 .  

Please don't do this in /proc.  If it's a piece of hardware, and it
needs to have some information about it exported, then you need to use
kobjects and sysfs.  

-- Dave

