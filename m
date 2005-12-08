Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932174AbVLHPh4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932174AbVLHPh4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Dec 2005 10:37:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932182AbVLHPh4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Dec 2005 10:37:56 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:59875 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932174AbVLHPhz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Dec 2005 10:37:55 -0500
Subject: Re: How to enable/disable security features on mmap() ?
From: Arjan van de Ven <arjan@infradead.org>
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
Cc: Emmanuel Fleury <emmanuel.fleury@labri.fr>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.61.0512081011020.32448@chaos.analogic.com>
References: <43983EBE.2080604@labri.fr>
	 <1134051272.2867.63.camel@laptopd505.fenrus.org>
	 <43984154.5050502@labri.fr>  <43984595.1090406@labri.fr>
	 <1134053349.2867.65.camel@laptopd505.fenrus.org> <4398493E.50508@labri.fr>
	 <Pine.LNX.4.61.0512081011020.32448@chaos.analogic.com>
Content-Type: text/plain
Date: Thu, 08 Dec 2005 16:37:51 +0100
Message-Id: <1134056272.2867.73.camel@laptopd505.fenrus.org>
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


> Isn't this too much?  I thought the random-stack patch was
> only supposed to vary it a page or 64k at most. This looks
> like some broken logic because it varies almost 8 megabytes!

that is correct; the 64k was only there for one patch proposal; linus'
tree had 8 Mb randomisation from the start

> No wonder some of my user's database programs sometimes seg-fault
> and other times work perfectly fine. I think this is incorrect
> and shows a serious bug (misbehavior).

eh how? This 8Mb isn't eaten from the stack rlimit; the entire stack is
moved, and the rlimit applies to the size not the position.


