Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267070AbSLQUEh>; Tue, 17 Dec 2002 15:04:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267071AbSLQUEh>; Tue, 17 Dec 2002 15:04:37 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:58121 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S267070AbSLQUEe>; Tue, 17 Dec 2002 15:04:34 -0500
Message-ID: <3DFF8520.7030600@transmeta.com>
Date: Tue, 17 Dec 2002 12:12:16 -0800
From: "H. Peter Anvin" <hpa@transmeta.com>
Organization: Transmeta Corporation
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3a) Gecko/20021119
X-Accept-Language: en, sv
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Linus Torvalds <torvalds@transmeta.com>,
       Dave Jones <davej@codemonkey.org.uk>, Ingo Molnar <mingo@elte.hu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Intel P6 vs P7 system call performance
References: <Pine.LNX.4.44.0212162204300.1800-100000@home.transmeta.com> 	<3DFF772E.2050107@transmeta.com> <1040158171.20765.23.camel@irongate.swansea.linux.org.uk>
In-Reply-To: <1040158171.20765.23.camel@irongate.swansea.linux.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> On Tue, 2002-12-17 at 19:12, H. Peter Anvin wrote:
> 
>>The complexity only applies to nonsynchronized TSCs though, I would
>>assume.  I believe x86-64 uses a vsyscall using the TSC when it can
>>provide synchronized TSCs, and if it can't it puts a normal system call
>>inside the vsyscall in question.
> 
> 
> For x86-64 there is the hpet timer, which is a lot saner but I don't
> think we can mmap it
> 

It's only necessary, though, when TSC isn't usable.  TSC is psycho fast
when it's available.  Just about anything is saner than the old 8042 or
whatever it is called timer chip, though...

	-hpa


