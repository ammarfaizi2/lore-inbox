Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316232AbSEVQUc>; Wed, 22 May 2002 12:20:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316238AbSEVQUb>; Wed, 22 May 2002 12:20:31 -0400
Received: from vivi.uptime.at ([62.116.87.11]:52190 "EHLO vivi.uptime.at")
	by vger.kernel.org with ESMTP id <S316232AbSEVQU3>;
	Wed, 22 May 2002 12:20:29 -0400
Reply-To: <o.pitzeier@uptime.at>
From: "Oliver Pitzeier" <o.pitzeier@uptime.at>
To: "'linux-kernel'" <linux-kernel@vger.kernel.org>,
        <axp-kernel-list@redhat.com>
Cc: <alan@lxorguk.ukuu.org.uk>, <torvalds@transmeta.com>
Subject: RE: Mylex DAC 960 Patch
Date: Wed, 22 May 2002 18:18:56 +0200
Organization: =?us-ascii?Q?UPtime_Systemlosungen?=
Message-ID: <001a01c201ac$626e6580$010b10ac@sbp.uptime.at>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.3416
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
In-Reply-To: <001601c201a7$b69eecb0$010b10ac@sbp.uptime.at>
Importance: Normal
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry... I forgot to add a subject for this mail...

> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org 
> [mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of 
> Oliver Pitzeier
> Sent: Wednesday, May 22, 2002 5:45 PM
> To: 'linux-kernel'; axp-kernel-list@redhat.com
> Cc: alan@lxorguk.ukuu.org.uk; torvalds@transmeta.com
> Subject: 
> 
> 
> Hi volks/Linus/Alan!
> 
> I would suggest to add this patch to the kernel tree.
> It works with 2.4.18 and 2.4.18-grsec-1.9.4.
> 
> Without this I was not able to boot from my Mylex DAC960PD 
> and maybe someone else has this problem as well!? I guess so, 
> because I read about many people having problems installing 
> Linux on an Alpha AS1000, which normally comes with the 
> controller mentioned above...
> 
> Please let me know if this is OK.
> 
> *** linux/init/main.c.orig      Wed May 22 15:18:45 2002
> --- linux/init/main.c   Wed May 22 17:28:32 2002
> ***************
> *** 243,246 ****
> --- 243,266 ----
>         { "ida/c0d15p",0x48F0 },
>   #endif
> + #if defined(CONFIG_BLK_DEV_DAC960)
> +         { "rd/c0d0p",0x3000 },
> +         { "rd/c0d0p1",0x3001 },
> +         { "rd/c0d0p2",0x3002 },
> +         { "rd/c0d0p3",0x3003 },
> +         { "rd/c0d0p4",0x3004 },
> +         { "rd/c0d0p5",0x3005 },
> +         { "rd/c0d0p6",0x3006 },
> +         { "rd/c0d0p7",0x3007 },
> +         { "rd/c0d0p8",0x3008 },
> +         { "rd/c0d1p",0x3008 },
> +         { "rd/c0d1p1",0x3009 },
> +         { "rd/c0d1p2",0x300a },
> +         { "rd/c0d1p3",0x300b },
> +         { "rd/c0d1p4",0x300c },
> +         { "rd/c0d1p5",0x300d },
> +         { "rd/c0d1p6",0x300e },
> +         { "rd/c0d1p7",0x300f },
> +         { "rd/c0d1p8",0x3010 },
> + #endif
>   #if defined(CONFIG_BLK_CPQ_CISS_DA) ||
> defined(CONFIG_BLK_CPQ_CISS_DA_MODULE)
>         { "cciss/c0d0p",0x6800 },
> 
> 
> 
> Best regards,
>  Greetz,
>    Oliver
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in the body of a message to 
> majordomo@vger.kernel.org More majordomo info at  
http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/


