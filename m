Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262046AbVAKTU2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262046AbVAKTU2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 14:20:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262155AbVAKTUU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 14:20:20 -0500
Received: from canuck.infradead.org ([205.233.218.70]:59398 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S262161AbVAKTT5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 14:19:57 -0500
Subject: Re: address space reservation functionality?
From: Arjan van de Ven <arjan@infradead.org>
To: "Robert W. Fuller" <orangemagicbus@sbcglobal.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <41E4201B.60606@sbcglobal.net>
References: <41E2EB09.5000603@sbcglobal.net>
	 <1105429362.3917.2.camel@laptopd505.fenrus.org>
	 <41E4201B.60606@sbcglobal.net>
Content-Type: text/plain
Date: Tue, 11 Jan 2005 20:19:46 +0100
Message-Id: <1105471186.3917.46.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 4.1 (++++)
X-Spam-Report: SpamAssassin version 2.63 on canuck.infradead.org summary:
	Content analysis details:   (4.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.3 RCVD_NUMERIC_HELO      Received: contains a numeric HELO
	1.1 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
	2.5 RCVD_IN_DYNABLOCK      RBL: Sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	0.1 RCVD_IN_SORBS          RBL: SORBS: sender is listed in SORBS
	[80.57.133.107 listed in dnsbl.sorbs.net]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > 
> 
> Sorry about the top posting.  This is a resend without it.
> 
> This is not quite the same thing.  This still does a check for whether 
> or not there is enough memory 

no it doesn't


> and includes this in the virtual size of 
> the process.  

because the virtual size is taken.... by the reservation

> I simply want to reserve a part of the address space so 
> I'm guaranteed I can map something else over a contiguous portion of the 
> address space.  I don't want it to check for available memory or 
> increase the virtual size of the process because I will be using this 
> region sparsely.  That is why Solaris and Windows have separate 
> interfaces for this.

well you can mmap /dev/zero.. but that's about the same as malloc.


