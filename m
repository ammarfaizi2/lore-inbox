Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932167AbVJCHNT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932167AbVJCHNT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 03:13:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932168AbVJCHNT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 03:13:19 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:8396 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932167AbVJCHNS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 03:13:18 -0400
Subject: Re: Shared Library Holes in x86_amd64
From: Arjan van de Ven <arjan@infradead.org>
To: Arijit Das <Arijit.Das@synopsys.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <7EC22963812B4F40AE780CF2F140AFE9168364@IN01WEMBX1.internal.synopsys.com>
References: <7EC22963812B4F40AE780CF2F140AFE9168364@IN01WEMBX1.internal.synopsys.com>
Content-Type: text/plain
Date: Mon, 03 Oct 2005 09:13:12 +0200
Message-Id: <1128323592.17024.1.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 2.9 (++)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (2.9 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	2.8 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>  
> Does anybody know the reason behind such holes inside a shared library
> like /lib64/tls/libc.so.6 in RHAS30/x86_amd64 platforms? 

the minimum alignment as specified in the x64 ABI is 1 Megabyte (this
was discussed last week already here after the first time you asked it,
and also is not a kernel thing so your questions are off-topic for this
mailing list). ld.so decides the easiest way to get that alignment is to
PROT_NONE it, also to make sure nothing can go "in the middle" of such a
library.



