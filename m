Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264280AbTDKA7h (for <rfc822;willy@w.ods.org>); Thu, 10 Apr 2003 20:59:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264281AbTDKA7h (for <rfc822;linux-kernel-outgoing>);
	Thu, 10 Apr 2003 20:59:37 -0400
Received: from smtpzilla1.xs4all.nl ([194.109.127.137]:64266 "EHLO
	smtpzilla1.xs4all.nl") by vger.kernel.org with ESMTP
	id S264280AbTDKA7g (for <rfc822;linux-kernel@vger.kernel.org>); Thu, 10 Apr 2003 20:59:36 -0400
Date: Fri, 11 Apr 2003 03:11:13 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Joel Becker <Joel.Becker@oracle.com>
cc: James Bottomley <James.Bottomley@steeleye.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 64-bit kdev_t - just for playing
In-Reply-To: <20030411004703.GQ31739@ca-server1.us.oracle.com>
Message-ID: <Pine.LNX.4.44.0304110256420.5042-100000@serv>
References: <1049913637.1993.73.camel@mulgrave> <Pine.LNX.4.44.0304092202570.5042-100000@serv>
 <1049941189.4467.186.camel@mulgrave> <Pine.LNX.4.44.0304101033500.5042-100000@serv>
 <1049988660.1998.100.camel@mulgrave> <Pine.LNX.4.44.0304102029430.5042-100000@serv>
 <20030411004703.GQ31739@ca-server1.us.oracle.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 10 Apr 2003, Joel Becker wrote:

> 	No, the current patch DOES NOT BREAK compatibility.  Device
> numbers from 00:00 to FF:FF are not munged in any way.  As long as
> regular drivers don't expect anything else (eg, a new scsi driver that
> uses a new larger major), nothing is broken or changed.

Device number mapping _is_ changed, unless the driver is very careful. 
Look at the latest patch from Badari, now try to add more partition while 
maintaining compatibility and this has to be done for every driver!

> If you had read the patch, you would have seen this.

I did, but it's only half the story, how it will be used matters.

> > Producing a patch isn't that difficult, but I'd rather be interested, if 
> > there is even interest in such a patch? I already got not a single comment 
> > about the last patch.
> 
> 	Propose a dynamic system.  Show us your code.

Again, scsi _is_ already dynamic, there is not much to propose, it just 
needs to be generalized and I did already show some code.

bye, Roman

