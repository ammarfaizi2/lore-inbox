Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262214AbVG0MLs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262214AbVG0MLs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 08:11:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262222AbVG0MLc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 08:11:32 -0400
Received: from 238-071.adsl.pool.ew.hu ([193.226.238.71]:31754 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S262214AbVG0MJb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 08:09:31 -0400
To: akpm@osdl.org, sam@ravnborg.org
CC: linux-kernel@vger.kernel.org
In-reply-to: <20050727024330.78ee32c2.akpm@osdl.org> (message from Andrew
	Morton on Wed, 27 Jul 2005 02:43:30 -0700)
Subject: Re: 2.6.13-rc3-mm2 (kbuild broken for external modules)
References: <20050727024330.78ee32c2.akpm@osdl.org>
Message-Id: <E1DxkiX-0001FB-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 27 Jul 2005 14:08:57 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  git-kbuild.patch

This breaks building of external modules:

   make -C /usr/src/linux-2.6.13-rc3-mm2 M=/home/miko/fuse/kernel modules
   make[1]: Entering directory `/usr/src/linux-2.6.13-rc3-mm2'
   
     WARNING: Symbol version dump /usr/src/linux-2.6.13-rc3-mm2/Module.symvers
              is missing; modules will have no dependencies and modversions.
   
   scripts/Makefile.build:14: /usr/src/linux-2.6.13-rc3-mm2//home/miko/fuse/kernel/Makefile: No such file or directory
   make[2]: *** No rule to make target `/usr/src/linux-2.6.13-rc3-mm2//home/miko/fuse/kernel/Makefile'.  Stop.
   make[1]: *** [_module_/home/miko/fuse/kernel] Error 2
   make[1]: Leaving directory `/usr/src/linux-2.6.13-rc3-mm2'
   make: *** [all-spec] Error 2

Miklos
