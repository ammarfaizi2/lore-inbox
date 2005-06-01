Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261343AbVFAMGm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261343AbVFAMGm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 08:06:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261354AbVFAMGm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 08:06:42 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:36825 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261343AbVFAMGl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 08:06:41 -0400
Subject: Re: [PATCH] Sample fix for hyperthread exploit
From: Arjan van de Ven <arjan@infradead.org>
To: Con Kolivas <kernel@kolivas.org>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>, ck list <ck@vds.kolivas.org>
In-Reply-To: <200506012158.39805.kernel@kolivas.org>
References: <200506012158.39805.kernel@kolivas.org>
Content-Type: text/plain
Date: Wed, 01 Jun 2005 14:06:36 +0200
Message-Id: <1117627597.6271.29.camel@laptopd505.fenrus.org>
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


> Comments?

I don't think it's really worth it, but if you go this way I'd rather do
this via a prctl() so that apps can tell the kernel "I'd like to run
exclusive on a core". That'd be much better than blindly isolating all
applications.


