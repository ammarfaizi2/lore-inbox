Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286825AbSAZUfG>; Sat, 26 Jan 2002 15:35:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286712AbSAZUe4>; Sat, 26 Jan 2002 15:34:56 -0500
Received: from beasley.gator.com ([63.197.87.202]:30984 "EHLO
	beasley.gator.com") by vger.kernel.org with ESMTP
	id <S286825AbSAZUer>; Sat, 26 Jan 2002 15:34:47 -0500
From: "George Bonser" <george@gator.com>
To: "Keith Owens" <kaos@ocs.com.au>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: Linux console at boot 
Date: Sat, 26 Jan 2002 12:34:38 -0800
Message-ID: <CHEKKPICCNOGICGMDODJEEEDGCAA.george@gator.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
In-Reply-To: <20849.1012041165@ocs3.intra.ocs.com.au>
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well I have been all through the incremental from pre6 to pre7 and
dont see anything obvious that would cause it not to see the disks.
Nobody else has complained of it ... so weird.

>
> Serial console is the best.  If you can't do that, add a delay after
> each set of console output.  Tweak 100000000 to get a
> suitable delay.
>
> Index: 17.1/kernel/printk.c
> --- 17.1/kernel/printk.c Tue, 11 Dec 2001 09:58:50 +1100
> kaos (linux-2.4/j/48_printk.c 1.1.2.2.7.1.2.3 644)
> +++ 17.1(w)/kernel/printk.c Sat, 26 Jan 2002 21:30:53 +1100
> kaos (linux-2.4/j/48_printk.c 1.1.2.2.7.1.2.3 644)
> @@ -373,6 +373,7 @@ static void call_console_drivers(unsigne
>  		}
>  	}
>  	_call_console_drivers(start_print, end, msg_level);
> +	{ int i; for (i = 0; i < 100000000; ++i) ; }
>  }
>
>  static void emit_log_char(char c)

