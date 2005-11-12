Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964826AbVKLWRf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964826AbVKLWRf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Nov 2005 17:17:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932503AbVKLWRf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Nov 2005 17:17:35 -0500
Received: from pfepa.post.tele.dk ([195.41.46.235]:32624 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S932353AbVKLWRe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Nov 2005 17:17:34 -0500
Date: Sat, 12 Nov 2005 23:19:04 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: anil dahiya <ak_ait@yahoo.com>
Cc: linux-kernel@vger.kernel.org, kernelnewbies@nl.linux.org
Subject: Re: making makefile for 2.6 kernel
Message-ID: <20051112221904.GA10228@mars.ravnborg.org>
References: <20051112011006.GD7991@shell0.pdx.osdl.net> <20051112151652.83848.qmail@web60221.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051112151652.83848.qmail@web60221.mail.yahoo.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 12, 2005 at 07:16:52AM -0800, anil dahiya wrote:
> Hi 
> I want to makefile for my kernel module..
> 1.c 2.c 3.c files are places in /home/anil folder but
> these files contain .h (hearder)files from 3 different
> directory 1) /home/include 2) /root/incluent 3)
> /opt/include
> 
> can u suggest me a makefile to generate a common
> module target.ko using these .C and .h files.

Makefile
obj-m := foo.o
foo-y := 1.o 2.o 3.o

EXTRA_CFLGAS := -I/home/include -I/root/incluent -I/opt/include


And then build the module with:
make -C $KERNEL_SRC M=`pwd`

See Documentation/kbuild/makefiles.txt for reference.
Note: Kernel being pointed out must be a fully build kernel

	Sam
