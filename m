Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261224AbULRTzC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261224AbULRTzC (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Dec 2004 14:55:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261227AbULRTzC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Dec 2004 14:55:02 -0500
Received: from canuck.infradead.org ([205.233.218.70]:13586 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S261224AbULRTyv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Dec 2004 14:54:51 -0500
Subject: Re: What does atomic_read actually do?
From: Arjan van de Ven <arjan@infradead.org>
To: Joseph Seigh <jseigh_02@xemaps.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <opsi7xcuizs29e3l@grunion>
References: <opsi7o5nqfs29e3l@grunion>
	 <1103394867.4127.18.camel@laptopd505.fenrus.org> <opsi7xcuizs29e3l@grunion>
Content-Type: text/plain
Date: Sat, 18 Dec 2004 20:54:40 +0100
Message-Id: <1103399680.4127.20.camel@laptopd505.fenrus.org>
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

On Sat, 2004-12-18 at 14:20 -0500, Joseph Seigh wrote:
> I mean atomic in the either old or new sense.  I'm wondering what  
> guarantees
> the atomicity.  Not the C standard.  I can see the gcc compiler uses a MOV
> instruction to load the atomic_t from memory which is guaranteed atomic by
> the architecture if aligned properly.  But gcc does that for any old int
> as far as I can see, so why use atomic_read?

it does so on *x86*.
On other architectures, something else might be needed..

also it makes the api more symetric as well.



