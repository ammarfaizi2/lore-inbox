Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315111AbSD2Lyr>; Mon, 29 Apr 2002 07:54:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315113AbSD2Lyk>; Mon, 29 Apr 2002 07:54:40 -0400
Received: from employees.nextframe.net ([212.169.100.200]:64762 "EHLO
	sexything.nextframe.net") by vger.kernel.org with ESMTP
	id <S315111AbSD2Lyk>; Mon, 29 Apr 2002 07:54:40 -0400
Date: Mon, 29 Apr 2002 13:56:21 +0200
From: Morten Helgesen <morten.helgesen@nextframe.net>
To: Seiichi Nakashima <nakasima@kumin.ne.jp>
Cc: linux-kernel@vger.kernel.org
Subject: Re: linux-2.5.11 compile error ( without framebuffer )
Message-ID: <20020429135621.B118@sexything>
Reply-To: morten.helgesen@nextframe.net
In-Reply-To: <200204291142.AA00055@prism.kumin.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
X-Editor: VIM - Vi IMproved 6.0
X-Keyboard: PFU Happy Hacking Keyboard
X-Operating-System: Slackware Linux (of course)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Seiichi

On Mon, Apr 29, 2002 at 08:42:46PM +0900, Seiichi Nakashima wrote:
> Hi.
> 
> I compile linux-2.5.11 ( gcc-2.95.3 ), but compile error occured at framebuffer.
> Then I recompile linux-2.5.11 without framebuffer, but compile error again.
> 
> 
> ide.c: In function `reset_pollfunc':
> ide.c:603: warning: assignment discards qualifiers from pointer target type
> eepro100.c:2252: warning: `eepro100_remove_one' defined but not used

just warnings ...

> bluesmoke.c: In function `intel_thermal_interrupt':
> bluesmoke.c:36: warning: implicit declaration of function `ack_APIC_irq'
> bluesmoke.c: In function `intel_init_thermal':
> bluesmoke.c:92: warning: implicit declaration of function `apic_read'
> bluesmoke.c:104: warning: implicit declaration of function `apic_write_around'
> arch/i386/kernel/kernel.o: In function `intel_thermal_interrupt':
> arch/i386/kernel/kernel.o(.text+0x7221): undefined reference to `ack_APIC_irq'
> arch/i386/kernel/kernel.o: In function `intel_init_thermal':
> arch/i386/kernel/kernel.o(.text.init+0x2ad2): undefined reference to `apic_read'
> arch/i386/kernel/kernel.o(.text.init+0x2b12): undefined reference to `apic_write_around'
> arch/i386/kernel/kernel.o(.text.init+0x2b31): undefined reference to `apic_read'
> arch/i386/kernel/kernel.o(.text.init+0x2b41): undefined reference to `apic_write_around'
> make: *** [vmlinux] Error 1

well, the P4/Xeon Thermal stuff depends on APIC support ... bluesmoke.c uses 
ack_APIC_irq() and friends.

> 
> --------------------------------
>   Seiichi Nakashima
>   Email   nakasima@kumin.ne.jp
> --------------------------------
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

== Morten

-- 

"Livet er ikke for nybegynnere" - sitat fra en klok person.

mvh
Morten Helgesen 
UNIX System Administrator & C Developer 
Nextframe AS
admin@nextframe.net / 93445641
http://www.nextframe.net
