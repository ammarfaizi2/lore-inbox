Return-Path: <linux-kernel-owner+w=401wt.eu-S1752879AbWLSPmN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752879AbWLSPmN (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 10:42:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752878AbWLSPmN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 10:42:13 -0500
Received: from tmailer.gwdg.de ([134.76.10.23]:40410 "EHLO tmailer.gwdg.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752883AbWLSPmM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 10:42:12 -0500
Date: Tue, 19 Dec 2006 16:41:09 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: "Robert P. J. Day" <rpjday@mindspring.com>
cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Get rid of most of the remaining k*alloc() casts.
In-Reply-To: <Pine.LNX.4.64.0612190627020.22485@localhost.localdomain>
Message-ID: <Pine.LNX.4.61.0612191639540.10396@yvahk01.tjqt.qr>
References: <Pine.LNX.4.64.0612190627020.22485@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>  Get rid of the remaining obvious pointer casts of all k[cmz]alloc
>calls, and do a little whitespace cleanup on the result, based on the
>CodingStyle file.

>-		struct intmem_allocation* alloc =
>-		  (struct intmem_allocation*)kmalloc(sizeof *alloc, GFP_KERNEL);
>+		struct intmem_allocation* alloc =
>+			kmalloc(sizeof(*alloc), GFP_KERNEL);

At the same time, you could make * alloc -> *alloc when it falls on the same
line as the kmczalloc cleanup. :)


	-`J'
-- 
