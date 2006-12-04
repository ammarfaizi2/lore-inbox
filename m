Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965885AbWLDU1z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965885AbWLDU1z (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 15:27:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937356AbWLDU1z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 15:27:55 -0500
Received: from mail.kolumbus.fi ([193.229.0.46]:34405 "EHLO mail.kolumbus.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S937380AbWLDU1y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 15:27:54 -0500
From: Janne Karhunen <Janne.Karhunen@gmail.com>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Subject: Re: Mounting NFS root FS
Date: Mon, 4 Dec 2006 22:27:43 +0200
User-Agent: KMail/1.9.5
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>, MrUmunhum@popdial.com,
       linux-kernel@vger.kernel.org
References: <4571CE06.4040800@popdial.com> <200612041912.30527.Janne.Karhunen@gmail.com> <Pine.LNX.4.61.0612042100570.29300@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0612042100570.29300@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612042227.43751.Janne.Karhunen@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 04 December 2006 22:03, Jan Engelhardt wrote:

> >> 2) NFS provides persistent storage.
> >
> >To me this sounds like a chicken and an egg problem. It
> >both depends and provides this at the same time :/. But
> >hey, if it's supposed to work then OK.
>
> Way 1:
>
> mount -nt tmpfs none /var/lib/nfs;
> mount -nt nfs fserve:/tftpboot/linux /mnt;
> mount -n --move /var/lib/nfs /mnt/var/lib/nfs/;
> ./run_init -c /mnt /sbin/init; # or similar

Statd should probably be started before nfs mount to get it 
right. But doesn't statd require state data ( some sort of 
generation number ) from persistent storage to work? This 
would start with a blank slate.


-- 
// Janne
