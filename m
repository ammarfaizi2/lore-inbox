Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310979AbSCWT2L>; Sat, 23 Mar 2002 14:28:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310972AbSCWT2A>; Sat, 23 Mar 2002 14:28:00 -0500
Received: from lord.banki.hu ([193.225.225.14]:19314 "HELO lord.banki.hu")
	by vger.kernel.org with SMTP id <S310953AbSCWT1m>;
	Sat, 23 Mar 2002 14:27:42 -0500
Date: Sat, 23 Mar 2002 20:27:35 +0100
From: Janos Farkas <chexum@shadow.banki.hu>
To: Banai Zoltan <bazooka@enclavenet.hu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: io-apic not working on i850mv(p4)
Message-ID: <priv$1016911429.lord@lk8rp.mail.xeon.eu.org>
Mail-Followup-To: Banai Zoltan <bazooka@enclavenet.hu>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020323181736.B9229@bazooka.saturnus.vein.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
User-Agent: Mutt/0.96.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2002-03-23, 18:17: Banai Zoltan szerint:
> I have an Intel i850MV motherboard with:
... 
> model name	: Intel(R) Pentium(R) 4 CPU 1.70GHz
> flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm
...
> using 2.4.19-pre3-ac3 kernel with IO-APIC, but it seems not working to me:
>   0:    5420792          XT-PIC  timer
...
> why gives XT-PIC instead of IO-APIC for all interrupst

Because you don't have an IO APIC?

> Found and enabled local APIC!
...
> Using local APIC timer interrupts.
> calibrating APIC timer ...
...

I/O APIC != local APIC; the latter is on on all CPU's since P5 (at least
for Intel), I/O APIC's are usable mostly on SMP boards.  Is yours SMP
capable?

-- 
Janos
romfs is at http://romfs.sourceforge.net/
