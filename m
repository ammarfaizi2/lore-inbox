Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318318AbSHPLby>; Fri, 16 Aug 2002 07:31:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318320AbSHPLby>; Fri, 16 Aug 2002 07:31:54 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:18416 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S318318AbSHPLbx>; Fri, 16 Aug 2002 07:31:53 -0400
Date: Fri, 16 Aug 2002 13:35:46 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Alan Cox <alan@redhat.com>, Andre Hedrick <andre@linux-ide.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.20-pre2-ac3
In-Reply-To: <200208151918.g7FJI6J04061@devserv.devel.redhat.com>
Message-ID: <Pine.NEB.4.44.0208161332150.6334-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Aug 2002, Alan Cox wrote:

>...
> Linux 2.4.20-pre2-ac3
> o	IDE updates					(Andre Hedrick)
>...

drivers/ide/ide.c no longer exports do_ide_request and
ide_add_generic_settings but they are still needed by
drivers/ide/ide-probe-mod.c:

<--  snip  -->

...
depmod: *** Unresolved symbols in
/lib/modules/2.4.20-pre2-ac3/kernel/drivers/ide/ide-probe-mod.o
depmod:         do_ide_request
depmod:         ide_add_generic_settings
...

<--  snip   -->

cu
Adrian

-- 

You only think this is a free country. Like the US the UK spends a lot of
time explaining its a free country because its a police state.
								Alan Cox




