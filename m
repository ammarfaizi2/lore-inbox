Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S130007AbQK1CLh>; Mon, 27 Nov 2000 21:11:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S130195AbQK1CL1>; Mon, 27 Nov 2000 21:11:27 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:2823 "EHLO
        neon-gw.transmeta.com") by vger.kernel.org with ESMTP
        id <S130127AbQK1CLP>; Mon, 27 Nov 2000 21:11:15 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: KERNEL BUG: console not working in linux
Date: 27 Nov 2000 17:40:58 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <8vv2fa$7n6$1@cesium.transmeta.com>
In-Reply-To: <E140Pc3-0003AI-00@the-village.bc.nu> <8vubeq$r5r$1@cesium.transmeta.com> <20001127202738.A25168@vana.vc.cvut.cz> <20001128023652.A9368@veritas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2000 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20001128023652.A9368@veritas.com>
By author:    Andries Brouwer <aeb@veritas.com>
In newsgroup: linux.dev.kernel
> 
> What about adding an additional
> 
> 	andb	$0xfe, %al
> 
> in front of the outb?
> If I understand things correctly, bit 0 of 0x92 is write-only
> on some hardware, and writing 1 to it causes a reset, so we
> never want that.
> 

Already in test12-pre1.  Admittedly, this bit is defined to always
read back as 0, but this is the PC architecture (using the term *very*
loosely here!!!) we're talking about.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
