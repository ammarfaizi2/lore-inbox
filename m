Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267548AbUIUIxf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267548AbUIUIxf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Sep 2004 04:53:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267536AbUIUIwZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Sep 2004 04:52:25 -0400
Received: from styx.suse.cz ([82.119.242.94]:13185 "EHLO shadow.ucw.cz")
	by vger.kernel.org with ESMTP id S267537AbUIUIu4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Sep 2004 04:50:56 -0400
Date: Tue, 21 Sep 2004 10:51:16 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Stelian Pop <stelian@popies.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Add sonypi specific events to the input layer
Message-ID: <20040921085116.GD10757@ucw.cz>
References: <20040917104226.GB3089@crusoe.alcove-fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040917104226.GB3089@crusoe.alcove-fr>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 17, 2004 at 12:42:27PM +0200, Stelian Pop wrote:
> Hi,
> 
> The following patch adds some sonypi specific events to the input
> layer. 
> 
> When possible (for KEY_BACK, KEY_HELP, KEY_ZOOM, KEY_CAMERA for example)
> I used the existing events, but some events just have no mapping.
> 
> Once this patch is accepted (if it is :) ), I will follow with a patch
> for sonypi adding full input support for (almost) all the Vaio events.
> 
> Thanks,
> 
> Stelian.
> 
> Signed-off-by: Stelian Pop <stelian@popies.net>

Looking at the definitions below - wouldn't it be better to just define
the "FN" key and report everything else as key combinations?

> ===== linux-2.6/include/linux/input.h 1.50 vs edited =====
> --- 1.50/include/linux/input.h	2004-06-06 11:08:11 +02:00
> +++ edited/linux-2.6/include/linux/input.h	2004-09-17 10:26:15 +02:00
> @@ -473,6 +473,28 @@
>  #define KEY_INS_LINE		0x1c2
>  #define KEY_DEL_LINE		0x1c3
>  
> +#define KEY_FN			0x1d0
> +#define KEY_FN_ESC		0x1d1
> +#define KEY_FN_F1		0x1d2
> +#define KEY_FN_F2		0x1d3
> +#define KEY_FN_F3		0x1d4
> +#define KEY_FN_F4		0x1d5
> +#define KEY_FN_F5		0x1d6
> +#define KEY_FN_F6		0x1d7
> +#define KEY_FN_F7		0x1d8
> +#define KEY_FN_F8		0x1d9
> +#define KEY_FN_F9		0x1da
> +#define KEY_FN_F10		0x1db
> +#define KEY_FN_F11		0x1dc
> +#define KEY_FN_F12		0x1dd
> +#define KEY_FN_1		0x1de
> +#define KEY_FN_2		0x1df
> +#define KEY_FN_D		0x1e0
> +#define KEY_FN_E		0x1e1
> +#define KEY_FN_F		0x1e2
> +#define KEY_FN_S		0x1e3
> +#define KEY_FN_B		0x1e4
> +
>  #define KEY_MAX			0x1ff
>  
>  /*
> -- 
> Stelian Pop <stelian@popies.net>    
> 

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
