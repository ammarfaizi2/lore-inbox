Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265890AbTATOeL>; Mon, 20 Jan 2003 09:34:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265886AbTATOeL>; Mon, 20 Jan 2003 09:34:11 -0500
Received: from inet-mail2.oracle.com ([148.87.2.202]:8599 "EHLO
	inet-mail2.oracle.com") by vger.kernel.org with ESMTP
	id <S265894AbTATOeK>; Mon, 20 Jan 2003 09:34:10 -0500
Message-ID: <7622343.1043073494737.JavaMail.nobody@web155>
Date: Mon, 20 Jan 2003 06:38:14 -0800 (GMT-08:00)
From: Alessandro Suardi <ALESSANDRO.SUARDI@oracle.com>
To: mikpe@csd.uu.se
Subject: Re: "Latitude with broken BIOS" ?
Cc: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-Mailer: Oracle Webmail Client
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mikael Pettersson wrote:

> On Mon, 20 Jan 2003 04:31:58 -0800 (GMT-08:00), Alessandro Suardi wrote:
> >  I was hoping to use HT on my new Latitude C640 (P4 @ 1.8Ghz) but at boot
> >  both 2.4.21-pre3 and 2.5.59 (obviously with a SMP kernel) tell me
> >
> > "Dell Latitude with broken BIOS detected. Refusing to enable the local APIC."
> >
> > Is this anything that can be played with ?
>
> First of all, your 1.8GHz mobile P4 doesn't actually have HT.
> The only ones to have it are the new 3.06GHz P4s, and most Xeons.

Ok.

> Secondly, I'm responsible for the message you quoted. Many if not all
> Pentium III-based Dell laptops (including Latitude Cnnn and I8nnn)
> that have local-APIC capable processors fail miserably if the OS
> actually enables it. For instance, pulling or inserting the DC
> power plug would hang the machine. This is a BIOS bug we can't work
> around, except by refusing to enable the local APIC.
>
> Your P4-based Latitude probably has a different BIOS than the buggy
> P3-based ones, and it may work better. Try commenting out the
> local_apic_kills_bios entry for "Dell Latitude" at around line 692
> in arch/i386/kernel/dmi_scan.c and rebuild the kernel. If it

(ahem) I had tried that in 2.5.58 already ;)

However I rebuilt 2.5.59 with that change, and I'm not going further:

 No local APIC present or hardware disabled

I have both CONFIG_X86_IO_APIC and CONFIG_X86_LOCAL_APIC=y.

(while I'm using my old PIII/750 the PIV is still okay for testing ;)


Ciao,

--alessandro
