Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262700AbVBYOgP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262700AbVBYOgP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Feb 2005 09:36:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262708AbVBYOgP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Feb 2005 09:36:15 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:50610 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262700AbVBYOgM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Feb 2005 09:36:12 -0500
Subject: Re: [PATCH] I2C patch 5 - Add a non-blocking interface to the I2C
	core (again)
From: Arjan van de Ven <arjan@infradead.org>
To: Corey Minyard <minyard@acm.org>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <421F35AB.2040305@acm.org>
References: <421F35AB.2040305@acm.org>
Content-Type: text/plain
Date: Fri, 25 Feb 2005 15:36:07 +0100
Message-Id: <1109342168.6290.59.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 4.1 (++++)
X-Spam-Report: SpamAssassin version 2.63 on pentafluge.infradead.org summary:
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
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> +/* Another note: This interface is extremely sensitive to timing and
> +   failure handling.  If you don't wait at least one jiffie after
> +   starting the transaction before checking things, you will screw it
> +   up.  If you don't wait a jiffie after the final check, you will
> +   screw it up.  If you screw it up by these manners or by abandoning
> +   an operation in progress, the I2C bus is likely stuck and won't
> +   work any more.  Gotta love this hardware. */

this sounds scary. Your "jiffie" in the comment, for which value of HZ
is that taken? Would you consider changing this to absolute time
instead?


