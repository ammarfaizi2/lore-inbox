Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281916AbSAPRtG>; Wed, 16 Jan 2002 12:49:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285338AbSAPRs4>; Wed, 16 Jan 2002 12:48:56 -0500
Received: from asterix.hrz.tu-chemnitz.de ([134.109.132.84]:30636 "EHLO
	asterix.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id <S285161AbSAPRsv>; Wed, 16 Jan 2002 12:48:51 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: [Q] Looking for an emulation for CMOV* instructions.
In-Reply-To: <Pine.LNX.3.95.1020116110901.13296A-100000@chaos.analogic.com>
From: Ronald Wahl <Ronald.Wahl@informatik.tu-chemnitz.de>
Date: 16 Jan 2002 18:48:49 +0100
In-Reply-To: <Pine.LNX.3.95.1020116110901.13296A-100000@chaos.analogic.com>
Message-ID: <m21ygquqym.fsf@goliath.csn.tu-chemnitz.de>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Common Lisp)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Jan 2002 11:16:55 -0500 (EST), Richard B Johnson wrote:

> On Wed, 16 Jan 2002, Jamie Lokier wrote:
>> Alan Cox wrote:
>> > > What's the point of optimizing an IF to a cmov if I have
>> > > to insert another IF to see if I can use cmov?
>> > 
>> > I've always wondered. Intel made the instruction optional yet there isnt
>> > an obvious way to do runtime fixups on it
>> 
>> Yes there is -- emulation! :-)
>> 

> It's just as bad, probably worse! You trap on an invalid op-code. The
> trap-handler checks the op-code and if it's emulated, it emulates it
> and returns to the executing task. This takes many instruction cycles,
> certainly more than `if(cmov) doit; else do_something_else;` --which,
> itself, takes many more instruction cycles than cmov is supposed to
> reduce. It's a no-win situation. The only way to win is a compile-time
> choice. This means customizing for your CPU IFF it has the cmov
> instruction.

It is a big win in the situation where you have only a binary for i686
and want or better must execute it e.g. on a i586. This was the reason
why I asked initially.

ron

-- 
/\/\  Dipl.-Inf. Ronald Wahl                /\/\        C S N         /\/\
\/\/  ronald.wahl@informatik.tu-chemnitz.de \/\/  ------------------  \/\/
/\/\  http://www.tu-chemnitz.de/~row/       /\/\  network and system  /\/\
\/\/  GnuPG/PGP key available               \/\/    administration    \/\/
