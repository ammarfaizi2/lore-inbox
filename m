Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261318AbVBVWmg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261318AbVBVWmg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Feb 2005 17:42:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261314AbVBVWmf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Feb 2005 17:42:35 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:37869 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261309AbVBVWm2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Feb 2005 17:42:28 -0500
Subject: Re: [patch -mm series] ia64 specific /dev/mem handlers
From: Arjan van de Ven <arjan@infradead.org>
To: Jes Sorensen <jes@wildopensource.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <yq04qg4i5wu.fsf@jaguar.mkp.net>
References: <16923.193.128608.607599@jaguar.mkp.net>
	 <1109109833.6024.109.camel@laptopd505.fenrus.org>
	 <yq04qg4i5wu.fsf@jaguar.mkp.net>
Content-Type: text/plain
Date: Tue, 22 Feb 2005 23:42:22 +0100
Message-Id: <1109112142.6024.119.camel@laptopd505.fenrus.org>
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

On Tue, 2005-02-22 at 17:30 -0500, Jes Sorensen wrote:
> 
> For userspace it's used by some of the MPI type apps in userland.

you got to be kidding. Why are these MPI apps accessing memory that the
kernel has mapped cached (eg ram) via /dev/mem?


(eg my proposal is to make /dev/mem to be just device memory not kernel
accessable ram; wouldn't that solve the entire issue cleanly ?)

