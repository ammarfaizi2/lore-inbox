Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751334AbWHITrW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751334AbWHITrW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 15:47:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751315AbWHITrW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 15:47:22 -0400
Received: from wx-out-0506.google.com ([66.249.82.232]:5436 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751334AbWHITrV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 15:47:21 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=bpM56j9Hhe/lfoS8FeE7V3BLcCBYulyRYhTTvT9xkxTyYVVIy7dQDwvVIv37gjLnrUKEKkckzDm6cmgyuYeY9rTDaksesJDcqGxKjUQO3vuda+AcZWITxAMekZx+Z8lkLlhmyJ3tILWm2NKB5iADil+Z0BHjAwCrqd4I0UVel3M=
Message-ID: <b637ec0b0608091247u7d0b7b5ds202b5e89599e8e2d@mail.gmail.com>
Date: Wed, 9 Aug 2006 21:47:20 +0200
From: "Fabio Comolli" <fabio.comolli@gmail.com>
To: "Dmitry Torokhov" <dtor@insightbb.com>
Subject: Re: 2.6.18-rc3-mm2
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, "Andrew Morton" <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <200608082347.22544.dtor@insightbb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060806030809.2cfb0b1e.akpm@osdl.org>
	 <d120d5000608081124s53777b42v4bb4d48c90f6a59e@mail.gmail.com>
	 <b637ec0b0608081136o3adf98dbn15e206c8eea41a1c@mail.gmail.com>
	 <200608082347.22544.dtor@insightbb.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry.

On 8/9/06, Dmitry Torokhov <dtor@insightbb.com> wrote:
> Could you please try applying the patch below on top of -rc3-mm2 and
> see if it works without needing i8042.nomux?
>

Yes, it works for me too. However, Andrew put a revert patch for
remove-polling-timer-from-i8042-v2.patch in his hot-fixes directory.
So, which one should be considered the correct fix?

> Thank you!
>
> --
> Dmitry

Ciao.
Fabio



>
> Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
> ---
>
>  drivers/input/serio/i8042.c |    2 +-
>  1 files changed, 1 insertion(+), 1 deletion(-)
>
> Index: work/drivers/input/serio/i8042.c
> ===================================================================
> --- work.orig/drivers/input/serio/i8042.c
> +++ work/drivers/input/serio/i8042.c
> @@ -435,7 +435,7 @@ static int i8042_enable_mux_ports(void)
>                 i8042_command(&param, I8042_CMD_AUX_ENABLE);
>         }
>
> -       return 0;
> +       return i8042_enable_aux_port();
>  }
>
>  /*
>
