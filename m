Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264831AbTIDHl5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 03:41:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264778AbTIDHje
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 03:39:34 -0400
Received: from verein.lst.de ([212.34.189.10]:55498 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S264776AbTIDHiu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 03:38:50 -0400
Date: Thu, 4 Sep 2003 09:38:45 +0200
From: Christoph Hellwig <hch@lst.de>
To: Paul Mackerras <paulus@samba.org>, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix ppc ioremap prototype
Message-ID: <20030904073845.GA14669@lst.de>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>,
	Paul Mackerras <paulus@samba.org>, torvalds@transmeta.com,
	linux-kernel@vger.kernel.org
References: <20030903203231.GA8772@lst.de> <16214.34933.827653.37614@nanango.paulus.ozlabs.org> <20030904071334.GA14426@lst.de> <20030904083007.B2473@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030904083007.B2473@flint.arm.linux.org.uk>
User-Agent: Mutt/1.3.28i
X-Spam-Score: -5 () EMAIL_ATTRIBUTION,IN_REP_TO,QUOTED_EMAIL_TEXT,REFERENCES,REPLY_WITH_QUOTES,USER_AGENT_MUTT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 04, 2003 at 08:30:07AM +0100, Russell King wrote:
> But phys_addr_t in struct resource and being passed into ioremap is
> confusing.  Apparantly, it isn't a physical address, but a platform
> defined cookie which just happens to look like a physical address.
> 
> (or are we finally going to admit that it is a physical address?)

Umm, right, so the typedef name is also completly bogus, if we're
going to go that route it needs to be something likeb iocookie_t.

See why I want stuff like this on lkml?  It has implication far beyond
ppc..

