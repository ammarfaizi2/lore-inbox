Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262424AbUKQSAA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262424AbUKQSAA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 13:00:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262443AbUKQR7l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 12:59:41 -0500
Received: from mail.euroweb.hu ([193.226.220.4]:46982 "HELO mail.euroweb.hu")
	by vger.kernel.org with SMTP id S262427AbUKQR4w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 12:56:52 -0500
To: nikita@clusterfs.com
CC: greg@kroah.com, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
In-reply-to: <16795.33515.187015.492860@thebsh.namesys.com> (message from
	Nikita Danilov on Wed, 17 Nov 2004 19:57:15 +0300)
Subject: Re: [PATCH] [Request for inclusion] Filesystem in Userspace
References: <E1CToBi-0008V7-00@dorka.pomaz.szeredi.hu>
	<Pine.LNX.4.58.0411151423390.2222@ppc970.osdl.org>
	<E1CTzKY-0000ZJ-00@dorka.pomaz.szeredi.hu>
	<84144f0204111602136a9bbded@mail.gmail.com>
	<E1CU0Ri-0000f9-00@dorka.pomaz.szeredi.hu>
	<20041116120226.A27354@pauline.vellum.cz>
	<E1CU3tO-0000rV-00@dorka.pomaz.szeredi.hu>
	<20041116163314.GA6264@kroah.com>
	<E1CURx6-0005Qf-00@dorka.pomaz.szeredi.hu> <16795.33515.187015.492860@thebsh.namesys.com>
Message-Id: <E1CUU2P-0005g4-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 17 Nov 2004 18:56:13 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> /sys/fs used to exist for for some. Moreover, /sys/fs/foofs/ was added
> automagically when foofs file system type was registered. But it was
> ultimately removed, because nobody took the time to fix all races
> between accessing /sys/fs/foofs/gadget and
> umount/filesystem-module-unloading. 

I don't see why this would be any harder for filesystem code than for
other types of drivers.  Maybe someone can enlighten me.

Anyway, I can try to clean it up: remove all the racy bits and keep
what I need (which is mainly just the /sys/fs directory).  Where can I
find the most recent version of this?

Thanks,
Miklos
