Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965052AbWHQREy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965052AbWHQREy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 13:04:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965056AbWHQREx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 13:04:53 -0400
Received: from websiteout12.httpserveur.net ([67.15.80.77]:50053 "HELO
	websiteout12.httpserveur.net") by vger.kernel.org with SMTP
	id S965052AbWHQREw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 13:04:52 -0400
X-Abuse: Please report all abuse immediately to abuse@httpserveur.net
Subject: Re: New version of ClownToolKit
From: clowncoder <clowncoder@clowncode.net>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Sam Ravnborg <sam@ravnborg.org>, 7eggert@gmx.de,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.61.0608170945410.16217@yvahk01.tjqt.qr>
References: <6Kxx5-7PT-7@gated-at.bofh.it> <6KyCM-1w7-1@gated-at.bofh.it>
	 <E1GDUcG-00016M-Nu@be1.lrz> <20060817044228.GA16320@mars.ravnborg.org>
	 <Pine.LNX.4.61.0608170945410.16217@yvahk01.tjqt.qr>
Content-Type: text/plain; charset=utf-8
Date: Thu, 17 Aug 2006 19:04:49 +0200
Message-Id: <1155834289.3673.21.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le jeudi 17 août 2006 à 09:47 +0200, Jan Engelhardt a écrit :
> >> > LIBDIR=/lib/modules/`uname -r`
> >> > make -C $LIBDIR/source O=$LIBDIR/build SUBDIRS=`pwd` modules
> >> > 
> >> > For a normal kernel installation this will do the right thing.
> >> > source points to the kernel source and build point to the output
> >> > directory (they are often equal but not always).
> >> 
> >> Please don't tell module authors to unconditionally use `uname -r`.
> >> I frequently build kernels for differentd hosts, and if I don't, I'll
> >> certainly compile the needed modules before installing the kernel.
> >> Therefore /lib/modules/`uname -r` is most certainly the completely
> >> wrong place to look for the kernel source.
> >
> >/lib/modules/`uname -r` is the general solution that works for most
> >people and should be at least default. It is certainly better than
> >/usr/src/linux.
> >But yes they better make it override able.
> 
> In some outoftree modules of mine, the Makefile reads like this
> 
> MODULES_DIR := /lib/modules/$(shell uname -r)
> KSRC_DIR    := ${MODULES_DIR}/source
> KOBJ_DIR    := ${MODULES_DIR}/build
> 
> all: modules
> modules:
> 	make -C "${KOBJ_DIR}" M="$$PWD";
> 
> and one can easily override it by calling `make MODULES_DIR=/foo/bar` 
> (instead of just `make`).
> 
> 
> Jan Engelhardt

Thank you all for all those tips, I will use this last one.

Vincent Perrier

