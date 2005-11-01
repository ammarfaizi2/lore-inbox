Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964956AbVKADRM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964956AbVKADRM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 22:17:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964957AbVKADRL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 22:17:11 -0500
Received: from smtp112.sbc.mail.re2.yahoo.com ([68.142.229.93]:58777 "HELO
	smtp112.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S964956AbVKADRK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 22:17:10 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Convert dmasound_awacs to dynamic input_dev allocation
Date: Mon, 31 Oct 2005 22:17:08 -0500
User-Agent: KMail/1.8.3
Cc: Ian Wienand <ianw@gelato.unsw.edu.au>
References: <20051101020329.GA7773@cse.unsw.EDU.AU>
In-Reply-To: <20051101020329.GA7773@cse.unsw.EDU.AU>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510312217.08935.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 31 October 2005 21:03, Ian Wienand wrote:
> Hi,
> 
> This patch converts sound/oss/dmasound/dmasound_awacs.c to use dynamic
> input_dev allocation, stopping an oops on boot with the latest
> kernels.
>

Oh, I see that the piece of code that bitches about device not being
dynamically allocated and bails out was lost on its way to Linus...
Will resend shortly...
 
> +	awacs_beep_dev = input_allocate_device();

We really need to check whether device was allocated here...

-- 
Dmitry
