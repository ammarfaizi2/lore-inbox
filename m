Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262168AbVBJRdh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262168AbVBJRdh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Feb 2005 12:33:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262170AbVBJRdh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Feb 2005 12:33:37 -0500
Received: from db.org ([195.159.29.201]:30889 "EHLO mail.maildialog.com")
	by vger.kernel.org with ESMTP id S262168AbVBJRdd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Feb 2005 12:33:33 -0500
Message-ID: <420B9A59.3040807@cluded.net>
Date: Thu, 10 Feb 2005 17:31:05 +0000
From: "Daniel K." <dk@cluded.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8b) Gecko/20050209
MIME-Version: 1.0
To: Stelian Pop <stelian@popies.net>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 2/5] sonypi: add another HELP button event
References: <20050210154542.GG3493@crusoe.alcove-fr>
In-Reply-To: <20050210154542.GG3493@crusoe.alcove-fr>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stelian Pop wrote:
> ===================================================================
> 
> Add another HELP button event.
> Increment the version number.
> 

> 
> Index: drivers/char/sonypi.h
> ===================================================================
> --- a/drivers/char/sonypi.h	(revision 26539)
> +++ b/drivers/char/sonypi.h	(revision 26540)

> @@ -330,6 +330,7 @@ struct sonypi_eventtypes {
>  	{ SONYPI_DEVICE_MODEL_TYPE2, 0x08, SONYPI_PKEY_MASK, sonypi_pkeyev },
>  	{ SONYPI_DEVICE_MODEL_TYPE2, 0x11, SONYPI_BACK_MASK, sonypi_backev },
>  	{ SONYPI_DEVICE_MODEL_TYPE2, 0x08, SONYPI_HELP_MASK, sonypi_helpev },
> +	{ SONYPI_DEVICE_MODEL_TYPE2, 0x21, SONYPI_HELP_MASK, sonypi_helpev },
>  	{ SONYPI_DEVICE_MODEL_TYPE2, 0x21, SONYPI_ZOOM_MASK, sonypi_zoomev },
>  	{ SONYPI_DEVICE_MODEL_TYPE2, 0x20, SONYPI_THUMBPHRASE_MASK, sonypi_thumbphraseev },
>  	{ SONYPI_DEVICE_MODEL_TYPE2, 0x31, SONYPI_MEMORYSTICK_MASK, sonypi_memorystickev },

I suspect you should simply replace the '0x08' line as it was left over
from my earlier patch introducing EVTYPE_OFFSET. At that time all the
values were 0x08, most was updated, but a few were not, due to
unsuficcient data.

Daniel K.
