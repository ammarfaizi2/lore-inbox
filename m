Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280876AbRKGRno>; Wed, 7 Nov 2001 12:43:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280875AbRKGRne>; Wed, 7 Nov 2001 12:43:34 -0500
Received: from kitkat.hotpop.com ([204.57.55.30]:64775 "HELO kitkat.hotpop.com")
	by vger.kernel.org with SMTP id <S280873AbRKGRnW>;
	Wed, 7 Nov 2001 12:43:22 -0500
Message-ID: <3BE972AC.6000001@toughguy.net>
Date: Wed, 07 Nov 2001 11:43:08 -0600
From: Lost Logic <lostlogic@toughguy.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.5) Gecko/20011012
X-Accept-Language: en-us
MIME-Version: 1.0
To: Maxwell Spangler <maxwax@mindspring.com>, linux-kernel@vger.kernel.org
Subject: Re: Athlon Bug Stomper Success Reports for 2.4.14
In-Reply-To: <Pine.LNX.4.33.0111070045320.20152-100000@tyan.doghouse.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-HotPOP: -----------------------------------------------
                   Sent By HotPOP.com FREE Email
             Get your FREE POP email at www.HotPOP.com
          -----------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Now by athlon optimizations, you just mean setting "Processor Type" to 
Athlon/Duron/K7, right?  if that is the case, my athlon 1.0ghz worked as 
of kernel 2.4.9 on an Epox 8kta+.

--Brandon

Maxwell Spangler wrote:

>My Athlon Thunderbird has been happily compiling kernels for over 24 hours
>straight using 2.4.14 with an Athlon-optimized kernel.  It could not do this
>in many past kernels and I believe the code snippet offered in September is
>working nicely.  There was a long thread about this back then, but I haven't
>seen any Athlon problem reports between that time and now.  For the lurkers on
>the list, and the benefit of archives, could we please record a few successes?
>
>If you are using an Athlon with 2.4.14 and you previously had problems but now
>have stability with an Athlon optimized, kernel, please respond.  (Just a few
>people, please.)
>
>Oh, hardware is Tyan Trinity KT-A (S2390B) with Athlon Thunderbird 1.2Ghz,
>512M Crucial PC133 Cas2 RAM, many drives..etc.
>
>My sincere appreciation and thanks to all that were involved in tracking this
>down and making the fix possible.
>
>/*
> * Nobody seems to know what this does. Damn.
> *
> * But it does seem to fix some unspecified problem
> * with 'movntq' copies on Athlons.
> *
> * VIA 8363 chipset:
> *  - bit 7 at offset 0x55: Debug (RW)
> */
>static void __init pci_fixup_via_athlon_bug(struct pci_dev *d)
>{
>  u8 v;
>  pci_read_config_byte(d, 0x55, &v);
>  if (v & 0x80) {
>    printk("Trying to stomp on Athlon bug...\n");
>    v &= 0x7f; /* clear bit 55.7 */
>    pci_write_config_byte(d, 0x55, v);
>  }
>}
>
>-------------------------------------------------------------------------------
>Maxwell Spangler
>Program Writer
>Greenbelt, Maryland, U.S.A.
>Washington D.C. Metropolitan Area
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>




