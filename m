Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318136AbSGMJ7S>; Sat, 13 Jul 2002 05:59:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318137AbSGMJ7R>; Sat, 13 Jul 2002 05:59:17 -0400
Received: from tom.hrz.tu-chemnitz.de ([134.109.132.38]:21515 "EHLO
	tom.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id <S318136AbSGMJ7P>; Sat, 13 Jul 2002 05:59:15 -0400
Date: Sat, 13 Jul 2002 11:28:22 +0200
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: Richard J Moore <richardj_moore@uk.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [STATUS 2.5]  July 10, 2002
Message-ID: <20020713112822.D758@nightmaster.csn.tu-chemnitz.de>
References: <OFECA8B235.6959642F-ON85256BF3.006A387F@portsmouth.uk.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2i
In-Reply-To: <OFECA8B235.6959642F-ON85256BF3.006A387F@portsmouth.uk.ibm.com>; from richardj_moore@uk.ibm.com on Thu, Jul 11, 2002 at 09:34:37PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 11, 2002 at 09:34:37PM +0100, Richard J Moore wrote:
> 
>    message uniqueness is not guaranteed
>    message content is not complete for automation purposes
>    some of the most serious error message have the least useful content
>    many messages are issued using multiple printks and on an MP system can
>    have their text interleaved
>    there's no national language support
     ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^[1]
>    embedded systems are not well catered for
>    message recognition and parsing is haphazard

[1] Should stay like this. Or at least only the original message
should go to the log file.

Just an example:

Huch? Sytemkernseite konnte nicht an Adresse 1098bf00 eingeblendet werden.
current->tss.cr3 = 0062d000, %cr3 = 0062d000
*pde = 00000000
Huch: 0002
Prozessor:    0
EIP:    0010:[oops:_oops+16/3868]
EFLAGS: 00010212
eax: 315e97cc   ebx: 003a6f80
ecx: 001be77b   edx: 00237c0c
esi: 00000000   edi: bffffdb3
ebp: 00589f90   esp: 00589f8c
ds: 0018   es: 0018   fs: 002b
gs: 002b   ss: 0018
Prozeﬂ oops_test (pid: 3374,
Prozeﬂnummer: 21, Kellerseite=00589000)
Keller: 315e97cc 00589f98 0100b0b4 bffffed4 0012e38e 00240c64 003a6f80 00000001

This is only German, which is very similiar to whose character
set is a slight superset of the characterset in UK/US.

Now consider the same message in Chinese (20.000 possible
characters), Hebrew (right to left and 'strange' characters), 
Arabic (right to left, strange rules for composing connections
between the characters, which even Micro$oft was unable to get
right) and many more fun.

So the driver writer has get his debugging messages translated
somehow and than he has to ask the translation serices again to
translate the bug report from the user.

Sorry, this sounds like someone is looking for a market niche
for getting more money instead of getting real problems solved.

Communication requires a common language. This is English for
Problems regarding Linux kernel development and maintenance.
Anything else would slow down both, because of added complexity.

Regards

Ingo Oeser, who thinks i18ned user space messages are enough
pain in the ass.
-- 
Science is what we can tell a computer. Art is everything else. --- D.E.Knuth
