Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750965AbVJSN4W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750965AbVJSN4W (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Oct 2005 09:56:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750970AbVJSN4W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Oct 2005 09:56:22 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:62654 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750957AbVJSN4V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Oct 2005 09:56:21 -0400
Subject: Re: [PATCH 1/1] indirect function calls elimination in IO scheduler
From: Arjan van de Ven <arjan@infradead.org>
To: "Ananiev, Leonid I" <leonid.i.ananiev@intel.com>
Cc: linux-kernel@vger.kernel.org, rdunlap@xenotime.net
In-Reply-To: <6694B22B6436BC43B429958787E4549892AE55@mssmsx402nb>
References: <6694B22B6436BC43B429958787E4549892AE55@mssmsx402nb>
Content-Type: text/plain
Date: Wed, 19 Oct 2005 15:56:11 +0200
Message-Id: <1129730171.2822.36.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 2.9 (++)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (2.9 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	2.8 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-10-19 at 17:08 +0400, Ananiev, Leonid I wrote:
> >From Leonid Ananiev
> 
>       Fully modular io schedulers and enables online switching between
> them was introduced in Linux 2.6.10 but as a result percentage of CPU
> using by kernel was increased and performance degradation is marked on
> Itanium. A cause of degradation is in more steps for indirect IO
> scheduler type specific function calls.
>       The patch eliminates 45 indirect function calls in 16 elevator
> functions. 

does it really reduce those function calls? I thought it only reduced a
few pointers to be followed, but not the actual indirect function calls!



