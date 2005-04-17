Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261291AbVDQJOo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261291AbVDQJOo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Apr 2005 05:14:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261288AbVDQJOo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Apr 2005 05:14:44 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:24510 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261295AbVDQJID (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Apr 2005 05:08:03 -0400
Subject: Re: More performance for the TCP stack by using additional
	hardware chip on NIC
From: Arjan van de Ven <arjan@infradead.org>
To: Andreas Hartmann <andihartmann@01019freenet.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <d3t63d$3qe$1@pD9F86D3F.dip0.t-ipconnect.de>
References: <d3t63d$3qe$1@pD9F86D3F.dip0.t-ipconnect.de>
Content-Type: text/plain
Date: Sun, 17 Apr 2005 11:07:59 +0200
Message-Id: <1113728880.17394.16.camel@laptopd505.fenrus.org>
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

On Sun, 2005-04-17 at 10:17 +0200, Andreas Hartmann wrote:
> Hello!
> 
> Alacritech developed a new chip for NIC's
> (http://www.alacritech.com/html/tech_review.html), which makes it possible
> to take away the TCP stack from the host CPU. Therefore, the host CPU has
> more performance for the applications according Alacritech.

there are very many good reasons why this for linux is not the right
solution, including the fact that the linux tcp/ip stack already is
quite fast so the "gains" achieved aren't that stellar as the gains you
get when comparing to windows.

Also these types of solution always add quite a bit of overhead to
connection setup/teardown making it actually a *loss* for the "many
short connections" types of workloads. Now guess which things certain
benchmarks use, and guess what real world servers do :)



