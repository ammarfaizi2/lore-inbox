Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278714AbRKXP73>; Sat, 24 Nov 2001 10:59:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278722AbRKXP7K>; Sat, 24 Nov 2001 10:59:10 -0500
Received: from m64-mp1-cvx1c.lee.ntl.com ([62.252.236.64]:36480 "EHLO
	box.penguin.power") by vger.kernel.org with ESMTP
	id <S278714AbRKXP7I>; Sat, 24 Nov 2001 10:59:08 -0500
Date: Sat, 24 Nov 2001 15:55:16 +0000
From: Gavin Baker <gavbaker@ntlworld.com>
To: "Stephen C. Tweedie" <sct@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.13-ac7 ext3 OOPS
Message-ID: <20011124155516.A14067@box.penguin.power>
In-Reply-To: <20011118205039.A3208@box.penguin.power> <20011122202432.A11821@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <20011122202432.A11821@redhat.com>; from sct@redhat.com on Thu, Nov 22, 2001 at 08:24:32PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 22, 2001 at 08:24:32PM +0000, Stephen C. Tweedie wrote:

> Hi,
> 
> On Sun, Nov 18, 2001 at 08:50:39PM +0000, Gavin Baker wrote:
> > A seemingly random OOPS while using netscape. 2.4.13-ac7 with preempt patches on a RH7.2 laptop.
>  
> > Nov 18 13:12:45 n-files kernel: EIP:    0010:[get_hash_table+107/208]    Not tainted
> 
> get_hash_table oopses are almost always caused by bad memory.  For
> some reason, the buffer cache hashes are peculiarly sensitive to
> corruptions.

This is definately likely, the machine has a cheap no-name memory
module in it.

> > Nov 18 13:12:45 n-files kernel: eax: c1430000   ebx: ffffffff   ecx: 00000002   edx: 00003859
> 
> It's not enough to be conclusive, but the other common footprint of
> random memory corruption is register dumps containing a value which is
> all-zeroes except for one flipped bit, like your 0x00000002 value in
> %ecx.

This is another factoid for my notebook. :)

> Let me know if you can reproduce this, but in the absense of any other
> pattern, bad memory is the most likely cause for now.

I cannot reproduce this, i've tried stressing the filesystem but the
oops does not show up. I will cc you if one shows up again.

I've tried memtest86 on the machine, and while it doesn't spot any
errors, it does seem to take an extremly long time to do some of the
tests (The default tests are taking more than 12 hours). I will replace
the memory with some decent branded ram just in case.

Thanks for your time Stephen,

Regards, Gavin Baker

