Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932491AbWBXVJx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932491AbWBXVJx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 16:09:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932495AbWBXVJx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 16:09:53 -0500
Received: from tetsuo.zabbo.net ([207.173.201.20]:19386 "EHLO tetsuo.zabbo.net")
	by vger.kernel.org with ESMTP id S932491AbWBXVJw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 16:09:52 -0500
Message-ID: <43FF7615.8020504@zabbo.net>
Date: Fri, 24 Feb 2006 13:09:41 -0800
From: Zach Brown <zab@zabbo.net>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/13] maestro3 vfree NULL check fixup
References: <200602242148.27855.jesper.juhl@gmail.com>
In-Reply-To: <200602242148.27855.jesper.juhl@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesper Juhl wrote:
> vfree() checks for NULL, no need to do it explicitly.

>  static void free_dsp_suspendmem(struct m3_card *card)
>  {
> -   if(card->suspend_mem)
> -       vfree(card->suspend_mem);
> +    vfree(card->suspend_mem);
>  }

eh, I'd just get rid of the helper and call vfree() from both sites.

- z
