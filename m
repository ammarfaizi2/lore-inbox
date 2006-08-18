Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932187AbWHRT3x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932187AbWHRT3x (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 15:29:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932243AbWHRT3x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 15:29:53 -0400
Received: from moutng.kundenserver.de ([212.227.126.177]:13002 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S932187AbWHRT3x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 15:29:53 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: "Ed L. Cashin" <ecashin@coraid.com>
Subject: Re: [PATCH 2.6.18-rc4] aoe [06/13]: clean up printks via macros
Date: Fri, 18 Aug 2006 21:29:45 +0200
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org, Greg K-H <greg@kroah.com>
References: <E1GE8K3-0008Jn-00@kokone.coraid.com> <6dc082092248e90db76de47c0bd5bd6c@coraid.com>
In-Reply-To: <6dc082092248e90db76de47c0bd5bd6c@coraid.com>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200608182129.46571.arnd@arndb.de>
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 18 August 2006 19:39, Ed L. Cashin wrote:
> 
> +#define xprintk(L, fmt, arg...) printk(L "aoe: " "%s: " fmt, __func__, ## arg) 
> +#define iprintk(fmt, arg...) xprintk(KERN_INFO, fmt, ## arg)
> +#define eprintk(fmt, arg...) xprintk(KERN_ERR, fmt, ## arg)
> +#define dprintk(fmt, arg...) xprintk(KERN_DEBUG, fmt, ## arg)
> +

Can't you use the dev_{info,error,dbg}() functions instead?

	Arnd <><
