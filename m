Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130190AbQKFT5v>; Mon, 6 Nov 2000 14:57:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130000AbQKFT5m>; Mon, 6 Nov 2000 14:57:42 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:31748 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129990AbQKFT5f>; Mon, 6 Nov 2000 14:57:35 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: setup.S: A20 enable sequence (once again)
Date: 6 Nov 2000 11:56:04 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <8u72ck$7i1$1@cesium.transmeta.com>
In-Reply-To: <00110618083400.11022@rob>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2000 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <00110618083400.11022@rob>
By author:    Robert Kaiser <rob@sysgo.de>
In newsgroup: linux.dev.kernel
> 
> The attached patch fixes this by doing "fast A20" enable first and then
> checking if A20 already is enabled. If it is, the keyboard controller sequence
> is skipped. This works for me, so, could people please have a look at this.
> 

I just looked at the code, and it's worse than I first thought: if
memory location 0x200 happens to contain 0x0001 when the kernel is
entered, this code with loop indefinitely.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
