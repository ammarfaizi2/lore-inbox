Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272818AbRJaAIz>; Tue, 30 Oct 2001 19:08:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273888AbRJaAIr>; Tue, 30 Oct 2001 19:08:47 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:54537 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S272818AbRJaAIl>; Tue, 30 Oct 2001 19:08:41 -0500
Subject: Re: [PATCH] init/main.c/root_dev_names - another one #ifdef
To: zzz@cd-club.ru (Denis Zaitsev)
Date: Wed, 31 Oct 2001 00:15:10 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
In-Reply-To: <20011031045353.A22507@zzz.zzz.zzz> from "Denis Zaitsev" at Oct 31, 2001 04:53:54 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15yj2E-0001o7-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The idea is to include the SCSI disk's names into the list only if we
> compile the kernel with the corresponding support.  It's not very
> serious patch, but to put the things in order...  Linus, please, apply
> it.

It took that out deliberately a few months back. The ifdefs in fact
break stuff

Firstly the array is __init so is discarded on boot

Secondly if you have an initrd containing the scsi driver layers then you
can specify root=sda quite legitimately.


Alan
