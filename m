Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261721AbVEWORC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261721AbVEWORC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 May 2005 10:17:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261733AbVEWORC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 May 2005 10:17:02 -0400
Received: from rev.193.226.233.9.euroweb.hu ([193.226.233.9]:10250 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S261721AbVEWOQ7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 May 2005 10:16:59 -0400
To: blaisorblade@yahoo.it
CC: user-mode-linux-devel@lists.sourceforge.net, eric.begot@gmail.com,
       jdike@addtoit.com, akpm@osdl.org, linux-kernel@vger.kernel.org
In-reply-to: <200505231609.48425.blaisorblade@yahoo.it> (message from
	Blaisorblade on Mon, 23 May 2005 16:09:47 +0200)
Subject: Re: [uml-devel] [PATCH] UML - 2.6.12-rc4-mm2 Compile error
References: <200505201436.j4KEZxjh006235@ccure.user-mode-linux.org> <4290E1C6.9070709@gmail.com> <200505231609.48425.blaisorblade@yahoo.it>
Message-Id: <E1DaDj3-0002Xf-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 23 May 2005 16:16:13 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Here is a patch to correct a compile error on linux 2.6.12-rc4-mm2 for uml.
> > At the compilation of init/main.c, it complains because it doens't find
> > the 2 constants FIXADDR_USER_START and FIXADDR_USER_END
> Why deleting FIXADDR_START? Also FIXADDR_USER_* are defined, just in a 
> different way (and the patch below is IIRC uncorrect).

I've seen this error too after 'make menuconfig ARCH=um' on a clean
tree.

The following fixes it:

  cp .config /tmp
  make mrproper ARCH=um
  cp /tmp/.config .
  make ARCH=um

So there's definitely something wrong with the build on UML.

Miklos
