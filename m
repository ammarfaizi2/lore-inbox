Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315720AbSIIWdw>; Mon, 9 Sep 2002 18:33:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318987AbSIIWdC>; Mon, 9 Sep 2002 18:33:02 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:4458 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S318973AbSIIWcF>; Mon, 9 Sep 2002 18:32:05 -0400
From: Alan Cox <alan@redhat.com>
Message-Id: <200209092236.g89MamX04399@devserv.devel.redhat.com>
Subject: Re: 2.4.20-pre5-ac4 hda lost interrupt
To: ken@kenmoffat.uklinux.net (Ken Moffat)
Date: Mon, 9 Sep 2002 18:36:48 -0400 (EDT)
Cc: alan@redhat.com (Alan Cox), linux-kernel@vger.kernel.org (lkml)
In-Reply-To: <Pine.LNX.4.21.0209092242240.32665-100000@ppg_penguin.linux.bogus> from "Ken Moffat" at Sep 09, 2002 10:59:49 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thats a known problem with the new code. We decide how to handle simplex
devices before we actually get around to checking if there are drives
on it. As a result we disable DMA on them all.

The timeout is interesting in itself. Does it go away if you disable
IDE taskfile I/O ?
