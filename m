Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966358AbWLDUEs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966358AbWLDUEs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 15:04:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966359AbWLDUEr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 15:04:47 -0500
Received: from mailer.gwdg.de ([134.76.10.26]:55770 "EHLO mailer.gwdg.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S966358AbWLDUEq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 15:04:46 -0500
Date: Mon, 4 Dec 2006 21:03:09 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Janne Karhunen <Janne.Karhunen@gmail.com>
cc: Trond Myklebust <trond.myklebust@fys.uio.no>, MrUmunhum@popdial.com,
       linux-kernel@vger.kernel.org
Subject: Re: Mounting NFS root FS
In-Reply-To: <200612041912.30527.Janne.Karhunen@gmail.com>
Message-ID: <Pine.LNX.4.61.0612042100570.29300@yvahk01.tjqt.qr>
References: <4571CE06.4040800@popdial.com> <24c1515f0612040351p6056101frc12db8eb86063213@mail.gmail.com>
 <1165246177.711.179.camel@lade.trondhjem.org> <200612041912.30527.Janne.Karhunen@gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>> 2) NFS provides persistent storage.
>
>To me this sounds like a chicken and an egg problem. It 
>both depends and provides this at the same time :/. But 
>hey, if it's supposed to work then OK.

Way 1:

mount -nt tmpfs none /var/lib/nfs;
mount -nt nfs fserve:/tftpboot/linux /mnt;
mount -n --move /var/lib/nfs /mnt/var/lib/nfs/;
./run_init -c /mnt /sbin/init; # or similar

And you can also start locking after pivot_rooting to /mnt, that would 
not even require (/mnt)/var/lib/nfs to be a separate mount.


Ok, did I miss it all?


	-`J'
-- 
