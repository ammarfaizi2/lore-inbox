Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129692AbRAIS0J>; Tue, 9 Jan 2001 13:26:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129985AbRAISZ7>; Tue, 9 Jan 2001 13:25:59 -0500
Received: from [64.64.109.142] ([64.64.109.142]:61969 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP
	id <S129692AbRAISZt>; Tue, 9 Jan 2001 13:25:49 -0500
Message-ID: <3A5B577F.DB1726B7@didntduck.org>
Date: Tue, 09 Jan 2001 13:25:03 -0500
From: Brian Gerst <bgerst@didntduck.org>
X-Mailer: Mozilla 4.73 [en] (WinNT; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Kaj-Michael Lang <milang@tal.org>
CC: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: Raid code panic with kernel compiled for i486
In-Reply-To: <001401c07a65$e9c41040$56dc10c3@tal.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kaj-Michael Lang wrote:
> 
> I was testing the 2.4.0 kernel and found out that when a kernel
> compiled for processors under P3 (i486, P2/Celeron) and booting it on a P3
> the kernel
> panics when it's tries to test different RAID5 xor algorithms.
> 
> The panic looks something like this:
> 
> ...
> raid5: measuring checksuming speed
> 8regs    : 773.430 MB/sec
> 32regs    :    562.356 MB/sec
> invalid operand: 0000
> CPU:    0
> EIP:    0010:[<c0259c7d>]
> ...
> 

Try 2.4.1-pre1.  It's choking because SSE hasn't been enabled since it's
compiled for a 486.

--

				Brian Gerst
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
