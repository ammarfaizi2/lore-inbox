Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129269AbRBALt5>; Thu, 1 Feb 2001 06:49:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129613AbRBALtr>; Thu, 1 Feb 2001 06:49:47 -0500
Received: from aragorn.ics.muni.cz ([147.251.4.33]:65259 "EHLO
	aragorn.ics.muni.cz") by vger.kernel.org with ESMTP
	id <S129269AbRBALtg>; Thu, 1 Feb 2001 06:49:36 -0500
Newsgroups: cz.muni.redir.linux-kernel
Path: news
From: Zdenek Kabelac <kabi@fi.muni.cz>
Subject: Re: BUG
Message-ID: <3A794D4A.CA113571@fi.muni.cz>
Date: Thu, 1 Feb 2001 11:49:30 GMT
To: Grzegorz Sojka <grzes@prioris.mini.pw.edu.pl>
X-Nntp-Posting-Host: dual.fi.muni.cz
Content-Transfer-Encoding: 7bit
X-Accept-Language: Czech, en
Content-Type: text/plain; charset=iso-8859-2
In-Reply-To: <Pine.BSF.4.21.0101312339170.38659-100000@prioris.mini.pw.edu.pl>
Mime-Version: 1.0
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.1-pre12-RTL3.11b i686)
Organization: unknown
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Grzegorz Sojka wrote:
> 
> I am using kernel v2.4.0 on Abit BP6 with two Intel Pentium Celeron
> 366@517Mhz + video based on Riva TNT2 M64 32Mb + network card 3com 3c905b
> + Creative Sound Blaster 64 pnp isa and hercules video card. I'm geting
> all over the time messages like that:
> Jan 31 23:37:16 Zeus kernel: APIC error on CPU0: 02(02)
> Jan 31 23:37:17 Zeus kernel: APIC error on CPU1: 02(08)

Enjoy this wonderful patch :)

--- linux.orig/arch/i386/kernel/apic.c  Tue Jan 23 21:41:23 2001
+++ linux/arch/i386/kernel/apic.c       Tue Jan 23 21:40:41 2001
@@ -765,6 +765,7 @@
        v1 = apic_read(APIC_ESR);
        ack_APIC_irq();
        irq_err_count++;
+       if (1) return;
 
        /* Here is what the APIC error bits mean:
           0: Send CS error


It's not fix - you just don't get this borring message....


-- 
             There are three types of people in the world:
               those who can count, and those who can't.
  Zdenek Kabelac  http://i.am/kabi/ kabi@i.am {debian.org; fi.muni.cz}

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
