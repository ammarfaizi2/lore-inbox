Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263752AbTHFOiQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 10:38:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263875AbTHFOiQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 10:38:16 -0400
Received: from host81-136-142-241.in-addr.btopenworld.com ([81.136.142.241]:8150
	"EHLO mx.homelinux.com") by vger.kernel.org with ESMTP
	id S263752AbTHFOiL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 10:38:11 -0400
Date: Wed, 6 Aug 2003 15:38:02 +0100 (BST)
From: Mitch@0Bits.COM
X-X-Sender: mitch@mx.homelinux.com
Reply-To: Mitch@0Bits.COM
To: Erik Andersen <andersen@codepoet.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.22-pre10-ac1 DRI doesn't work with
Message-ID: <Pine.LNX.4.53.0308061521430.22986@mx.homelinux.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Hits: -0.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I think with the new vmap changes that went in in -pre7 means
you will need to get a new drm module (like from X cvs or
http://dri.sourceforge.net/downloads.phtml) and recompile it
with the new kernel headers which will then pick up the define
-DVMAP_4_ARGS in the Makefile and give you a good module that works.

The DRI kernel trees need updating.

Can you download from the link above and cd to drm and do a

	make -f Makefile.linux radeon.o

and report please if that works for you without crashing glx* ?

Mitch

-------- Original Message --------
Subject: Re: Linux 2.4.22-pre10-ac1 DRI doesn't work with
Date: Tue, 5 Aug 2003 14:36:49 -0600
From: Erik Andersen <andersen:codepoet:org>
Reply-To: andersen:codepoet:org
To: Mitch@0Bits.COM
CC: linux-kernel@vger.kernel.org
References: <Pine.LNX.4.53.0308052032220.31114@mx.homelinux.com>

On Tue Aug 05, 2003 at 08:37:38PM +0100, Mitch@0Bits.COM wrote:
>
> Works fine with XFree86 4.3.x, 2.4.22-pre10 and the radeon.o
> drm module. If you look backwards in your strace file, what is the
> device that file descriptor 5 belongs to ?

I have XFree86 4.2.1 (i.e. xfree86-common, xserver-xfree86,
xlibmesa3-gl, etc) version 4.2.1-9 from Debian unstable installed.

I think you mean file descriptor 4:
    open("/dev/dri/card0", O_RDWR)          = 4

$ ls -la /dev/dri/card0
crw-rw-rw-    1 root     root     226,   0 Jul 12 04:21 /dev/dri/card0

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--

