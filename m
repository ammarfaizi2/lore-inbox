Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265351AbTABRBv>; Thu, 2 Jan 2003 12:01:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265603AbTABRBv>; Thu, 2 Jan 2003 12:01:51 -0500
Received: from [195.39.17.254] ([195.39.17.254]:1028 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S265351AbTABRBu>;
	Thu, 2 Jan 2003 12:01:50 -0500
Date: Wed, 25 Dec 2002 12:56:53 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Andi Kleen <ak@muc.de>
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: [PATCH] Add AMD K8 support to 2.5.53.
Message-ID: <20021225115653.GA1611@zaurus>
References: <20021224160248.GA1632@averell>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021224160248.GA1632@averell>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> @@ -82,6 +82,9 @@ void __init amd_mcheck_init(struct cpuin
>  	nr_mce_banks = l & 0xff;
>  
>  	for (i=0; i<nr_mce_banks; i++) {
> +		/* Don't enable northbridge MCE by default on Hammer */
> +		if (boot_cpu_data.x86_model == 15 && i == 4) 
> +			continue;

Whats wrong with MCE on northbridge? Will
it be an issue for production models, too?

-- 
				Pavel
Written on sharp zaurus, because my Velo1 broke. If you have Velo you don't need...

