Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030507AbVKRIcE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030507AbVKRIcE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 03:32:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030511AbVKRIcE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 03:32:04 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:11991 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1030507AbVKRIcD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 03:32:03 -0500
Subject: Re: [2.6 patch] fs/reiser4/: possible cleanups
From: Arjan van de Ven <arjan@infradead.org>
To: Hans Reiser <reiser@namesys.com>
Cc: Adrian Bunk <bunk@stusta.de>, reiserfs-list@namesys.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <437D8FB3.2000108@namesys.com>
References: <20051118033310.GQ11494@stusta.de>
	 <437D8FB3.2000108@namesys.com>
Content-Type: text/plain
Date: Fri, 18 Nov 2005 09:31:57 +0100
Message-Id: <1132302717.2830.41.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 1.8 (+)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (1.8 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[213.93.14.173 listed in dnsbl.sorbs.net]
	1.7 RCVD_IN_NJABL_DUL      RBL: NJABL: dialup sender did non-local SMTP
	[213.93.14.173 listed in combined.njabl.org]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-11-18 at 00:24 -0800, Hans Reiser wrote:
> Seems ok to me.  Is it valuable reasons I don't know about to keep
> reiser4_* functions from crowding the namespaces of the rest of the
> kernel?  Is linking faster or?

gcc can and does optimize static functions more. A function being static
(and not having it's address taken) means that gcc is aware of all
callers of this one function (unlike non-static obviously where places
outside the current .c may call it). That knowledge can and is used for
optimization. (and increasingly so in newer gcc's)

