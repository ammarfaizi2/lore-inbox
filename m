Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750799AbWEDWKT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750799AbWEDWKT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 May 2006 18:10:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750811AbWEDWKS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 May 2006 18:10:18 -0400
Received: from mail-in-07.arcor-online.net ([151.189.21.47]:9113 "EHLO
	mail-in-07.arcor-online.net") by vger.kernel.org with ESMTP
	id S1750799AbWEDWKR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 May 2006 18:10:17 -0400
In-Reply-To: <Pine.LNX.4.44.0605041622180.3700-100000@gate.crashing.org>
References: <Pine.LNX.4.44.0605041622180.3700-100000@gate.crashing.org>
Mime-Version: 1.0 (Apple Message framework v749.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <6B4D81B3-ECB5-4492-B3EE-16EAAEBF1405@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@ozlabs.org,
       linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: Please pull from 'for_paulus' branch of powerpc
Date: Fri, 5 May 2006 00:09:59 +0200
To: Kumar Gala <galak@kernel.crashing.org>
X-Mailer: Apple Mail (2.749.3)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kumar,

> +static int ppc_panic_event(struct notifier_block *this,
> +                             unsigned long event, void *ptr)
> +{
> +	ppc_md.panic((char *)ptr);  /* May not return */
> +	return NOTIFY_DONE;
> +}

Lose the redundant pointer cast while you're there please?

>  void __init setup_arch(char **cmdline_p)
>  {
>  	extern void do_init_bootmem(void);
> +	extern void setup_panic(void);

Can those two go into a header file please?


Segher

