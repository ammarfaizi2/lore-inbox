Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261737AbVDKJRR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261737AbVDKJRR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 05:17:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261745AbVDKJRQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 05:17:16 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:22676 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261737AbVDKJRO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 05:17:14 -0400
Subject: Re: smbfs: lseek returns EINVAL when using large files.
From: Arjan van de Ven <arjan@infradead.org>
To: Mathieu Fluhr <mfluhr@nero.com>
Cc: Linux Kernel ML <linux-kernel@vger.kernel.org>
In-Reply-To: <1113210463.1744.11.camel@c-l-175>
References: <1113210463.1744.11.camel@c-l-175>
Content-Type: text/plain
Date: Mon, 11 Apr 2005 11:17:10 +0200
Message-Id: <1113211031.6275.19.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-2) 
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

On Mon, 2005-04-11 at 11:07 +0200, Mathieu Fluhr wrote:
> Hello
> 
> It seems that the smbfs driver does not handle correctly large files
> (>2GB). The thing is that statting them is correct (for example, the
> st_size field is correctly set), but as soon as you try to make a lseek
> with an offset larget than INT_MAX, you get a EINVAL error.


have you tried the cifs client, which is new in 2.6 and is the more
actively maintained way to access windows shares and samba ?


