Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261680AbVA3Lm7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261680AbVA3Lm7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jan 2005 06:42:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261683AbVA3Lm6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jan 2005 06:42:58 -0500
Received: from canuck.infradead.org ([205.233.218.70]:15879 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S261680AbVA3Lm5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jan 2005 06:42:57 -0500
Subject: Re: MOD_USE_INC_COUNT and MOD_USE_DEC_COUNT
From: Arjan van de Ven <arjan@infradead.org>
To: Lethalman <lethalman88@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <c79c69b305013003355b5c86bc@mail.gmail.com>
References: <c79c69b305013003355b5c86bc@mail.gmail.com>
Content-Type: text/plain
Date: Sun, 30 Jan 2005 12:42:50 +0100
Message-Id: <1107085371.4178.56.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 4.1 (++++)
X-Spam-Report: SpamAssassin version 2.63 on canuck.infradead.org summary:
	Content analysis details:   (4.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.3 RCVD_NUMERIC_HELO      Received: contains a numeric HELO
	1.1 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
	2.5 RCVD_IN_DYNABLOCK      RBL: Sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	0.1 RCVD_IN_SORBS          RBL: SORBS: sender is listed in SORBS
	[80.57.133.107 listed in dnsbl.sorbs.net]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-01-30 at 12:35 +0100, Lethalman wrote:
> What's the corrispective name of these macros in the 2.6.x kernel?
> 

you shouldn't need them if your code sets the .owner field properly of
the respective datastructures. Eg they are replaced by a proper (ok some
people consider that debatable) refcounting scheme, not just renamed.


