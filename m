Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261452AbUK1Mof@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261452AbUK1Mof (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Nov 2004 07:44:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261454AbUK1Mof
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Nov 2004 07:44:35 -0500
Received: from canuck.infradead.org ([205.233.218.70]:10763 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S261452AbUK1Mod (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Nov 2004 07:44:33 -0500
Subject: Re: [RFC] Splitting kernel headers and deprecating __KERNEL__
From: Arjan van de Ven <arjan@infradead.org>
To: Wichert Akkerman <wichert@wiggy.net>
Cc: Arnd Bergmann <arnd@arndb.de>, David Woodhouse <dwmw2@infradead.org>,
       "Randy.Dunlap" <rddunlap@osdl.org>, Matthew Wilcox <matthew@wil.cx>,
       Tonnerre <tonnerre@thundrix.ch>, David Howells <dhowells@redhat.com>,
       torvalds@osdl.org, hch@infradead.org, aoliva@redhat.com,
       linux-kernel@vger.kernel.org, libc-hacker@sources.redhat.com
In-Reply-To: <20041128122855.GD17423@wiggy.net>
References: <19865.1101395592@redhat.com> <200411272353.54056.arnd@arndb.de>
	 <1101626019.2638.2.camel@laptop.fenrus.org>
	 <200411281303.46609.arnd@arndb.de>  <20041128122855.GD17423@wiggy.net>
Content-Type: text/plain
Message-Id: <1101645850.2638.17.camel@laptop.fenrus.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2.dwmw2.1) 
Date: Sun, 28 Nov 2004 13:44:10 +0100
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

On Sun, 2004-11-28 at 13:28 +0100, Wichert Akkerman wrote:
> Previously Arnd Bergmann wrote:
> > Ok, I've looked for places where someone actually tried using
> > the kernel headers by googling for /usr/include/asm/foo.h.
> > The good news is that marking these files broken in 
> > glibc-kernheaders has already pointed most authors to the
> > source of the problem.
> 
> If you want a challenge try if you can get strace to compile with
> glibc-kernheaders. 

the rh strace package seems to cope....

and while glibc-kernheaders hides the kernel internal structures, it
does expose all the external ones...



