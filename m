Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261989AbUKVIhm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261989AbUKVIhm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 03:37:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261988AbUKVIhl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 03:37:41 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:6111 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S261990AbUKVIhF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 03:37:05 -0500
Date: Mon, 22 Nov 2004 09:36:15 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Adrian Bunk <bunk@stusta.de>
cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] Use -ffreestanding? (fwd)
In-Reply-To: <20041122054959.GI3007@stusta.de>
Message-ID: <Pine.LNX.4.53.0411220934480.21333@yvahk01.tjqt.qr>
References: <20041122054959.GI3007@stusta.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Hi Andrew,
>
>for the kernel, it would be logical to use -ffreestanding. The kernel is
>not a hosted environment with a standard C library.

Note the GCC docs:

Assert that compilation takes place in a freestanding environment. This
implies -fno-builtin. [...]

This will break a lot of code, since there are many thing that depend upon GCC
builtin magic AFAICS.

(BTW, seems to be supported by GCC 3.3.0 too, because that manpage is packaged
together with gcc-3.3.rpm (suse 9.x))



Jan Engelhardt
-- 
Gesellschaft für Wissenschaftliche Datenverarbeitung
Am Fassberg, 37077 Göttingen, www.gwdg.de
