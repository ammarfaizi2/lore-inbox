Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261157AbUL1RMO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261157AbUL1RMO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Dec 2004 12:12:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261188AbUL1RMO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Dec 2004 12:12:14 -0500
Received: from canuck.infradead.org ([205.233.218.70]:63755 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S261157AbUL1RML (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Dec 2004 12:12:11 -0500
Subject: Re: PATCH: 2.6.10 - Misrouted IRQ recovery for review
From: Arjan van de Ven <arjan@infradead.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: mingo@redhat.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1104249508.22366.101.camel@localhost.localdomain>
References: <1104249508.22366.101.camel@localhost.localdomain>
Content-Type: text/plain
Date: Tue, 28 Dec 2004 18:11:58 +0100
Message-Id: <1104253919.4173.11.camel@laptopd505.fenrus.org>
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

On Tue, 2004-12-28 at 15:58 +0000, Alan Cox wrote:
> Ported to the new kernel/irq code.


one question; I see you start passing a struct pt_regs around all over
the place; does *anything* actually use that animal, or should we
consider just passing a NULL .....
(and eventually in 2.7 remove the parameter entirely from irq handlers?)

