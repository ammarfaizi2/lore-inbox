Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262947AbVF3L5Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262947AbVF3L5Y (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Jun 2005 07:57:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262953AbVF3L5Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Jun 2005 07:57:24 -0400
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:17420 "EHLO
	pollux.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S262947AbVF3L5S
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Jun 2005 07:57:18 -0400
Date: Thu, 30 Jun 2005 12:57:20 +0100 (BST)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: Denis Vlasenko <vda@ilport.com.ua>
Cc: Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@osdl.org>,
       Russell King <rmk+lkml@arm.linux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] deinline sleep/delay functions
In-Reply-To: <200506301444.51463.vda@ilport.com.ua>
Message-ID: <Pine.LNX.4.61L.0506301252170.28331@blysk.ds.pg.gda.pl>
References: <200506300852.25943.vda@ilport.com.ua> <200506301410.43524.vda@ilport.com.ua>
 <1120130573.3181.42.camel@laptopd505.fenrus.org> <200506301444.51463.vda@ilport.com.ua>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Jun 2005, Denis Vlasenko wrote:

> I'm ok with making it fail, but _predictably_. With printk(),
> trace, whatever.

 BUG_ON() is probably a good candidate, especially as the implementation 
is expected to be compact and can even be removed for those saving every 
byte by undefining CONFIG_BUG.

  Maciej
