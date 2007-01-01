Return-Path: <linux-kernel-owner+w=401wt.eu-S933251AbXAAIng@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933251AbXAAIng (ORCPT <rfc822;w@1wt.eu>);
	Mon, 1 Jan 2007 03:43:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933256AbXAAIng
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Jan 2007 03:43:36 -0500
Received: from smtp.ocgnet.org ([64.20.243.3]:46086 "EHLO smtp.ocgnet.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933251AbXAAInf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Jan 2007 03:43:35 -0500
Date: Mon, 1 Jan 2007 17:42:31 +0900
From: Paul Mundt <lethal@linux-sh.org>
To: Folkert van Heusden <folkert@vanheusden.com>
Cc: "Robert P. J. Day" <rpjday@mindspring.com>,
       Arjan van de Ven <arjan@infradead.org>,
       Denis Vlasenko <vda.linux@googlemail.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: replace "memset(...,0,PAGE_SIZE)" calls with "clear_page()"?
Message-ID: <20070101084231.GA9863@linux-sh.org>
Mail-Followup-To: Paul Mundt <lethal@linux-sh.org>,
	Folkert van Heusden <folkert@vanheusden.com>,
	"Robert P. J. Day" <rpjday@mindspring.com>,
	Arjan van de Ven <arjan@infradead.org>,
	Denis Vlasenko <vda.linux@googlemail.com>,
	Linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.64.0612290106550.4023@localhost.localdomain> <200612302149.35752.vda.linux@googlemail.com> <Pine.LNX.4.64.0612301705250.16056@localhost.localdomain> <1167518748.20929.578.camel@laptopd505.fenrus.org> <Pine.LNX.4.64.0612301750550.16519@localhost.localdomain> <20061231183949.GA8323@linux-sh.org> <Pine.LNX.4.64.0612311355520.17978@localhost.localdomain> <20070101015932.GP13521@vanheusden.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070101015932.GP13521@vanheusden.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 01, 2007 at 02:59:32AM +0100, Folkert van Heusden wrote:
> > > regarding alignment that don't allow clear_page() to be used
> > > copy_page() in the memcpy() case), but it's going to need a lot of
> 
> Maybe these optimalisations should be in the coding style docs?
> 
For what purpose? CodingStyle is not about documenting usage constraints
for every minor part of the kernel. If someone intends to use an API,
it's up to them to figure out the semantics for doing so. Let's not
confuse common sense with style.
