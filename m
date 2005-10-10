Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932336AbVJJEGF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932336AbVJJEGF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Oct 2005 00:06:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932337AbVJJEGF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Oct 2005 00:06:05 -0400
Received: from smtp104.sbc.mail.re2.yahoo.com ([68.142.229.101]:48784 "HELO
	smtp104.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S932336AbVJJEGE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Oct 2005 00:06:04 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH2 6/6] isicom: More whitespaces and coding style
Date: Sun, 9 Oct 2005 23:05:57 -0500
User-Agent: KMail/1.8.2
Cc: "Jiri Slaby" <xslaby@fi.muni.cz>, Andrew Morton <akpm@osdl.org>
References: <20051009194241.4821E22AF10@anxur.fi.muni.cz>
In-Reply-To: <20051009194241.4821E22AF10@anxur.fi.muni.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510092305.58010.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 09 October 2005 14:42, Jiri Slaby wrote:
> More whitespaces and coding style
> 
> Wrap all the code to 80 chars on a line.
> Some `}\nelse' changed to `} else'.
> Clean whitespaces in header file.
> 
> Generated in 2.6.14-rc2-mm2 kernel version
> 
> Signed-off-by: Jiri Slaby <xslaby@fi.muni.cz>
> 
> ---
>  drivers/char/isicom.c  |  148 +++++++++++++++++++++++-------------------------
>  include/linux/isicom.h |   21 +++----
>  2 files changed, 82 insertions(+), 87 deletions(-)
> 
> diff --git a/drivers/char/isicom.c b/drivers/char/isicom.c
> --- a/drivers/char/isicom.c
> +++ b/drivers/char/isicom.c
> @@ -467,33 +467,36 @@ static void isicom_tx(unsigned long _dat
>  		residue = NO;
>  		wrd = 0;
>  		while (1) {
> -			cnt = min_t(int, txcount, (SERIAL_XMIT_SIZE - port->xmit_tail));
> +			cnt = min_t(int, txcount, (SERIAL_XMIT_SIZE
> +					- port->xmit_tail));

I am sorry but do you really consider the new form more readable?

> -					wrd |= (port->xmit_buf[port->xmit_tail] << 8);
> -					port->xmit_tail = (port->xmit_tail + 1) & (SERIAL_XMIT_SIZE - 1);
> +					wrd |= (port->xmit_buf[port->xmit_tail]
> +							<< 8);

And this?

> -#ifdef ISICOM_DEBUG
> -						printk(KERN_DEBUG "ISICOM: interrupt: DCD->low.\n");
> -#endif
> +						pr_deb(KERN_DEBUG "ISICOM: "
> +							"interrupt: "
> +							"DCD->low.\n");

And this?

Simply limiting line length to 80 is not enough IMHO, you need to
keep the code readable at the same time.

-- 
Dmitry
