Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267690AbSLSWR5>; Thu, 19 Dec 2002 17:17:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267674AbSLSWRG>; Thu, 19 Dec 2002 17:17:06 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:64520 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S267671AbSLSWPW> convert rfc822-to-8bit; Thu, 19 Dec 2002 17:15:22 -0500
Message-ID: <3E0246DE.2010608@transmeta.com>
Date: Thu, 19 Dec 2002 14:23:26 -0800
From: "H. Peter Anvin" <hpa@transmeta.com>
Organization: Transmeta Corporation
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3a) Gecko/20021119
X-Accept-Language: en, sv
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
CC: dean gaudet <dean-list-linux-kernel@arctic.org>,
       Linus Torvalds <torvalds@transmeta.com>,
       Dave Jones <davej@codemonkey.org.uk>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org
Subject: Re: Intel P6 vs P7 system call performance
References: <Pine.LNX.4.44.0212162204300.1800-100000@home.transmeta.com> <Pine.LNX.4.50.0212162241150.26163-100000@twinlark.arctic.org> <20021218235327.GC705@elf.ucw.cz> <3E0245C1.5060902@transmeta.com> <20021219222136.GC17941@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20021219222136.GC17941@atrey.karlin.mff.cuni.cz>
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 8BIT
X-MIME-Autoconverted: from 8bit to quoted-printable by deepthought.transmeta.com id gBJMNG323126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> Hi!
> 
> 
>>>>don't many of the multi-CPU problems with tsc go away because you've got a
>>>>per-cpu physical page for the vsyscall?
>>>>
>>>>i.e. per-cpu tsc epoch and scaling can be set on that page.
>>>
>>>Problem is that cpu's can randomly drift +/- 100 clocks or so... Not
>>>nice at all.
>>>
>>
>>нн?100 clocks is what... ?50 ns these days?  You can't get that kind of
>>accuracy for anything outside the CPU core anyway...
> 
> 50ns is bad enough when it makes your time go backwards.
> 

Backwards??  Clock spreading should make the rate change, but it should
never decrement.

	-hpa


