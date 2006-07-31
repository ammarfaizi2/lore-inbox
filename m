Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030354AbWGaTdU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030354AbWGaTdU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 15:33:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030355AbWGaTdU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 15:33:20 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:59299 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1030354AbWGaTdT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 15:33:19 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:to:cc:subject:message-id:mail-followup-to:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:from;
        b=dtUgrPIgI2dgCS5h2776HqZBND9NsA+cZnxV3QMwSbCncbUL04aEpwLzJ7NgNoSsbnRskM96zMfsfbI03zjxK5g3CSRGrExbAubyno/q2j4OF/Y6b4yArWWvDj3Q5KSpuOc2AUMYJkT8yb4iS+dUcnJvQaQNzP8ONn28TaeXEC8=
Date: Mon, 31 Jul 2006 15:32:55 -0400
To: Edgar Hucek <hostmaster@ed-soft.at>
Cc: LKML <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@osdl.org>,
       akpm@osdl.org
Subject: Re: [PATCH 1/3] add-imacfb-docu-and-detection.patch
Message-ID: <20060731193254.GA31594@nineveh.rivenstone.net>
Mail-Followup-To: Edgar Hucek <hostmaster@ed-soft.at>,
	LKML <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@osdl.org>, akpm@osdl.org
References: <44CDBE5D.8020504@ed-soft.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44CDBE5D.8020504@ed-soft.at>
User-Agent: Mutt/1.5.11
From: jfannin@gmail.com (Joseph Fannin)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 31, 2006 at 10:25:01AM +0200, Edgar Hucek wrote:
> This Patch add basic Machine detection to imacfb and
> some Ducumentation bits for imacfb.

> +Imacfb does not have any kind of autodetection of your machine.
> +You have to add the fillowing kernel parameters in your elilo.conf:
> +	Macbook :
> +		video=imacfb:macbook
> +	MacMini :
> +		video=imacfb:mini
> +	Macbook Pro 15", iMac 17" :
> +		video=imacfb:i17
> +	Macbook Pro 17", iMac 20" :
> +		video=imacfb:i20

> -	/* ignore error return of fb_get_options */
> -	fb_get_options("imacfb", &option);
> +	if (!efi_enabled)
> +		return -ENODEV;
> +	if (!dmi_check_system(dmi_system_table))
> +		return -ENODEV;
> +	if (model == M_UNKNOWN)
> +		return -ENODEV;

    So imacfb now defaults to off?  That would be good, especially
since it cannot be a module, and doesn't work with the Apple "BIOS"
stuff.

    If not, a video=imacfb:off option would be much appreciated.

--
Joseph Fannin
jfannin@gmail.com

