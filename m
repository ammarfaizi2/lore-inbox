Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314149AbSFQOqa>; Mon, 17 Jun 2002 10:46:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314243AbSFQOq3>; Mon, 17 Jun 2002 10:46:29 -0400
Received: from [195.63.194.11] ([195.63.194.11]:8965 "EHLO mail.stock-world.de")
	by vger.kernel.org with ESMTP id <S314149AbSFQOq3> convert rfc822-to-8bit;
	Mon, 17 Jun 2002 10:46:29 -0400
Message-ID: <3D0DF605.8030901@evision-ventures.com>
Date: Mon, 17 Jun 2002 16:45:25 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0.0) Gecko/20020611
X-Accept-Language: pl, en-us
MIME-Version: 1.0
To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.5.22 broke modversions
References: <Pine.LNX.4.44.0206170925160.22308-100000@chaos.physics.uiowa.edu>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

U¿ytkownik Kai Germaschewski napisa³:
> On Mon, 17 Jun 2002, Mikael Pettersson wrote:
> 
> 
>>Something in the 2.5.22 Makefile/Rule.make changes broke
>>modversions on my P4 box. For some reason, a number of
>>exporting objects, including arch/i386/kernel/i386_ksyms,
>>weren't given -D__GENKSYMS__ at genksym-time, with the
>>effect that the resulting .ver files became empty, and the
>>kernel exported the symbols with unexpanded _R__ver_ suffixes.
> 
> 
> You're right, thanks for the report. The fix is appended ;)

BTW> There is some different thing broken: TEMP files
used by make menuconfig don't get clean up even after make distclean.

