Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265048AbSKAPTW>; Fri, 1 Nov 2002 10:19:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265049AbSKAPTW>; Fri, 1 Nov 2002 10:19:22 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:18957 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S265048AbSKAPTV>; Fri, 1 Nov 2002 10:19:21 -0500
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: What's left over.
Date: Fri, 1 Nov 2002 15:25:01 +0000 (UTC)
Organization: Transmeta Corporation
Message-ID: <apu6cd$4db$1@penguin.transmeta.com>
References: <20021031181252.GB24027@tapu.f00f.org> <Pine.LNX.4.44.0210311040080.1526-100000@penguin.transmeta.com> <20021031194351.GA24676@tapu.f00f.org>
X-Trace: palladium.transmeta.com 1036164319 16469 127.0.0.1 (1 Nov 2002 15:25:19 GMT)
X-Complaints-To: news@transmeta.com
NNTP-Posting-Date: 1 Nov 2002 15:25:19 GMT
Cache-Post-Path: palladium.transmeta.com!unknown@penguin.transmeta.com
X-Cache: nntpcache 2.4.0b5 (see http://www.nntpcache.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20021031194351.GA24676@tapu.f00f.org>,
Chris Wedgwood  <cw@f00f.org> wrote:
>On Thu, Oct 31, 2002 at 10:49:10AM -0800, Linus Torvalds wrote:
>
>> Any hardware that needs to go off and think about how to encrypt
>> something sounds like it's so slow as to be unusable. I suspect that
>> anything that is over the PCI bus is already so slow (even if it
>> adds no extra cycles of its own) that you're better off using the
>> CPU for the encryption rather than some external hardware.
>
>Except almost all hardware out there that does this stuff is async to
>some extent...

That's not my argument.  I realize that external hardware on a PCI bus
_has_ to be asynchronous, simply because it is so slow. 

The question I have is whether such external hardware is even worth it
any more for any standard crypto work.  With a regular PCI bus
fundamentally limiting throughput to something like a maximum of 66MB/s
(copy-in and copy-out, and that's so theoretical that it's not even
funny - I'd be surprised if RL throughput copying back and forth over a
PCI bus is more than 25-30MB/s), I suspect that you can do most crypto
faster on the CPU directly these days. 

Maybe not. The only numbers I have is the slowness of PCI.

		Linus
