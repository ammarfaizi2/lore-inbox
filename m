Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316887AbSGSQeF>; Fri, 19 Jul 2002 12:34:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316895AbSGSQeF>; Fri, 19 Jul 2002 12:34:05 -0400
Received: from p508292CF.dip.t-dialin.net ([80.130.146.207]:12550 "EHLO
	Marvin.DL8BCU.ampr.org") by vger.kernel.org with ESMTP
	id <S316887AbSGSQeE>; Fri, 19 Jul 2002 12:34:04 -0400
Date: Fri, 19 Jul 2002 16:36:55 +0000
From: Thorsten Kranzkowski <dl8bcu@dl8bcu.de>
To: Andrew Rodland <arodland@noln.com>
Cc: linux-kernel@vger.kernel.org, alan@redhat.com
Subject: Re: [PATCH -ac] Panicking in morse code
Message-ID: <20020719163654.A6010@Marvin.DL8BCU.ampr.org>
Reply-To: dl8bcu@dl8bcu.de
Mail-Followup-To: Andrew Rodland <arodland@noln.com>,
	linux-kernel@vger.kernel.org, alan@redhat.com
References: <20020719011300.548d72d5.arodland@noln.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20020719011300.548d72d5.arodland@noln.com>; from arodland@noln.com on Fri, Jul 19, 2002 at 01:13:00AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 19, 2002 at 01:13:00AM -0400, Andrew Rodland wrote:
> I was researching panic_blink() for someone who needed a little help,
> when I noticed the comment above the function definition, not being the
> kind to step down from a challenge (unless it's just really hard), I
> decided to write morse code output code.

nice idea :)

> diff -u -r -d linux.old/drivers/char/pc_keyb.c linux/drivers/char/pc_keyb.c
> --- linux.old/drivers/char/pc_keyb.c	Fri Jul 19 00:59:04 2002
> +++ linux/drivers/char/pc_keyb.c	Fri Jul 19 01:00:34 2002
> @@ -1244,37 +1244,126 @@
>  #endif /* CONFIG_PSMOUSE */

[...]

> +static const char * morse[] = {
> +	".-", "-...", "-.-.", "-..", ".", "..-.", "--.", "....", /* A-H */
> +	"..", ".---.", "-.-", ".-..", "--", "-.", "---", ".--.", /* I-P */

This should read:

	"..", ".---", "-.-", ".-..", "--", "-.", "---", ".--.", /* I-P */

i.e. there's a dot too much :)

> +	"--.-", ".-.", "...", "-", "..-", "...-", ".--", "-..-", /* Q-X */
> +	"-.--", "--..",	 	 	 	 	 	 /* Y-Z */
> +	"-----", ".----", "..---", "...--", "....-",	 	 /* 0-4 */
> +	".....", "-....", "--...", "---..", "----."	 	 /* 5-9 */
> +};

73, Thorsten

-- 
| Thorsten Kranzkowski        Internet: dl8bcu@dl8bcu.de                      |
| Mobile: ++49 170 1876134       Snail: Niemannsweg 30, 49201 Dissen, Germany |
| Ampr: dl8bcu@db0lj.#rpl.deu.eu, dl8bcu@marvin.dl8bcu.ampr.org [44.130.8.19] |
