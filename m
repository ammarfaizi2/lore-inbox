Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751127AbWG0AsF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751127AbWG0AsF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 20:48:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751837AbWG0AsF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 20:48:05 -0400
Received: from [210.76.114.181] ([210.76.114.181]:42727 "EHLO ccoss.com.cn")
	by vger.kernel.org with ESMTP id S1751127AbWG0AsE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 20:48:04 -0400
Message-ID: <44C80D3E.5090706@ccoss.com.cn>
Date: Thu, 27 Jul 2006 08:47:58 +0800
From: liyu <liyu@ccoss.com.cn>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Josef Sipek <jsipek@fsl.cs.sunysb.edu>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] usbhid: Driver for microsoft natural ergonomic keyboard
 4000
References: <44C74708.6090907@ccoss.com.cn> <20060726161232.GC28284@filer.fsl.cs.sunysb.edu>
In-Reply-To: <20060726161232.GC28284@filer.fsl.cs.sunysb.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Josef Sipek wrote:
> +#define map_key(c) \
> +       do { \
> +               usage->code = c; \
> +               usage->type = EV_KEY; \
> +               set_bit(c,input->keybit); \
> +       } while (0)
>
> I'm not quite sure where usage is coming from. Some magical global variable?
> Eeek.
>
> Josef "Jeff" Sipek.
>
>   
These macroes like map_key() only use in nek4k_setup_usage() and
ne4k_clear_usage(), so the
variable "usage" is coming from their parameter.

PS: these macroes are modifed from hid-input.c

