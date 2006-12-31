Return-Path: <linux-kernel-owner+w=401wt.eu-S933177AbWLaNjb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933177AbWLaNjb (ORCPT <rfc822;w@1wt.eu>);
	Sun, 31 Dec 2006 08:39:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933172AbWLaNjb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Dec 2006 08:39:31 -0500
Received: from smtp-vbr16.xs4all.nl ([194.109.24.36]:4215 "EHLO
	smtp-vbr16.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933177AbWLaNja (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Dec 2006 08:39:30 -0500
Date: Sun, 31 Dec 2006 14:39:02 +0100
From: Folkert van Heusden <folkert@vanheusden.com>
To: Arjan van de Ven <arjan@infradead.org>
Cc: "Robert P. J. Day" <rpjday@mindspring.com>,
       Denis Vlasenko <vda.linux@googlemail.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: replace "memset(...,0,PAGE_SIZE)" calls with "clear_page()"?
Message-ID: <20061231133902.GA13521@vanheusden.com>
References: <Pine.LNX.4.64.0612290106550.4023@localhost.localdomain>
	<200612302149.35752.vda.linux@googlemail.com>
	<Pine.LNX.4.64.0612301705250.16056@localhost.localdomain>
	<1167518748.20929.578.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1167518748.20929.578.camel@laptopd505.fenrus.org>
Organization: www.unixexpert.nl
X-Chameleon-Return-To: folkert@vanheusden.com
X-Xfmail-Return-To: folkert@vanheusden.com
X-Phonenumber: +31-6-41278122
X-URL: http://www.vanheusden.com/
X-PGP-KeyID: 1F28D8AE
X-GPG-fingerprint: AC89 09CE 41F2 00B4 FCF2  B174 3019 0E8C 1F28 D8AE
X-Key: http://pgp.surfnet.nl:11371/pks/lookup?op=get&search=0x1F28D8AE
Read-Receipt-To: <folkert@vanheusden.com>
Reply-By: Mon Jan  1 01:26:42 CET 2007
X-Message-Flag: MultiTail - tail on steroids
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > i don't see how that can be true, given that most of the definitions
> > of the clear_page() macro are simply invocations of memset().  see for
> > yourself:
> *MOST*. Not all.
> For example an SSE version will at least assume 16 byte alignment, etc
> etc.

What about an if (adress & 15) { memset } else { sse stuff }
or is that too obvious? :-)

> clear_page() is supposed to be for full real pages only... for example
> it allows the architecture to optimize for alignment, cache aliasing etc
> etc. (and if there are cpus that get a "clear an entire page"
> instruction.... there has been hardware like that in the past, even on
> x86, just it's no longer sold afaik)


Folkert van Heusden

-- 
www.biglumber.com <- site where one can exchange PGP key signatures 
----------------------------------------------------------------------
Phone: +31-6-41278122, PGP-key: 1F28D8AE, www.vanheusden.com
