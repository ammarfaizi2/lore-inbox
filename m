Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261923AbVEKIZm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261923AbVEKIZm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 May 2005 04:25:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261924AbVEKIZm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 May 2005 04:25:42 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:17834 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261923AbVEKIZi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 May 2005 04:25:38 -0400
Subject: Re: dosemu crashes under 2.6.12-rc4
From: Arjan van de Ven <arjan@infradead.org>
To: gaa <gaa@mail.nnov.ru>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050511060223.7B62F146C83@just.ip-center.ru>
References: <20050511060223.7B62F146C83@just.ip-center.ru>
Content-Type: text/plain
Date: Wed, 11 May 2005 10:25:29 +0200
Message-Id: <1115799930.6029.10.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
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

On Wed, 2005-05-11 at 10:03 +0400, gaa wrote:
> "dosemu" does not work under kernel 2.6.12-rc4(but works under 2.6.11.7).
> Next lines are stdout of crashed dosemu process:

this is a bug in dosemu with a *very* bad threading library
implementation (fixed in more recent dosemu). THat threading lib makes
assumptions that even with newer glibc may break, or with 4G/4G patch or
with 2G/2G or with.. well just about anything.


