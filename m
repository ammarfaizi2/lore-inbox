Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261173AbVBFP7k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261173AbVBFP7k (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Feb 2005 10:59:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261174AbVBFP7k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Feb 2005 10:59:40 -0500
Received: from main.gmane.org ([80.91.229.2]:51653 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S261173AbVBFP7i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Feb 2005 10:59:38 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Giuseppe Bilotta <bilotta78@hotpop.com>
Subject: Re: [PATCH][i386] HPET setup, duplicate HPET_T0_CMP needed for some platforms
Date: Sun, 6 Feb 2005 16:58:55 +0100
Message-ID: <MPG.1c7025eb95e6f4e198970f@news.gmane.org>
References: <88056F38E9E48644A0F562A38C64FB6003EA715C@scsmsx403.amr.corp.intel.com> <20050203213026.GF3181@wotan.suse.de> <20050204200238.GA5510@ucw.cz> <20050204154159.A4402@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: ppp-219-149.29-151.libero.it
User-Agent: MicroPlanet-Gravity/2.70.2067
X-Gmane-MailScanner: Found to be clean
X-Gmane-MailScanner: Found to be clean
X-MailScanner-From: glk-linux-kernel@m.gmane.org
X-MailScanner-To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Venkatesh Pallipadi wrote:
> +	/* 
> +	 * Some systems seems to need two writes to HPET_T0_CMP, 
> +	 * to get interrupts working
> +	 */
> +	hpet_writel(tick, HPET_T0_CMP);
>  	hpet_writel(tick, HPET_T0_CMP);

Is it known which platforms require two, and which ones require 
one write? Is it cost-effective to #if CONFIG_ the second 
write?

-- 
Giuseppe "Oblomov" Bilotta

Can't you see
It all makes perfect sense
Expressed in dollar and cents
Pounds shillings and pence
                  (Roger Waters)

