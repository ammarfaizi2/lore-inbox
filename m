Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274506AbRITOOA>; Thu, 20 Sep 2001 10:14:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274508AbRITONu>; Thu, 20 Sep 2001 10:13:50 -0400
Received: from anchor-post-32.mail.demon.net ([194.217.242.90]:49419 "EHLO
	anchor-post-32.mail.demon.net") by vger.kernel.org with ESMTP
	id <S274506AbRITONn>; Thu, 20 Sep 2001 10:13:43 -0400
Subject: Re: NTFS--MOUNTING PROBLEM
From: Richard Russon <ntfs@flatcap.org>
To: csaradap <csaradap@mihy.mot.com>
Cc: lkml <linux-kernel@vger.kernel.org>,
        linux-india-help@lists.sourceforge.net
In-Reply-To: <3BA9DE60.2511DB44@mihy.mot.com>
In-Reply-To: <3BA9DE60.2511DB44@mihy.mot.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Evolution-Format: text/plain
X-Mailer: Evolution/0.13.99+cvs.2001.09.19.21.54 (Preview Release)
Date: 20 Sep 2001 15:12:30 +0100
Message-Id: <1000995161.7530.59.camel@home.flatcap.org>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> I have installed Red Hat 7.1 from PCQ, and my disk shares NT with LINUX.
> By default I think NTFS file support was not installed, so i recompiled
> the kernel with that support selected. But still it is giving that
> NTFS not suppoted

The best place to start is /proc/filesystems   This lists all the
filesystem types that the kernel knows about.

When you compliled the kernel did you enable NTFS as an inline part
of the kernel "Y" or a loadable module "M"?

If it's part of the kernel, then you should copy the kernel to /boot
edit /etc/lilo.conf, run lilo and reboot.

If you're using modules, then as root, "make modules_install" from
the kernel source tree and "modprobe ntfs".  If that succeeds then
"lsmod" should show something like:
    Module    Size  Used by
    ntfs     47152   0  (unused)

If this doesn't help, try reading the Kernel HOWTO:

  http://www.linuxdoc.org/HOWTO/Kernel-HOWTO.html

Cheers,
  FlatCap (Rich)
  ntfs@flatcap.org


