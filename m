Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265067AbSKAQIi>; Fri, 1 Nov 2002 11:08:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265070AbSKAQIh>; Fri, 1 Nov 2002 11:08:37 -0500
Received: from [203.117.131.12] ([203.117.131.12]:16307 "EHLO
	gort.metaparadigm.com") by vger.kernel.org with ESMTP
	id <S265067AbSKAQIg>; Fri, 1 Nov 2002 11:08:36 -0500
Message-ID: <3DC2A888.5010502@metaparadigm.com>
Date: Sat, 02 Nov 2002 00:15:04 +0800
From: Michael Clark <michael@metaparadigm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020913 Debian/1.1-1
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org, Chris Wedgwood <cw@f00f.org>
Subject: Re: What's left over.
References: <20021031181252.GB24027@tapu.f00f.org> <Pine.LNX.4.44.0210311040080.1526-100000@penguin.transmeta.com> <20021031194351.GA24676@tapu.f00f.org> <apu6cd$4db$1@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/01/02 23:25, Linus Torvalds wrote:
> In article <20021031194351.GA24676@tapu.f00f.org>,
> Chris Wedgwood  <cw@f00f.org> wrote:
> 
>>On Thu, Oct 31, 2002 at 10:49:10AM -0800, Linus Torvalds wrote:
>>
>>
>>>Any hardware that needs to go off and think about how to encrypt
>>>something sounds like it's so slow as to be unusable. I suspect that
>>>anything that is over the PCI bus is already so slow (even if it
>>>adds no extra cycles of its own) that you're better off using the
>>>CPU for the encryption rather than some external hardware.
>>
>>Except almost all hardware out there that does this stuff is async to
>>some extent...
> 
> 
> That's not my argument.  I realize that external hardware on a PCI bus
> _has_ to be asynchronous, simply because it is so slow. 
> 
> The question I have is whether such external hardware is even worth it
> any more for any standard crypto work.  With a regular PCI bus
> fundamentally limiting throughput to something like a maximum of 66MB/s
> (copy-in and copy-out, and that's so theoretical that it's not even
> funny - I'd be surprised if RL throughput copying back and forth over a
> PCI bus is more than 25-30MB/s), I suspect that you can do most crypto
> faster on the CPU directly these days. 
> 
> Maybe not. The only numbers I have is the slowness of PCI.

A 1GHz PIII will do about 8MBytes/sec of 3DES

Plug in a 2.4Gbs broadcom crypto chip into a 64bit PCI-X slot with the
same CPU and you should be capable of doing at least 10 times that.

Stuff like RSA is much slower (and benefits more from hardware)

BTW - there are some outdated cryptolib patches with an async
interface around somewhere (along with patches for freeswan to use
the async api).

I guess the crypto guys like Chris will add the async API if they need
it (which they do i think ;).

~mc

