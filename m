Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265872AbTATPS6>; Mon, 20 Jan 2003 10:18:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265998AbTATPS5>; Mon, 20 Jan 2003 10:18:57 -0500
Received: from inet-mail3.oracle.com ([148.87.2.203]:9171 "EHLO
	inet-mail3.oracle.com") by vger.kernel.org with ESMTP
	id <S265872AbTATPS5>; Mon, 20 Jan 2003 10:18:57 -0500
Message-ID: <4245685.1043076182626.JavaMail.nobody@web54.us.oracle.com>
Date: Mon, 20 Jan 2003 07:23:02 -0800 (PST)
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

> Alessandro Suardi wrote:
>
> > > Your P4-based Latitude probably has a different BIOS than the buggy
> > > P3-based ones, and it may work better. Try commenting out the
> > > local_apic_kills_bios entry for "Dell Latitude" at around line 692
> > > in arch/i386/kernel/dmi_scan.c and rebuild the kernel. If it
> > 
> > (ahem) I had tried that in 2.5.58 already ;)
> > 
> > However I rebuilt 2.5.59 with that change, and I'm not going further:
> > 
> >  No local APIC present or hardware disabled
>
> Ah, your P4 needs another patch. Edit arch/i386/kernel/apic.c, function
> detect_init_APIC(), at line 631, and remove the "&& cpu_has_apic" after
> the "boot_cpu_data.x86 == 15" test. (Or check if your BIOS can be set up
> to boot with the local APIC enabled.)
>
> /Mikael

The BIOS doesn't seem to have any such option... and the code change
 does exactly what you imagined - pull the power cord, instant hang.

It seems even BIOS A05 of the C640 is legitimately blacklisted :(


Thanks, ciao,

--alessandro
