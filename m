Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268575AbUIGUCv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268575AbUIGUCv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 16:02:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268534AbUIGUBp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 16:01:45 -0400
Received: from pfepa.post.tele.dk ([195.41.46.235]:37007 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S268043AbUIGT6v
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 15:58:51 -0400
Date: Tue, 7 Sep 2004 23:58:49 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: Christoph Hellwig <hch@lst.de>, alan@lxorguk.ukuu.org.uk, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mark install_page static
Message-ID: <20040907215849.GB11238@mars.ravnborg.org>
Mail-Followup-To: "Randy.Dunlap" <rddunlap@osdl.org>,
	Christoph Hellwig <hch@lst.de>, alan@lxorguk.ukuu.org.uk,
	akpm@osdl.org, linux-kernel@vger.kernel.org
References: <20040907143741.GA8606@lst.de> <1094576968.9599.9.camel@localhost.localdomain> <20040907181259.GA12654@lst.de> <20040907121443.68c5c3b8.rddunlap@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040907121443.68c5c3b8.rddunlap@osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 07, 2004 at 12:14:43PM -0700, Randy.Dunlap wrote:
> On Tue, 7 Sep 2004 20:12:59 +0200 Christoph Hellwig wrote:
> 
> | On Tue, Sep 07, 2004 at 06:09:29PM +0100, Alan Cox wrote:
> | > On Maw, 2004-09-07 at 15:37, Christoph Hellwig wrote:
> | > > Not used anywhere in modules and it really shouldn't either.
> | > 
> | > Doesn't that happen (conveniently from some viewpoints Im sure) to break
> | > vmware ?
> | 
> | It happens because Arjan & I wrote up some scripts to find dead exports.
> 
> Can you put those at kernelnewbies.org or janitor.kernelnewbies.org ?

Keith Ownes 'namespacecheck' flags unused exported symbols as well.
And furthermore unused non-static definitions.

Present in -mm only atm.

Usage: make && make namespacecheck

Dependent on actual configuration so output should be read carefully.
Should be good on a make allmodconfig or make allyesconfig


	Sam
