Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289568AbSAJRch>; Thu, 10 Jan 2002 12:32:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289570AbSAJRcb>; Thu, 10 Jan 2002 12:32:31 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:9226 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S289568AbSAJRcS>; Thu, 10 Jan 2002 12:32:18 -0500
Message-ID: <3C3DD011.7010309@zytor.com>
Date: Thu, 10 Jan 2002 09:32:01 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011120
X-Accept-Language: en-us, en, sv
MIME-Version: 1.0
To: Dave Jones <davej@suse.de>
CC: Giacomo Catenazzi <cate@debian.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        linux-kernel@vger.kernel.org
Subject: Re: initramfs programs (was [RFC] klibc requirements)
In-Reply-To: <Pine.LNX.4.33.0201101822020.21159-100000@wotan.suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones wrote:

> 
> It's worse than you think.
> Distinguishing between XP and MP athlon for example needs
> capability bit testing.  (And some XP's _are_ now multiprocessor
> capable, just to confuse the issue some more), so relying on
> the cpuid identity string isn't foolproof.
> (Also, some implementations allow for this string to be changed,
>  some folks have it set to "PenguinPowered" and the likes 8-)
> 


Sure, but if you do that you're *asking*, in a very literal way, for 
your CPU to misidentified.  In fact, a major reason for making this 
string modifiable is due to certain vendors who hard-code CPUID strings 
in their code.

> 
> Asides from the above issues, multiple CPUs have the same
> cpuid sometimes, meaning you have to check things like
> cache size as well (though most (all?) of these should
> end up with the same CONFIG_ option iirc, so this shouldn't
> be an issue -- you should check to be sure though)
> 


Why -- if it doesn't change anything, all you're doing is making it 
confusing when the next derivative appears.  Remember that we *do* need, 
  as much as possible, to be forward compatible with future CPUs.


> x86info's identify.c files should give you a fairly
> comprehensive guide to the various types.


	-hpa


