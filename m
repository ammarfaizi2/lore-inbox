Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964999AbVJUPsn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964999AbVJUPsn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Oct 2005 11:48:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965003AbVJUPsn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Oct 2005 11:48:43 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:27876 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S964996AbVJUPsm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Oct 2005 11:48:42 -0400
Subject: Re: Understanding Linux addr space, malloc, and heap
From: Arjan van de Ven <arjan@infradead.org>
To: "Vincent W. Freeh" <vin@csc.ncsu.edu>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <43590B23.2090101@csc.ncsu.edu>
References: <4358F0E3.6050405@csc.ncsu.edu>
	 <1129903396.2786.19.camel@laptopd505.fenrus.org>
	 <4359051C.2070401@csc.ncsu.edu>
	 <1129908179.2786.23.camel@laptopd505.fenrus.org>
	 <43590B23.2090101@csc.ncsu.edu>
Content-Type: text/plain
Date: Fri, 21 Oct 2005 17:48:38 +0200
Message-Id: <1129909719.2786.27.camel@laptopd505.fenrus.org>
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


> 
> But I can't mprotect the 66th page I malloc.  And mprotect fails SILENTLY!

I'm not convinced it does that.. not until the bugs are out of the
code.... since right now it mprotects the wrong stuff, which sometimes
overlaps with what you malloced, sometimes not.


