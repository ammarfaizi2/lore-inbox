Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757651AbWK0Jkr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757651AbWK0Jkr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 04:40:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757652AbWK0Jkr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 04:40:47 -0500
Received: from rutherford.zen.co.uk ([212.23.3.142]:57793 "EHLO
	rutherford.zen.co.uk") by vger.kernel.org with ESMTP
	id S1757636AbWK0Jkq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 04:40:46 -0500
From: David Johnson <dj@david-web.co.uk>
To: Alexey Dobriyan <adobriyan@gmail.com>
Subject: Re: Changing sysctl values within the kernel?
Date: Mon, 27 Nov 2006 09:40:40 +0000
User-Agent: KMail/1.9.5
References: <200611251911.48961.dj@david-web.co.uk> <20061126203816.GA5032@martell.zuzino.mipt.ru>
In-Reply-To: <20061126203816.GA5032@martell.zuzino.mipt.ru>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611270940.40792.dj@david-web.co.uk>
X-Originating-Rutherford-IP: [82.69.29.67]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 26 November 2006 20:38, you wrote:
> On Sat, Nov 25, 2006 at 07:11:48PM +0000, David Johnson wrote:
> >
> > Is there an accepted way of setting sysctl values within the kernel (I
> > can't seem to find any other module doing this),
>
> Yes. Next in-kernel module changing sysctls will do it via
>
> 	stop_a_enabled = 1;
> 	console_loglevel = 8;
>
> (be sure, variables in question are EXPORT_SYMBOL'ed)
>

Bah, I never thought it would be that simple!

>
> > Would it perhaps be better to instead create a sysfs node and let a
> > userspace daemon worry about setting the sysctl values?
>
> Now _this_ is silly. sysctls already live in /proc/sys/, so you can open(2)
> /proc/sys/kernel/printk and write(2) to it.

OK, I'll give that a miss then ;-)

Thanks for your help!

David.
