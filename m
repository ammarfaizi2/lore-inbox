Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261624AbUL3MSS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261624AbUL3MSS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Dec 2004 07:18:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261625AbUL3MSS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Dec 2004 07:18:18 -0500
Received: from canuck.infradead.org ([205.233.218.70]:4108 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S261624AbUL3MSP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Dec 2004 07:18:15 -0500
Subject: Re: Bug_reply : Out of range ptr error in module indicates bug in
	slab.c
From: Arjan van de Ven <arjan@infradead.org>
To: selvakumar nagendran <kernelselva@yahoo.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20041230121310.41867.qmail@web60605.mail.yahoo.com>
References: <20041230121310.41867.qmail@web60605.mail.yahoo.com>
Content-Type: text/plain
Date: Thu, 30 Dec 2004 13:18:10 +0100
Message-Id: <1104409090.4170.12.camel@laptopd505.fenrus.org>
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

On Thu, 2004-12-30 at 04:13 -0800, selvakumar nagendran wrote:
> 
>      Thanks for ur help. The user will be changing
> this using system calls like dup,dup2 etc. If I keep
> track of all these modifications by intercepting all
> those syscalls and use inode number for identifying
> the structure uniquely, will it break?

it sure is not a reliable method. The user can change the fd's YOU log.
So your logging is inaccurate. That may or may not be a problem, it
depends on what the application of this is.


