Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263164AbUJ2JCF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263164AbUJ2JCF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 05:02:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263162AbUJ2JCE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 05:02:04 -0400
Received: from canuck.infradead.org ([205.233.218.70]:15876 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S261390AbUJ2JB6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 05:01:58 -0400
Subject: Re: How to safely reduce stack usage in nfs code?
From: Arjan van de Ven <arjan@infradead.org>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <200410290020.01400.vda@port.imtp.ilyichevsk.odessa.ua>
References: <200410290020.01400.vda@port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain
Message-Id: <1099040501.2641.9.camel@laptop.fenrus.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2.dwmw2.1) 
Date: Fri, 29 Oct 2004 11:01:41 +0200
Content-Transfer-Encoding: 7bit
X-Spam-Score: 2.6 (++)
X-Spam-Report: SpamAssassin version 2.63 on canuck.infradead.org summary:
	Content analysis details:   (2.6 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	2.5 RCVD_IN_DYNABLOCK      RBL: Sent directly from dynamic IP address
	[62.195.31.207 listed in dnsbl.sorbs.net]
	0.1 RCVD_IN_SORBS          RBL: SORBS: sender is listed in SORBS
	[62.195.31.207 listed in dnsbl.sorbs.net]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-10-29 at 00:20 +0300, Denis Vlasenko wrote:

> I can convert these into kmalloc'ed variants but hesitate to do so
> because of possible 'need to kmalloc in order to free memory for kmalloc'
> deadlocks.

how about a memory pool?

It's not THE solution but I suspect the depth of callchains of these isn't too deep so it would work

