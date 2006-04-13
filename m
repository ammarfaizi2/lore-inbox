Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932114AbWDMTKh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932114AbWDMTKh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 15:10:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932361AbWDMTKh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 15:10:37 -0400
Received: from [195.23.16.24] ([195.23.16.24]:39113 "EHLO
	linuxbipbip.grupopie.com") by vger.kernel.org with ESMTP
	id S932114AbWDMTKg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 15:10:36 -0400
Message-ID: <443EA22B.2090105@grupopie.com>
Date: Thu, 13 Apr 2006 20:10:35 +0100
From: Paulo Marques <pmarques@grupopie.com>
Organization: Grupo PIE
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: tyler@agat.net
CC: Greg KH <gregkh@suse.de>, rusty@rustcorp.com.au,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Kmod optimization
References: <20060413180345.GA10910@Starbuck> <20060413182401.GA26885@suse.de> <20060413183617.GB10910@Starbuck>
In-Reply-To: <20060413183617.GB10910@Starbuck>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

tyler@agat.net wrote:
>
> +/* Test if a module is loaded : must hold module_mutex */
> +inline int is_loaded(const char *module_name)
> +{
> +	struct module *mod = find_module(module_name);
> +
> +	if (!mod)
> +		return 1;

FWIW, this logic seems reversed....

-- 
Paulo Marques - www.grupopie.com

Pointy-Haired Boss: I don't see anything that could stand in our way.
            Dilbert: Sanity? Reality? The laws of physics?
