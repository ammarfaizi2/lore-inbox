Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261405AbUK1HOD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261405AbUK1HOD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Nov 2004 02:14:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261406AbUK1HOD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Nov 2004 02:14:03 -0500
Received: from canuck.infradead.org ([205.233.218.70]:18185 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S261405AbUK1HN7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Nov 2004 02:13:59 -0500
Subject: Re: [RFC] Splitting kernel headers and deprecating __KERNEL__
From: Arjan van de Ven <arjan@infradead.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: David Woodhouse <dwmw2@infradead.org>, "Randy.Dunlap" <rddunlap@osdl.org>,
       Matthew Wilcox <matthew@wil.cx>, Tonnerre <tonnerre@thundrix.ch>,
       David Howells <dhowells@redhat.com>, torvalds@osdl.org,
       hch@infradead.org, aoliva@redhat.com, linux-kernel@vger.kernel.org,
       libc-hacker@sources.redhat.com
In-Reply-To: <200411272353.54056.arnd@arndb.de>
References: <19865.1101395592@redhat.com> <41A8AF8F.8060005@osdl.org>
	 <1101575782.21273.5347.camel@baythorne.infradead.org>
	 <200411272353.54056.arnd@arndb.de>
Content-Type: text/plain
Message-Id: <1101626019.2638.2.camel@laptop.fenrus.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2.dwmw2.1) 
Date: Sun, 28 Nov 2004 08:13:39 +0100
Content-Transfer-Encoding: 7bit
X-Spam-Score: 3.7 (+++)
X-Spam-Report: SpamAssassin version 2.63 on canuck.infradead.org summary:
	Content analysis details:   (3.7 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
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


> The problem with these (atomic.h

that is a very non portable header and there are several good
alternatives (see the apr library for example). In fact. atomic.h is
*dangerous* in userspace, it is only atomic if CONFIG_SMP is set, so if
you compile your app on a machine without that set and then run it on an
smp machine, you are not atomic.

>
> , bitops.h

again not portable 

>
> , byteorder.h, 

there are perfectly good alternatives in glibc

>
> div64.h,

huh? what is wrong with "/" in C

> list.h

this one I can see

>
> , spinlock.h

EHHHH????? Spinlocks in userland? You got to be kidding.


> , unaligned.h 

weird

> and xor.h) 

xor.h is very raid specific (and GPL with lots of code, so a license
trap)


