Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262571AbTIJQIZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 12:08:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264981AbTIJQIZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 12:08:25 -0400
Received: from nwkea-mail-1.sun.com ([192.18.42.13]:3746 "EHLO
	nwkea-mail-1.sun.com") by vger.kernel.org with ESMTP
	id S262571AbTIJQIX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 12:08:23 -0400
Message-Id: <200309101608.h8AG8J101998@brk-mail1.uk.sun.com>
Date: Wed, 10 Sep 2003 17:08:19 +0100 (BST)
From: Marco Bertoncin - Sun Microsystems UK - Platform OS
	 Development Engineer <Marco.Bertoncin@Sun.COM>
Reply-To: Marco Bertoncin - Sun Microsystems UK - Platform
	   OS Development Engineer <Marco.Bertoncin@Sun.COM>
Subject: Re: NFS/MOUNT/sunrpc problem?
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Content-MD5: ZZIIIE0shNuxctY5B4XrEA==
X-Mailer: dtmail 1.3.0 @(#)CDE Version 1.4.6_06 SunOS 5.8 sun4u sparc 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



I just realized I sent my reply only to Alan ... sorry!


------------- Begin Forwarded Message -------------

Date: Wed, 10 Sep 2003 17:02:24 +0100 (BST)
From: Marco Bertoncin - Sun Microsystems UK - Platform OS Development Engineer 
<mb144209@ms-ebrk02-02.uk>
Subject: Re: NFS/MOUNT/sunrpc problem?
To: alan@lxorguk.ukuu.org.uk



Alan,
thanks for replying so quickly!

> Update the kernel once installed, the 2.4.18- kernels are obsoleted by
> other security fixes

Yes, we are working with several versions (rh-8.0, rh-9.0, as2.1, el3.0a2), and 
would like to support all of them. If this was for internal use, we would just 
go to the most up-to-date version, but sometimes customers are reluctant to 
upgrade (don't ask, I am not a marketing person :-))))

> 
> I've seen one other report of this (with a via chip),
>

This is with Intel82801CA

 
> Are you using NFS root or just NFS mounts ?

Just NFS mounts. This is how we do PXE install: download vmlinuz and an initial 
initrd.img image. vmlinuz uncompresses, allocates a RAM disk and mounts 
initrd.img where it finds the modules necessary to carry on (tg3 driver amongst 
them), then it nfs mount a directory from the install server (something like 
/tftp/install/this_release/images/ where it would find configurastion files and 
images for the install) and it is this MOUNT request that, if the reply gets 
lost, starts the storm.
You said you already saw a similar report of this. Is this logged somewhere?

Again, Thanks very much.
Marco


------------- End Forwarded Message -------------


