Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261384AbUKFMyb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261384AbUKFMyb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Nov 2004 07:54:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261385AbUKFMya
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Nov 2004 07:54:30 -0500
Received: from canuck.infradead.org ([205.233.218.70]:25103 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S261384AbUKFMy0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Nov 2004 07:54:26 -0500
Subject: Re: KSTK_EIP and KSTK_ESP
From: Arjan van de Ven <arjan@infradead.org>
To: "Hanson, Jonathan M" <jonathan.m.hanson@intel.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <C863B68032DED14E8EBA9F71EB8FE4C20542CA19@azsmsx406>
References: <C863B68032DED14E8EBA9F71EB8FE4C20542CA19@azsmsx406>
Content-Type: text/plain
Message-Id: <1099745657.2814.6.camel@laptop.fenrus.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2.dwmw2.1) 
Date: Sat, 06 Nov 2004 13:54:17 +0100
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

On Fri, 2004-11-05 at 16:13 -0700, Hanson, Jonathan M wrote:
> 	Can someone explain the structure of the memory that these two
> macros are accessing? Specifically, where do the 1019 and 1022 offsets

remember the indexes are in multiples of 32 bit, eg the bottom of the
stack, since it's close to the end of the pagesize...


