Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261481AbULTLvu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261481AbULTLvu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Dec 2004 06:51:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261485AbULTLvu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Dec 2004 06:51:50 -0500
Received: from canuck.infradead.org ([205.233.218.70]:60420 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S261481AbULTLvs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Dec 2004 06:51:48 -0500
Subject: Re: What does atomic_read actually do?
From: Arjan van de Ven <arjan@infradead.org>
To: Joseph Seigh <jseigh_02@xemaps.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <opsi94i4z0s29e3l@grunion>
References: <opsi7o5nqfs29e3l@grunion>
	 <1103394867.4127.18.camel@laptopd505.fenrus.org> <opsi7xcuizs29e3l@grunion>
	 <1103399680.4127.20.camel@laptopd505.fenrus.org> <opsi707edhs29e3l@grunion>
	 <1103494866.6052.354.camel@localhost>  <opsi94i4z0s29e3l@grunion>
Content-Type: text/plain
Date: Mon, 20 Dec 2004 12:51:39 +0100
Message-Id: <1103543499.4133.5.camel@laptopd505.fenrus.org>
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


> I'm aware of that.  I'm not asking a question about x86 architecture.  I'm
> asking what guarantees that the compiler will load the int using one MOV
> instruction since there's nothing in the C standard that requires that,  
> even
> for volatile.   I think it's unlikely the compiler would use multiple loads
> a byte at a time but it really requires a compiler person to  
> authoritatively
> make that statement.

well... nothing really guarantees it other than that it's rather really
hard to NOT do it with one mov. And the gcc people care about their
quality of implementation enough that they will never do this...


