Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267977AbUGaRcd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267977AbUGaRcd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Jul 2004 13:32:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267976AbUGaRcd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Jul 2004 13:32:33 -0400
Received: from mail.euroweb.hu ([193.226.220.4]:35298 "HELO mail.euroweb.hu")
	by vger.kernel.org with SMTP id S267977AbUGaRcc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Jul 2004 13:32:32 -0400
To: smfrench@austin.rr.com
CC: rddunlap@osdl.org, linux-kernel@vger.kernel.org
In-reply-to: <1091287308.2337.6.camel@smfhome.smfdom> (message from Steve
	French on Sat, 31 Jul 2004 10:21:48 -0500)
Subject: Re: uid of user who mounts
References: <1091239509.3894.11.camel@smfhome.smfdom>
	 <20040730190825.7a447429.rddunlap@osdl.org>
	 <1091244841.2742.8.camel@smfhome1.smfdom>
	 <E1BqqGd-0004fX-00@dorka.pomaz.szeredi.hu> <1091287308.2337.6.camel@smfhome.smfdom>
Message-Id: <E1Bqxhg-0004pi-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Sat, 31 Jul 2004 19:31:28 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Steve French wrote:
>
> I confirmed what Randy had mantioned about the user= entries in mtab
> allowing umounts (at least it works that way for a few of the local
> filesystems I tried) but did not seem to work so well on other
> filesystems - I had odd results on umounting my cifs mounts e.g. - after
> adding at mount time "user=someuser" to /etc/mtab (by a minor change to
> the mount helper mount.cifs.c, when running mount.cifs suid).  umount of
> those mounts failed

I've seen failure to unmount only if there is no matching entry in
/etc/fstab.  It sounds a bit too much paranoia, but who knows.

Miklos
