Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272247AbRI3BbH>; Sat, 29 Sep 2001 21:31:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272253AbRI3Ba5>; Sat, 29 Sep 2001 21:30:57 -0400
Received: from codepoet.org ([166.70.14.212]:16750 "HELO winder.codepoet.org")
	by vger.kernel.org with SMTP id <S272247AbRI3Baw>;
	Sat, 29 Sep 2001 21:30:52 -0400
Date: Sat, 29 Sep 2001 19:31:22 -0600
From: Erik Andersen <andersen@codepoet.org>
To: Alan Cox <laughing@shared-source.org>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.9-ac18
Message-ID: <20010929193122.A7715@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	Alan Cox <laughing@shared-source.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20010929224837.A12070@lightning.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010929224837.A12070@lightning.swansea.linux.org.uk>
User-Agent: Mutt/1.3.22i
X-Operating-System: Linux 2.4.9-ac10-rmk1, Rebel-NetWinder(Intel sa110 rev 3), 262.14 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat Sep 29, 2001 at 10:48:37PM +0100, Alan Cox wrote:
> 
> 2.4.9-ac18
> o	Revert softirq changes

I see tons and tons of

make[3]: Entering directory `/home/andersen/linux/drivers/ide'
make all_targets
make[4]: Entering directory `/home/andersen/linux/drivers/ide'
gcc -D__KERNEL__ -I/home/andersen/linux/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i386    -DEXPORT_SYMTAB -c ide.c
In file included from ide.c:138:
/home/andersen/linux/include/linux/interrupt.h:77: warning: `__cpu_raise_softirq' redefined
/home/andersen/linux/include/asm/softirq.h:53: warning: this is the location of the previous definition
gcc -D__KERNEL__ -I/home/andersen/linux/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i386    -DEXPORT_SYMTAB -c ide-features.c
In file included from ide-features.c:25:
/home/andersen/linux/include/linux/interrupt.h:77: warning: `__cpu_raise_softirq' redefined
/home/andersen/linux/include/asm/softirq.h:53: warning: this is the location of the previous definition


type messages.  Fairly benign, but still, it suggestes that the softirq 
revert was a bit incomplete....

 -Erik

--
Erik B. Andersen   email:  andersee@debian.org, formerly of Lineo
--This message was written using 73% post-consumer electrons--
