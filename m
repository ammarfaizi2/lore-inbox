Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262468AbUDKU0y (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Apr 2004 16:26:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262473AbUDKU0y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Apr 2004 16:26:54 -0400
Received: from pfepc.post.tele.dk ([195.41.46.237]:3688 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S262468AbUDKU0x
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Apr 2004 16:26:53 -0400
Date: Sun, 11 Apr 2004 22:33:16 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Axel Weiss <aweiss@informatik.hu-berlin.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernelversion distinction (was 2.6.5 - incomplete headers?)
Message-ID: <20040411203315.GA2170@mars.ravnborg.org>
Mail-Followup-To: Axel Weiss <aweiss@informatik.hu-berlin.de>,
	linux-kernel@vger.kernel.org
References: <200404111327.19744.aweiss@informatik.hu-berlin.de> <40793189.3070403@portrix.net> <200404112033.20025.aweiss@informatik.hu-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200404112033.20025.aweiss@informatik.hu-berlin.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> Any improvements? Up to which kernel version should old style make be used?

You cannot use same Makefile for both 2.4 and 2.6?

Using the syntax:
make -C $KERNELSRC SUBDIRS=$PWD modules

should allow you to do that if there is no special requirements.
The Makefile should be an ordinary kbuild Makefile in this case:

obj-m := module.o
module-objs := mod1.o mod2.o
etc..

Another approach would be to keep two Makefiles, one for 2.4, another
for 2.6. Default could be Makefile (for 2.6) and Makefile.24 for older kernels.
This makes much less conditionals.

	Sam
