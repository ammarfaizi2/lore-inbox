Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281289AbRKTTmr>; Tue, 20 Nov 2001 14:42:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281284AbRKTTme>; Tue, 20 Nov 2001 14:42:34 -0500
Received: from hera.cwi.nl ([192.16.191.8]:7087 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S281288AbRKTTlf>;
	Tue, 20 Nov 2001 14:41:35 -0500
From: Andries.Brouwer@cwi.nl
Date: Tue, 20 Nov 2001 19:41:33 GMT
Message-Id: <UTC200111201941.TAA317995.aeb@cwi.nl>
To: hpa@zytor.com, linux-kernel@vger.kernel.org
Subject: Re: Linux can use a mountpoint for 2 Filesystems
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hpa:

> There are real reasons to overmount a filesystem.  It's getting to be
> a usability problem, probably because Linux (UNLIKE MOST OTHER UNIXES)
> didn't allow it until just recently.  This change caused some
> problems, including with the automount daemon.  I would like to see an
> option to mount(8) to allow it, by default disallow by policy.

mount(8) does not necessarily have such information:
/etc/mtab is just a random file with random contents,
and /proc/mounts need not exist.

The cleanest way to do what you suggest would be to make the kernel
refuse an overmount unless the mount(2) flags included the
"overmount" flag.

Andries

