Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267800AbTBJCFJ>; Sun, 9 Feb 2003 21:05:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267823AbTBJCFJ>; Sun, 9 Feb 2003 21:05:09 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:26374 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S267800AbTBJCFI>;
	Sun, 9 Feb 2003 21:05:08 -0500
Message-ID: <3E470AFC.4070906@pobox.com>
Date: Sun, 09 Feb 2003 21:14:20 -0500
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Neil Booth <neil@daikokuya.co.uk>
CC: Jeff Muizelaar <muizelaar@rogers.com>, Andi Kleen <ak@suse.de>,
       Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: gcc 2.95 vs 3.21 performance
References: <1044385759.1861.46.camel@localhost.localdomain.suse.lists.linux.kernel> <200302041935.h14JZ69G002675@darkstar.example.net.suse.lists.linux.kernel> <b1pbt8$2ll$1@penguin.transmeta.com.suse.lists.linux.kernel> <p73znpbpuq3.fsf@oldwotan.suse.de> <3E4045D1.4010704@rogers.com> <20030206070256.GB30345@daikokuya.co.uk>
In-Reply-To: <20030206070256.GB30345@daikokuya.co.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Booth wrote:
> Jeff Muizelaar wrote:-
> 
> 
>>There is also tcc (http://fabrice.bellard.free.fr/tcc/)
>>It claims to support gcc-like inline assembler, appears to be much 
>>smaller and faster than gcc. Plus it is GPL so the liscense isn't a 
>>problem either.
> 
> 
> It doesn't expand macros correctly, however, and accepts an enormous
> range of invalid code without a single diagnostic.  I'm pretty sure
> it's arithmetic rules are incorrect, too.  It's certainly nowhere
> near C89 compliance.


100% agreed.

However, for our purposes, TinyCC is only missing two pieces needed for 
successfully building a bootable kernel:

* __builtin_constant_p
* function inlining

Given the existing TinyCC source base, function inlining is a big step 
(since tcc doesn't do AST-like things currently), so don't expect that 
very soon.  TinyCC is a fun little project to watch and play around 
with, though, and can compile most major open source projects, as well 
as itself.

	Jeff



