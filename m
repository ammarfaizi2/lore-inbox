Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932257AbVLIPXB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932257AbVLIPXB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Dec 2005 10:23:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932251AbVLIPXB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Dec 2005 10:23:01 -0500
Received: from zproxy.gmail.com ([64.233.162.197]:27116 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932257AbVLIPW7 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Dec 2005 10:22:59 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=LAFhf20sWTAqdWEOj92ZrzUO8fzbyIhomLPlr5bxr/Mld2odC5NYw4xUbwgiFVsU34G2XY0Zoya/5yth3ASncNwyKrhXebuu/at3MB3w+MDsyn1eoP/v5T4ree+SgAW4bIb6DeFqJYgJS0C8onip2ZtMQIHaxdU68puJcrBW9Kg=
Message-ID: <d120d5000512090722yb975ccah1eef0cde73ca7e88@mail.gmail.com>
Date: Fri, 9 Dec 2005 10:22:57 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Mauro Carvalho Chehab <mchehab@brturbo.com.br>
Subject: Re: [PATCH 29/56] DVB (2390) Adds a time-delay to IR remote button presses for av7110 ir input,
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, mchehab@infradead.org,
       js@linuxtv.org, linux-dvb-maintainer@linuxtv.org,
       Oliver Endriss <o.endriss@gmx.de>
In-Reply-To: <1134137813.10677.7.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1134137813.10677.7.camel@localhost>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/9/05, Mauro Carvalho Chehab <mchehab@brturbo.com.br> wrote:
>  static void input_repeat_key(unsigned long data)
>  {
> -       /* dummy routine to disable autorepeat in the input driver */
> +       /* called by the input driver after rep[REP_DELAY] ms */
> +       delay_timer_finished = 1;
>  }
>

Hi,

I always wondered why many IR drivers re-implement autorepeat code
instead of using autorepeat in the inptu core. Is it because of forced
(by timer) keyup events?

--
Dmitry
