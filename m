Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263167AbSIPWRP>; Mon, 16 Sep 2002 18:17:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263170AbSIPWRP>; Mon, 16 Sep 2002 18:17:15 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:15367 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S263167AbSIPWRO>; Mon, 16 Sep 2002 18:17:14 -0400
From: Alan Cox <alan@redhat.com>
Message-Id: <200209162222.g8GMMAD28467@devserv.devel.redhat.com>
Subject: Re: [PATCH] Experimental IDE oops dumper v0.1
To: vojtech@suse.cz (Vojtech Pavlik)
Date: Mon, 16 Sep 2002 18:22:10 -0400 (EDT)
Cc: alan@redhat.com (Alan Cox), rusty@rustcorp.com.au (Rusty Russell),
       linux-kernel@vger.kernel.org
In-Reply-To: <20020916215255.A60197@ucw.cz> from "Vojtech Pavlik" at Sep 16, 2002 09:52:55 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > to do for legacy free cases but the other bits like LBA48 and retuning
> > probably can be handled with some small chipset specific hooks
> 
> Retuning not needed, LBA48 might be needed. Not sure about LBA48 in PIO
> mode, it might work even without chipset support - it's usually the
> LBA48+DMA combination that confuses the chips.

Well we know if it wont work pretty easily, but we need the dump code
LBA48 aware otherwise a dump on the end of the disk may end up dumping
on the wrong part if it wraps - again could be detected
