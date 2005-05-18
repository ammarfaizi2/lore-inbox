Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262108AbVERNK1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262108AbVERNK1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 09:10:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261762AbVERNK1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 09:10:27 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:55523 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262140AbVERNKT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 09:10:19 -0400
Subject: Re: [PATCH 4/9] UML - Delay loop cleanups
From: Arjan van de Ven <arjan@infradead.org>
To: Jeff Dike <jdike@addtoit.com>
Cc: akpm@osdl.org, torvalds@osdl.org, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <200505180420.j4I4KQ6H017322@ccure.user-mode-linux.org>
References: <200505180420.j4I4KQ6H017322@ccure.user-mode-linux.org>
Content-Type: text/plain
Date: Wed, 18 May 2005 15:10:05 +0200
Message-Id: <1116421805.6572.27.camel@laptopd505.fenrus.org>
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

On Wed, 2005-05-18 at 00:20 -0400, Jeff Dike wrote:
> This patch cleans up the delay implementations a bit, makes the loops
> unoptimizable, and exports __udelay and __const_udelay.


you actually want cpu_relax(); for HT niceness...


