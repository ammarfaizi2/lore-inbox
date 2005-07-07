Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261533AbVGGNyA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261533AbVGGNyA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 09:54:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261548AbVGGNx7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 09:53:59 -0400
Received: from [195.23.16.24] ([195.23.16.24]:61114 "EHLO
	bipbip.comserver-pie.com") by vger.kernel.org with ESMTP
	id S261533AbVGGNwj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 09:52:39 -0400
Message-ID: <42CD33A1.7030102@grupopie.com>
Date: Thu, 07 Jul 2005 14:52:33 +0100
From: Paulo Marques <pmarques@grupopie.com>
Organization: Grupo PIE
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: raja <vnagaraju@effigent.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: function Named
References: <42CD25FA.6030100@effigent.net>
In-Reply-To: <42CD25FA.6030100@effigent.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

raja wrote:
> hi,
>    Is there any way to get the function address by only knowing the 
> function Name

See "kallsyms_lookup_name" in include/linux/kallsyms.h (implemented in 
kernel/kallsyms.c).

Beware:

  - CONFIG_KALLSYMS might be undefined. In that case it always returns 0

  - the function returns the address of *any* known symbol, not just 
functions (this can be easily improved to also return the symbol type)

  - the function is extremely inefficient, as it does a linear search 
over all the symbols. kallsyms is optimized to work the other way 
around: get the name from the address.

-- 
Paulo Marques - www.grupopie.com

It is a mistake to think you can solve any major problems
just with potatoes.
Douglas Adams
