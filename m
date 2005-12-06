Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964948AbVLFKop@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964948AbVLFKop (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 05:44:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964949AbVLFKop
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 05:44:45 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:15050 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S964948AbVLFKop (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 05:44:45 -0500
Subject: Re: [PATCH] Win32 equivalent to GetTickCount systemcall (i386)
From: Arjan van de Ven <arjan@infradead.org>
To: David Engraf <engraf.david@netcom-sicherheitstechnik.de>
Cc: linux-kernel@vger.kernel.org, "'Andrew Morton'" <akpm@osdl.org>
In-Reply-To: <009201c5fa50$f3f58a10$0a016696@EW10>
References: <009201c5fa50$f3f58a10$0a016696@EW10>
Content-Type: text/plain
Date: Tue, 06 Dec 2005 11:44:39 +0100
Message-Id: <1133865880.2858.42.camel@laptopd505.fenrus.org>
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

On Tue, 2005-12-06 at 11:36 +0100, David Engraf wrote:
> This patch adds a new systemcall on i386 architectures returning the jiffies
> value to the application. 
> As a kernel developer you can use jiffies but from the user space there is
> no equivalent function which counts every millisecond like the Win32
> GetTickCount.

a few comments

1) jiffies are 64 bit not 32
2) jiffies are not a constant time, eg HZ is a config option,
   exposing that internal counter to userspace sounds wrong, after
   all what would it be used for
3) wouldn't it be better to expose a wallclock time thing which
   has a constant unit of time between all kernels?

(and.. wait.. isn't that called gettimeofday() )


