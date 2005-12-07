Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030275AbVLGGep@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030275AbVLGGep (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 01:34:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030242AbVLGGep
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 01:34:45 -0500
Received: from smtp103.sbc.mail.re2.yahoo.com ([68.142.229.102]:59982 "HELO
	smtp103.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1030275AbVLGGeo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 01:34:44 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Jasper Spaans <jasper@vs19.net>
Subject: Re: [patch] patchlet for logips2pp.c
Date: Wed, 7 Dec 2005 01:34:42 -0500
User-Agent: KMail/1.8.3
Cc: vojtech@suse.cz, linux-kernel@vger.kernel.org
References: <20051205151302.GB25577@spaans.vs19.net>
In-Reply-To: <20051205151302.GB25577@spaans.vs19.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512070134.42825.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 05 December 2005 10:13, Jasper Spaans wrote:
> Hi,
> 
> When booting, my kernel spits out:
> 
> [4294670.033000] logips2pp: Detected unknown logitech mouse model 85
> [4294670.106000] input: ImPS/2 Logitech Wheel Mouse as /class/input/input2
> 
> This is a simple wheel mouse, so the following patch should be OK for this
> model:
> 
> diff --git a/drivers/input/mouse/logips2pp.c b/drivers/input/mouse/logips2pp.c
> index 31a59f7..9a0bbe8 100644
> --- a/drivers/input/mouse/logips2pp.c
> +++ b/drivers/input/mouse/logips2pp.c
> @@ -226,6 +226,7 @@ static struct ps2pp_info *get_model_info
>  		{ 80,	PS2PP_KIND_WHEEL,	PS2PP_SIDE_BTN | PS2PP_WHEEL },
>  		{ 81,	PS2PP_KIND_WHEEL,	PS2PP_WHEEL },
>  		{ 83,	PS2PP_KIND_WHEEL,	PS2PP_WHEEL },
> +		{ 85,	PS2PP_KIND_WHEEL,	PS2PP_WHEEL },
>  		{ 86,	PS2PP_KIND_WHEEL,	PS2PP_WHEEL },
>  		{ 88,	PS2PP_KIND_WHEEL,	PS2PP_WHEEL },
>  		{ 96,	0,			0 },
> 
> 
> Cheers,

I will add this to my tree.

Thanks!

-- 
Dmitry
