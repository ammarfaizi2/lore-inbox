Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264218AbUEHKS4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264218AbUEHKS4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 May 2004 06:18:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264235AbUEHKSz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 May 2004 06:18:55 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:5893 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S264218AbUEHKSy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 May 2004 06:18:54 -0400
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: root@chaos.analogic.com, "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Subject: Re: [ACPI] Re: Linux 2.4.26-rc1 (cmpxchg vs 80386 build)
Date: Sat, 8 May 2004 13:18:28 +0300
User-Agent: KMail/1.5.4
Cc: Jamie Lokier <jamie@shareable.org>, Bill Davidsen <davidsen@tmr.com>,
       Len Brown <len.brown@intel.com>,
       Chris Friesen <cfriesen@nortelnetworks.com>,
       Willy Tarreau <willy@w.ods.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Arkadiusz Miskiewicz <arekm@pld-linux.org>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ACPI Developers <acpi-devel@lists.sourceforge.net>
References: <4069A359.7040908@nortelnetworks.com> <Pine.LNX.4.55.0404011423070.3675@jurand.ds.pg.gda.pl> <Pine.LNX.4.53.0404010814420.15020@chaos>
In-Reply-To: <Pine.LNX.4.53.0404010814420.15020@chaos>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200405081318.28853.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> In Intel machines ALL memory operations are atomic. What
> the means is that if I make code that does:
>
> 	addl	%eax,(memory)
>
> ... what's in memory will always be the sum of what it was
> before and the value in the EAX register.

Except on SMP.

> A long time ago, somebody invented the 'lock' instruction
> for Intel machines. It turns out that the first ones locked
> the whole bus during an operation. Eventually somebody looked
> at that, and by the time the '486 came out, they no longer
> locked the whole bus. Then somebody else said; "WTF...
> Why do we even need this stuff". It was a throw-back to
> early primitive machines where there were only load and
> store operations in memory. All arithmetic had to be done
> in registers. Now, there are only a couple instructions you
> can use the lock prefix with, or you get an invalid opcode
> trap, and they are really no-ops because the instruction
> itself is atomic.

Not on SMP. On SMP, lock prefix *is needed*.

If you think I'm wrong, point me to the relevant docs.
--
vda

