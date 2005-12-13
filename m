Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750711AbVLMIDl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750711AbVLMIDl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 03:03:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751324AbVLMIDl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 03:03:41 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:35985 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750711AbVLMIDl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 03:03:41 -0500
Subject: Re: [RFC][PATCH] Prevent overriding of Symbols in the Kernel,
	avoiding Undefined behaviour
From: Arjan van de Ven <arjan@infradead.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andrew Morton <akpm@osdl.org>, Ashutosh Naik <ashutosh.naik@gmail.com>,
       anandhkrishnan@yahoo.com, linux-kernel@vger.kernel.org,
       rusty@rustcorp.com.au, rth@redhat.com, greg@kroah.com
In-Reply-To: <1134427712.10304.6.camel@localhost.localdomain>
References: <81083a450512120439h69ccf938m12301985458ea69f@mail.gmail.com>
	 <20051212111322.40be4cfe.akpm@osdl.org>
	 <1134427712.10304.6.camel@localhost.localdomain>
Content-Type: text/plain
Date: Tue, 13 Dec 2005 09:03:34 +0100
Message-Id: <1134461015.2866.19.camel@laptopd505.fenrus.org>
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

On Mon, 2005-12-12 at 22:48 +0000, Alan Cox wrote:
> On Llu, 2005-12-12 at 11:13 -0800, Andrew Morton wrote:
> > Do we really need to do this at runtime?  We could check this when building
> > module depoendencies (for example).  That'll be a 95% solution..
> 
> Its almost the 0% solution. The kernel as shipped doesn't seem to have
> any clashing symbols like this. The two sets of cases people report are 
> 
> 1. Out of tree modules

these need to (re)run depmod anyway, and they do in general

> 2. Reconfiguring, rebuilding something from kernel to module and not
> cleaning up

which runs depmod as well


