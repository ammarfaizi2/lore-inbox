Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261674AbVEUGY5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261674AbVEUGY5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 May 2005 02:24:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261680AbVEUGY5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 May 2005 02:24:57 -0400
Received: from mail.kroah.org ([69.55.234.183]:39307 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261674AbVEUGYw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 May 2005 02:24:52 -0400
Date: Fri, 20 May 2005 23:31:51 -0700
From: Greg KH <greg@kroah.com>
To: Reiner Sailer <sailer@watson.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-security-module@mail.wirex.com,
       kylene@us.ibm.com, emilyr@us.ibm.com, toml@us.ibm.com
Subject: Re: [PATCH 4 of 4] ima: module measure extension
Message-ID: <20050521063150.GE24597@kroah.com>
References: <1116597678.8426.3.camel@secureip.watson.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1116597678.8426.3.camel@secureip.watson.ibm.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 20, 2005 at 10:01:18AM -0400, Reiner Sailer wrote:
> @@ -1441,6 +1442,8 @@ static struct module *load_module(void _
>  	if (len < hdr->e_shoff + hdr->e_shnum * sizeof(Elf_Shdr))
>  		goto truncated;
>  
> +	ima_measure_module((void *)hdr, len, (void *)uargs);
> +

I see you did not run this code through sparse...

Gotta love security code that makes the overall system less secure...

greg k-h
