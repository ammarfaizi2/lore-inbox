Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268905AbRHLBRl>; Sat, 11 Aug 2001 21:17:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268906AbRHLBRb>; Sat, 11 Aug 2001 21:17:31 -0400
Received: from ppp0.ocs.com.au ([203.34.97.3]:17679 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S268905AbRHLBRW>;
	Sat, 11 Aug 2001 21:17:22 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Roman Zippel <zippel@linux-m68k.org>
cc: kbuild-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: Announce: Kernel Build for 2.5, Release 1.1 is available. 
In-Reply-To: Your message of "Sat, 11 Aug 2001 23:55:04 +0200."
             <3B75A9B8.ECB8644@linux-m68k.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 12 Aug 2001 11:17:27 +1000
Message-ID: <4682.997579047@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 11 Aug 2001 23:55:04 +0200, 
Roman Zippel <zippel@linux-m68k.org> wrote:
>Keith Owens wrote:
>
>> None of the above methods handle dependency checking at all.  PPC makes
>> an attempt but it is manually defined and is incomplete, no other arch
>> even makes an attempt.
>
>I'm wondering that you don't mention m68k, because we generate
>dependencies...
>(Has nothing to do with kbuild, I'm just curious. :) )

Because I did a quick sweep through the arch makefiles looking for the
word 'offsets'.  That is part of the problem, the offsets file has
different names in some architectures.  Most call it offsets, PPC uses
mk_def and ppc_defs, arm uses getconstants and constants, m68k uses
m68k_defs.  It does not help when the code that generates the asm
constants is in different directories on some architectures.

Now you know why I want a standard method, with a standard name and
standard directory location.

