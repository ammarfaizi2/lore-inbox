Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129267AbRAIHUW>; Tue, 9 Jan 2001 02:20:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129324AbRAIHUD>; Tue, 9 Jan 2001 02:20:03 -0500
Received: from slc110.modem.xmission.com ([166.70.9.110]:39690 "EHLO
	flinx.biederman.org") by vger.kernel.org with ESMTP
	id <S129267AbRAIHTb>; Tue, 9 Jan 2001 02:19:31 -0500
To: zlatko@iskon.hr
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Rik van Riel <riel@conectiva.com.br>, linux-kernel@vger.kernel.org
Subject: Re: Subtle MM bug
In-Reply-To: <Pine.LNX.4.10.10101080951140.3750-100000@penguin.transmeta.com> <87n1d1mx2d.fsf@atlas.iskon.hr>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 08 Jan 2001 23:20:58 -0700
In-Reply-To: Zlatko Calusic's message of "09 Jan 2001 00:41:14 +0100"
Message-ID: <m1wvc5gsad.fsf@frodo.biederman.org>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zlatko Calusic <zlatko@iskon.hr> writes:

> 
> Yes, but a lot more data on the swap also means degraded performance,
> because the disk head has to seek around in the much bigger area. Are
> you sure this is all OK?

I don't think we have more data on the swap, just more data has an
allocated home on the swap.  With the earlier allocation we should
(I haven't verified) allocate contiguous chunks of memory contiguously
on the swap.   And reusing the same swap pages helps out with this.

Eric
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
