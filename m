Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262082AbVCAWOZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262082AbVCAWOZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Mar 2005 17:14:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262088AbVCAWOZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Mar 2005 17:14:25 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:13973 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262082AbVCAWOW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Mar 2005 17:14:22 -0500
Subject: Re: [PATCH] New operation for kref to help avoid locks
From: Arjan van de Ven <arjan@infradead.org>
To: Corey Minyard <minyard@acm.org>
Cc: Greg KH <greg@kroah.com>, Sergey Vlasov <vsu@altlinux.ru>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <4224E499.5060800@acm.org>
References: <42209BFD.8020908@acm.org>
	 <20050226232026.5c12d5b0.vsu@altlinux.ru> <4220F6C8.4020002@acm.org>
	 <20050301201528.GA23484@kroah.com>
	 <1109710964.6293.166.camel@laptopd505.fenrus.org>
	 <4224E499.5060800@acm.org>
Content-Type: text/plain
Date: Tue, 01 Mar 2005 23:14:15 +0100
Message-Id: <1109715256.6293.180.camel@laptopd505.fenrus.org>
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


> Just doing an atomic operation is not faster than doing a lock, an 
> atomic operation, then an unlock?  Am I missing something?

if the lock and the atomic are on the same cacheline they're the same
cost on most modern cpus...



