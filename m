Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132496AbRDNRpR>; Sat, 14 Apr 2001 13:45:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132501AbRDNRpE>; Sat, 14 Apr 2001 13:45:04 -0400
Received: from ns.suse.de ([213.95.15.193]:53771 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S132496AbRDNRoh>;
	Sat, 14 Apr 2001 13:44:37 -0400
To: "W. Michael Petullo" <mike@flyn.org>
Cc: gniibe@mri.co.jp, linux-kernel@vger.kernel.org
Subject: Re: patch for PLIP and slow, interrupt-less computers
In-Reply-To: <20010412164653.A10864@dragon.flyn.org>
X-Yow: Put FIVE DOZEN red GIRDLES in each CIRCULAR OPENING!!
From: Andreas Schwab <schwab@suse.de>
Date: 14 Apr 2001 19:44:33 +0200
In-Reply-To: <20010412164653.A10864@dragon.flyn.org>
Message-ID: <jeeluvtlz2.fsf@hawking.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.0.103
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"W. Michael Petullo" <mike@flyn.org> writes:

|> Here is the patch:
|> 
|> ================================================================================
|> 
|> --- plip.c	Tue Feb 13 16:15:05 2001
|> +++ /tmp/linux/drivers/net/plip.c	Thu Apr 12 16:07:07 2001
|> @@ -137,10 +137,10 @@
|>  #define PLIP_DELAY_UNIT		   1
|>  
|>  /* Connection time out = PLIP_TRIGGER_WAIT * PLIP_DELAY_UNIT usec */
|> -#define PLIP_TRIGGER_WAIT	 500
|> +static unsigned long trigger_wait = 500;
           ^^^^^^^^^^^^^
|>  
|>  /* Nibble time out = PLIP_NIBBLE_WAIT * PLIP_DELAY_UNIT usec */
|> -#define PLIP_NIBBLE_WAIT        3000
|> +static unsigned long nibble_wait = 3000;
           ^^^^^^^^^^^^^
|> @@ -1297,6 +1297,8 @@
|>  
|>  MODULE_PARM(parport, "1-" __MODULE_STRING(PLIP_MAX) "i");
|>  MODULE_PARM(timid, "1i");
|> +MODULE_PARM(trigger_wait, "i");
|> +MODULE_PARM(nibble_wait, "i");
                             ^^^
The types don't match.

Andreas.

-- 
Andreas Schwab                                  "And now for something
SuSE Labs                                        completely different."
Andreas.Schwab@suse.de
SuSE GmbH, Schanzäckerstr. 10, D-90443 Nürnberg
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
