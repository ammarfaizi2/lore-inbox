Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312321AbSC3ARx>; Fri, 29 Mar 2002 19:17:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312322AbSC3ARn>; Fri, 29 Mar 2002 19:17:43 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:19728 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S312321AbSC3ARe>;
	Fri, 29 Mar 2002 19:17:34 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: "Amit S. Kale" <kgdb@vsnl.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: announce: kgdb 1.5 with reworked buggy smp handling 
In-Reply-To: Your message of "Fri, 29 Mar 2002 20:33:19 +0530."
             <3CA48237.EA4D3F08@vsnl.net> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 30 Mar 2002 11:17:21 +1100
Message-ID: <330.1017447441@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Mar 2002 20:33:19 +0530, 
"Amit S. Kale" <kgdb@vsnl.net> wrote:
>Keith Owens wrote:
>> 
>> On Fri, 29 Mar 2002 16:01:36 +0530,
>> "Amit S. Kale" <kgdb@vsnl.net> wrote:
>> >kgdb 1.5 at http://kgdb.sourceforge.net/
>> >
>> >smp handling is completely reworked. Previous kgdb had a bug
>> >which caused it to hang when a processor spun with
>> >interrupts disabled and another processor enters kgdb. kgdb
>> >now uses nmi watchdog for holding other processors while
>> >a machine is in kgdb.
>> 
>> IA64 disabled spin loops ignore NMI :(.
>
>Thanks for the info.
>
>Isn't there any way get into an interrupt disabled spinning
>processor on an ia64 smp machine?

Only via an INIT interrupt.  But that is also used to initialise a cpu
at startup, INIT interrupts go through PAL and SAL and have side
effects.  I don't use them for kdb, they are too heavy.

For more background, see the thread "Replacements for local_irq_xxx()"
https://external-lists.vasoftware.com/archives//linux-ia64/2001-May/thread.html

