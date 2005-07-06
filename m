Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262575AbVGFVGS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262575AbVGFVGS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 17:06:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262568AbVGFVCC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 17:02:02 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:19885 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262569AbVGFVAP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 17:00:15 -0400
Subject: Re: Slowdown with randomize_va_space in 2.6.12.2
From: Arjan van de Ven <arjan@infradead.org>
To: "David S. Miller" <davem@davemloft.net>
Cc: pmarques@grupopie.com, linux-kernel@vger.kernel.org
In-Reply-To: <20050706.125719.08321870.davem@davemloft.net>
References: <42CBE97C.2060208@grupopie.com>
	 <20050706.125719.08321870.davem@davemloft.net>
Content-Type: text/plain
Date: Wed, 06 Jul 2005 23:00:06 +0200
Message-Id: <1120683606.4537.39.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 3.7 (+++)
X-Spam-Report: SpamAssassin version 2.63 on pentafluge.infradead.org summary:
	Content analysis details:   (3.7 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	1.1 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
	2.5 RCVD_IN_DYNABLOCK      RBL: Sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	0.1 RCVD_IN_SORBS          RBL: SORBS: sender is listed in SORBS
	[80.57.133.107 listed in dnsbl.sorbs.net]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-07-06 at 12:57 -0700, David S. Miller wrote:
> From: Paulo Marques <pmarques@grupopie.com>
> Date: Wed, 06 Jul 2005 15:23:56 +0100
> 
> > What is weird is that most of the extra time is being accounted as 
> > user-space time, but the user-space application is exactly the same in 
> > both runs, only the "randomize_va_space" parameter changed.
> 
> It might be attributable to more cpu cache misses in userspace since
> the virtual addresses of everything are changing each and every
> invocation.

also x86 technically is pipt so virtual addresses shouldn't matter...



