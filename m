Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270585AbRH1JWy>; Tue, 28 Aug 2001 05:22:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270577AbRH1JWo>; Tue, 28 Aug 2001 05:22:44 -0400
Received: from [194.213.32.137] ([194.213.32.137]:260 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S270569AbRH1JW0>;
	Tue, 28 Aug 2001 05:22:26 -0400
Message-ID: <20010828004628.B1357@bug.ucw.cz>
Date: Tue, 28 Aug 2001 00:46:28 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Jan Niehusmann <jan@gondor.com>
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: VCool - cool your Athlon/Duron during idle
In-Reply-To: <20010826181315Z271401-760+6195@vger.kernel.org> <20010827010053.A9149@gondor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <20010827010053.A9149@gondor.com>; from Jan Niehusmann on Mon, Aug 27, 2001 at 01:00:53AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> +static void stpclk_idle(void)
> +{
> +	if (current_cpu_data.hlt_works_ok && !hlt_counter) {
> +		__cli();
> +		if (!current->need_resched) 
> +			inb(Reg_PL2);
> +		else
> +			__sti();
> +	}
> +}

You are not using hlt instruction -> you don't need to care about
hlt_works_ok.
							Pavel
-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
