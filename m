Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966260AbWKTRcx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966260AbWKTRcx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 12:32:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966263AbWKTRcx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 12:32:53 -0500
Received: from mail.parknet.jp ([210.171.160.80]:35846 "EHLO parknet.jp")
	by vger.kernel.org with ESMTP id S966260AbWKTRcv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 12:32:51 -0500
X-AuthUser: hirofumi@parknet.jp
To: The Peach <smartart@tiscali.it>
Cc: linux-kernel@vger.kernel.org
Subject: Re: bug? VFAT copy problem
References: <20061120164209.04417252@localhost>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Tue, 21 Nov 2006 02:32:43 +0900
In-Reply-To: <20061120164209.04417252@localhost> (The Peach's message of "Mon\, 20 Nov 2006 16\:42\:09 +0100")
Message-ID: <877ixqhvlw.fsf@duaron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The Peach <smartart@tiscali.it> writes:

> I've recently found a problem with the VFAT module.
> I'm working on a gentoo box with kernel 2.6.17 gentoo patched (recently upgraded from 2.6.15)
>
> I've got a samba share on a reiser partition and a daily cron will copy its content to an external usb disk with vfat file system. The copy is done via bash scripting and some checks are done before mirroring the files.
> btw _some_ random files are copied lowering all chars in the file name.

I couldn't reproduce this for now. Could you tell mount options which
you used? and after mount, "cat /proc/mounts", please.

> Here is an example:
>
> # pwd
> /home/b/dir
> # ls -l
> -rwxr-xr-x 1 b users 676389 Aug 10  2004 DSCN5967(1).JPG
> -rwxr-xr-x 1 b users 710090 Aug 10  2004 DSCN5968(1).JPG
> -rwxr-xr-x 1 b users 732903 Aug 10  2004 DSCN5981.JPG.rem.2006-10-27-1543 
> -rwxr-xr-x 1 b users 622595 Aug 10  2004 DSCN5982.JPG.rem.2006-10-27-1543 
> # cp -v * /mnt/iomega/dir/ 
> `DSCN5967(1).JPG' -> `/mnt/iomega/dir/DSCN5967(1).JPG' 
> `DSCN5968(1).JPG' -> `/mnt/iomega/dir/DSCN5968(1).JPG' 
> `DSCN5981.JPG.rem.2006-10-27-1543' -> `/mnt/iomega/dir/DSCN5981.JPG.rem.2006-10-27-1543'
> `DSCN5982.JPG.rem.2006-10-27-1543' -> `/mnt/iomega/dir/DSCN5982.JPG.rem.2006-10-27-1543' 
> # ls -l /mnt/iomega/dir/ 
> total 2784 
> -rwxr-xr-x 1 b users 676389 Oct 27 16:55 DSCN5967(1).JPG 
> -rwxr-xr-x 1 b users 710090 Oct 27 16:55 DSCN5968(1).JPG 
> -rwxr-xr-x 1 b users 732903 Oct 27 16:55 dscn5981.jpg.rem.2006-10-27-1543 
> -rwxr-xr-x 1 b users 622595 Oct 27 16:55 dscn5982.jpg.rem.2006-10-27-1543
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
