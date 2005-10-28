Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030225AbVJ1P7I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030225AbVJ1P7I (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 11:59:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030229AbVJ1P7I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 11:59:08 -0400
Received: from [64.162.99.240] ([64.162.99.240]:36492 "EHLO
	spamtest2.viacore.net") by vger.kernel.org with ESMTP
	id S1030225AbVJ1P7H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 11:59:07 -0400
Message-ID: <43624A14.20802@spamtest.viacore.net>
Date: Fri, 28 Oct 2005 08:56:04 -0700
From: Joe Bob Spamtest <joebob@spamtest.viacore.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050923 Fedora/1.7.12-1.5.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Fawad Lateef <fawadlateef@gmail.com>
CC: Alejandro Bonilla <abonilla@linuxwireless.org>,
       Marcel Holtmann <marcel@holtmann.org>, linux-kernel@vger.kernel.org
Subject: Re: 4GB memory and Intel Dual-Core system
References: <1130445194.5416.3.camel@blade> <52mzkuwuzg.fsf@cisco.com>	 <20051027204923.M89071@linuxwireless.org>	 <1130446667.5416.14.camel@blade>	 <20051027205921.M81949@linuxwireless.org>	 <1130447261.5416.20.camel@blade>	 <20051027211203.M33358@linuxwireless.org> <1e62d1370510271935o51d88c0bk7baa23ca1a75bc4d@mail.gmail.com>
In-Reply-To: <1e62d1370510271935o51d88c0bk7baa23ca1a75bc4d@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Fawad Lateef wrote:
> Can you tell me the main differences between IA64 and x86_64 (Opteron)
> ? because in your one of the previous mail you said IA64 != EM64T and
> its true, but I know is EM64T/AMD64 in 64-bit mode != IA32 but you
> said that too EM64T is not really 64-bit, its a IA32 .. Can you give
> me some link which just tells the difference between IA64 (Itanium)
> and AMD64 (Opteron) ?

IA64 (Itanium [Itanic, really -- the architecture IMO is a real 
disappointment IRL for something which on paper looked very impressive]) 
is a true 64 bit CPU. It's a new architecture built from scratch -- as 
different from IA32 as SPARC is. IA64 has a "compatibility mode" which 
allows it to run IA32 code natively, albeit very, very slow. Make no 
mistake -- IA64 is a completely different CPU type and architecture from 
IA32.

x86_64 (both AMD64 and Intel's EM64T offerings) are 64-bit extensions to 
a 32 bit microprocessor. The system architecture stayed basically the 
same. This is different from IA32 in the same ways PPC64 is different 
from PPC32 and SPARC64 is different from SPARC32. Both CPUs use the same 
set of commands as their predecessors, with the inclusion of several 
more instructions and registers (as well as the registers being of 
greater width).

The differences between AMD64 and EM64T are significant as well; however 
from a programming standpoint the differences are almost negligible. THe 
biggest difference (which may have impact on programming principles) is 
AMD64 is a NUMA architecture whereas EM64T still uses the same memory 
model and architecture as the IA32. Quite simply, you gain more from 
AMD64 than you do from EM64T, in my opinion.

Both (really, all three) architectures have their plusses and minuses. 
EM64T is Intel's idea of playing catch-up with the competition (AMD), IMO.

>                      With the Itanium, Intel proposes to examine
> programs when they are compiled into their executable form and encode
> concurrent operations ahead of time. Intel calls this approach EPIC,
> for Explicitly Parallel Instruction Computing, and it is the genuine
> difference between the Itanium and AMD's x86-64. EPIC's drawback is

This is so blatantly simplified it's outright wrong.

EPIC is a very clever, revolutionary design. When I first read the 
Itanium whitepapers some years ago, it seemed like this technology was 
definitely worth taking a look at. Apparently I wasn't the only one who 
thought this: HP dropped PA-RISC for Itanium, SGI dropped MIPS, Compaq 
(at the time its own entity) dropped Alpha... Everyone, it seems, jumped 
on the bandwagon with the exception of Sun, who elected to wait for 
AMD's offering. Turns out though, what looked good on paper turned out 
to be quite a disappointment. The original Itanium, at its release, was 
very disappointing in terms of performance. At the time, the 32-bit 
Pentium III Tualatin could perform the same calculations as Itanium in 
less time -- for a fraction of the cost. And the 32-bit codepath 
compatibility? It was a joke -- some compared it to a sluggish 
Pentium-II 266. HP took the Itanium specification from Intel, used its 
expertise from years with PA-RISC, and redesigned Itanium, to later 
release Itanium II. This offered a great performance increase over the 
previous release, but the 32-bit codepath is still abysmally slow. Even 
the new, improved EPIC still lacks; thus far nobody's compiler -- not 
even Intel's -- can take full advantage or make full use of the features 
in this CPU. Many high-performance applications are still hand-tuned in 
IA64 assembler to take advantage of its offerings.

Hope this helped to clear some things up.

Cheers,
-Kelsey
