Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129860AbQLTKPZ>; Wed, 20 Dec 2000 05:15:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129939AbQLTKPH>; Wed, 20 Dec 2000 05:15:07 -0500
Received: from hermes.mixx.net ([212.84.196.2]:26629 "HELO hermes.mixx.net")
	by vger.kernel.org with SMTP id <S129835AbQLTKOu>;
	Wed, 20 Dec 2000 05:14:50 -0500
Message-ID: <3A407F75.2A8F5188@innominate.com>
Date: Wed, 20 Dec 2000 10:44:21 +0100
From: Juri Haberland <juri.haberland@innominate.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.19pre2 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: "Andreas M. Kirchwitz" <amk@krell.snafu.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix emu10k1 init breakage in 2.2.18
In-Reply-To: <200012191201.NAA02004@harpo.it.uu.se> <slrn93vb44.enh.amk@krell.zikzak.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Andreas M. Kirchwitz" wrote:
> 
> Mikael Pettersson wrote:
> 
>  > 2.2.18 broke the emu10k1 driver when compiled into the kernel.
>  > The problem is that 2.2.18 now implements 2.4-style module_init,
>  > so emu10k1 ended up being initialised twice when built non-modular,
>  > which rendered it dysfunctional. The fix is to remove the now
>  > obsolete explicit init calls. Patch below. Please apply.
> 
> Is there also a fix available to make the bass and treble settings
> work again in mixer applications (for example, Gnome mix 1.2.0)?
> This is (now, was) one of the biggest advantages of this card to have
> control over bass and treble settings.
> 
> It worked for the early 2.2.18pre patches, but stopped working in
> the latest ones (including final 2.2.18).

Yes, put something like "EXTRA_CFLAGS += -DTONE_CONTROL" into the
Makefile in drivers/sound/emu10k1/

Juri

-- 
juri.haberland@innominate.com
system engineer                                         innominate AG
clustering & security                            the linux architects
tel: +49-30-308806-45   fax: -77            http://www.innominate.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
