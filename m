Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261650AbVFVQqy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261650AbVFVQqy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 12:46:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261665AbVFVQqx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 12:46:53 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:1708 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S261650AbVFVQqI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 12:46:08 -0400
Subject: Re: -mm -> 2.6.13 merge status (fuse)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Eric Van Hensbergen <ericvh@gmail.com>
Cc: Pavel Machek <pavel@ucw.cz>, Miklos Szeredi <miklos@szeredi.hu>,
       akpm@osdl.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <a4e6962a050622085021cdfb9d@mail.gmail.com>
References: <20050620235458.5b437274.akpm@osdl.org>
	 <E1Dkfu2-0005Ju-00@dorka.pomaz.szeredi.hu>
	 <20050621142820.GC2015@openzaurus.ucw.cz>
	 <E1DkkRE-0005mt-00@dorka.pomaz.szeredi.hu>
	 <20050621220619.GC2815@elf.ucw.cz>
	 <a4e6962a05062207435dd16240@mail.gmail.com>
	 <20050622150839.GB1881@elf.ucw.cz>
	 <a4e6962a050622085021cdfb9d@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1119458579.11528.93.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 22 Jun 2005 17:43:00 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 1) only allow user's to mount/bind on directories/files where they
> have unconditional write access.

Like say /tmp. Build a bizarre behaving /tmp and I can do funky stuff
with some third party suid apps. Its a good start but you probably want
a stronger policy and one enforced by the user space side not kernel (eg
"Below ~")

> 2) enforce NOSUID mount options on user-mounts

2 is unneccessarily crude. Just enforce suid owner/owner group. 

Alan

