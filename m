Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265175AbUGISaK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265175AbUGISaK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jul 2004 14:30:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265211AbUGISaK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jul 2004 14:30:10 -0400
Received: from sccrmhc13.comcast.net ([204.127.202.64]:51706 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S265175AbUGISaE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jul 2004 14:30:04 -0400
From: jmerkey@comcast.net
To: Dave Jones <davej@redhat.com>
Cc: Andreas Dilger <adilger@clusterfs.com>, linux-kernel@vger.kernel.org
Subject: Re: Ext3 File System "Too many files" with snort
Date: Fri, 09 Jul 2004 18:30:03 +0000
Message-Id: <070920041830.26579.40EEE42B0008C334000067D32200748184970A059D0A0306@comcast.net>
X-Mailer: AT&T Message Center Version 1 (Jun 24 2004)
X-Authenticated-Sender: am1lcmtleUBjb21jYXN0Lm5ldA==
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




> On Fri, Jul 09, 2004 at 04:36:14PM +0000, jmerkey@comcast.net wrote:
> 
>  > > Do you create a subdirectory for every user?  
>  > Yes.  Snort creates a subdirectory for each IP address identified as 
> generation an attack
>  > or alert.  This number can get very large, BTW.
> 
> The last time I looked at snort it created a tcpdump capture file of the
> days activity.  I remember seeing the behaviour you describe in an earlier
> release, so either you have an old version (which you should probably
> update given snort's sketchy security hole history), 

This is the lastest 2.1.3 version they are posting.  

or theres a configuration
> option that you might be able to fiddle with to get it to work in capture-file
> mode.
> 

not using capture file mode for this instantiation.  Sooner or later EXT(whatever) should
handle more than 32000 files in a single directory.   I will submit a patch to Andi and 
Andreas to review with this change.  May make some sense.  Since most folks install Linux 
on a clean system and really are not doing a lot of cross compatible FS swapping of 
hard drives, it really should be low impact if a system uses on-disk structures that 
are larger, provided they are not downgrading their system to an older kernel.  Using a
different partition type may be the easiest way to do this without casuing breakage across
linux kernels and EXT versions.

Jeff

> Either way, it's got to be easier than hacking ext3 code 8)
> 
> 		Dave
> 
