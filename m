Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135874AbREIXly>; Wed, 9 May 2001 19:41:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135879AbREIXlp>; Wed, 9 May 2001 19:41:45 -0400
Received: from paloma16.e0k.nbg-hannover.de ([62.159.219.16]:55007 "HELO
	paloma16.e0k.nbg-hannover.de") by vger.kernel.org with SMTP
	id <S135874AbREIXlh>; Wed, 9 May 2001 19:41:37 -0400
Content-Type: text/plain; charset=US-ASCII
From: Dieter =?iso-8859-1?q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
Organization: DN
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: REVISED: Experimentation with Athlon and fast_page_copy
Date: Thu, 10 May 2001 01:56:54 +0200
X-Mailer: KMail [version 1.2]
In-Reply-To: <E14vwGE-0000IQ-00@the-village.bc.nu>
In-Reply-To: <E14vwGE-0000IQ-00@the-village.bc.nu>
Cc: Mark Hahn <hahn@coffee.psychology.mcmaster.ca>,
        "Justin T. Gibbs" <gibbs@scsiguy.com>,
        "Linux Kernel List" <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <01051001565400.00893@SunWave1>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Samstag,  5. Mai 2001 09:13 schrieben Sie:
> > My (very) old Athlon 550 (model 1, stepping 2) show it on my MSI MS-6167
> > (AMD Irongate C4) with your 2.4.4-ac5, now :-(
>
> Manfred has a good explanation for that. Im hoping it also explains the
> VIA problem too
>
> > I am open for any test fixes...
>
> Watch this space -> <- ;)
>
> Alan

Sorry for my noise!
My problem was NOT fast_page_copy related.
It was Justin's aic7xxx 6.1.12 release.
His latest 6.1.13 (2.4.4-ac6) fixed it for me.

My MSI MS-6167 (AMD Irongate C4) is running very well with APIC (it haven't 
really have one) and ACPI (latest) enabled.

Below are some MMX copy results.

Thanks anyway.
	Dieter

BTW Where can I grep the bench with MB/sec output?

SunWave1>./athlon
Athlon test program $Id: fast.c,v 1.6 2000/09/23 09:05:45 arjan Exp $
clear_page() tests
clear_page function 'warm up run'        took 17396 cycles per page
clear_page function '2.4 non MMX'        took 9582 cycles per page
clear_page function '2.4 MMX fallback'   took 9031 cycles per page
clear_page function '2.4 MMX version'    took 7905 cycles per page
clear_page function 'faster_clear_page'  took 8237 cycles per page
clear_page function 'even_faster_clear'  took 8151 cycles per page
 
copy_page() tests
copy_page function 'warm up run'         took 12565 cycles per page
copy_page function '2.4 non MMX'         took 17273 cycles per page
copy_page function '2.4 MMX fallback'    took 17481 cycles per page
copy_page function '2.4 MMX version'     took 12507 cycles per page
copy_page function 'faster_copy'         took 13641 cycles per page
copy_page function 'even_faster'         took 12707 cycles per page

