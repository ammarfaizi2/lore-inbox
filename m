Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136543AbRD3X2e>; Mon, 30 Apr 2001 19:28:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136544AbRD3X2Z>; Mon, 30 Apr 2001 19:28:25 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:62725 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S136543AbRD3X2P>; Mon, 30 Apr 2001 19:28:15 -0400
Subject: Re: 2.4.x APM interferes with FA311TX/natsemi.o
To: komarek@andrew.cmu.edu (Paul Komarek)
Date: Tue, 1 May 2001 00:32:11 +0100 (BST)
Cc: linux-kernel@vger.kernel.org, ross@willow.seitz.com,
        komarek@andrew.cmu.edu
In-Reply-To: <Pine.LNX.4.21L.0104260037320.17383-100000@unix49.andrew.cmu.edu> from "Paul Komarek" at Apr 26, 2001 12:51:53 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14uN9K-0000fb-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> When the call
>   apm_bios_call_simple(APM_FUNC_SET_STATE, 0x100, APM_STATE_READY, &eax)
> is made, the PMEEN (PME enable) bit in the CCSR register on my FA311
> mysteriously changes from 0 to 1, causing the card to stop processing

The Linux driver set the power management of the card off. The BIOS then 
rudely fiddled with it. If its not a laptop seriously consider just turning
off APM support. The Linux idle loop halts will do a fair job of power
saving anyway
