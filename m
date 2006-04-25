Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932193AbWDYKvL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932193AbWDYKvL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 06:51:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932194AbWDYKvL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 06:51:11 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:60125 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932191AbWDYKvJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 06:51:09 -0400
Subject: Re: [PATCH] reverse pci config space restore order
From: Arjan van de Ven <arjan@infradead.org>
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: "Yu, Luming" <luming.yu@intel.com>, Andrew Morton <akpm@osdl.org>,
       "Brown, Len" <len.brown@intel.com>, linux-acpi@vger.kernel.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060425104800.GA26109@srcf.ucam.org>
References: <554C5F4C5BA7384EB2B412FD46A3BAD13D48A5@pdsmsx411.ccr.corp.intel.com>
	 <20060425104800.GA26109@srcf.ucam.org>
Content-Type: text/plain
Date: Tue, 25 Apr 2006 12:51:01 +0200
Message-Id: <1145962261.3114.23.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-04-25 at 11:48 +0100, Matthew Garrett wrote:
> On Tue, Apr 25, 2006 at 02:50:57PM +0800, Yu, Luming wrote:
> 
> > -	for (i = 0; i < 16; i++)
> > +	for (i = 15; i >= 0 ; i--)
> 
> We certainly need to do /something/ here, but I'm not sure this is it. 
> Adam Belay has code to limit PCI state restoration to the PCI-specified 
> registers, with the idea being that individual drivers fix things up 
> properly. While this has the obvious drawback that almost every PCI 
> driver in the tree would then need fixing up, it's also probably the 
> right thing.

it has a second drawback: it assumes all devices HAVE a driver, which
isn't normally the case...

