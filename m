Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264386AbTEaRnN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 May 2003 13:43:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264383AbTEaRnN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 May 2003 13:43:13 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:8657 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264386AbTEaRnM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 May 2003 13:43:12 -0400
Date: Sat, 31 May 2003 18:56:32 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Steven Cole <elenstev@mesatop.com>
Cc: Larry McVoy <lm@bitmover.com>, Dave Jones <davej@codemonkey.org.uk>,
       Christoph Hellwig <hch@infradead.org>,
       Chris Heath <chris@heathens.co.nz>, linux-kernel@vger.kernel.org
Subject: Re: coding style (was Re: [PATCH][2.5] UTF-8 support in console)
Message-ID: <20030531175632.GL9502@parcelfarce.linux.theplanet.co.uk>
References: <20030531095521.5576.CHRIS@heathens.co.nz> <20030531152133.A32144@infradead.org> <20030531144323.GA22810@work.bitmover.com> <20030531150150.GA14829@suse.de> <20030531153940.GA1280@work.bitmover.com> <1054401248.2900.124.camel@spc>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1054401248.2900.124.camel@spc>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 31, 2003 at 11:14:08AM -0600, Steven Cole wrote:

> statement when needed.
> 
> return -ETOSENDERADDRESSUNKNOWN;	/* this is OK */
> return (value & ZORRO_MASK);		/* so is this */

Like hell it is.  Parenthesis are _not_ needed here - production is
<statement> -> return <expression> ;

The only messy '('-related case in C grammar is sizeof as unary operation
vs. sizeof ( <type> ) (lovely way to torture parsers and students on exam:
sizeof (int)*p).  Everything else is pretty straightforward...
