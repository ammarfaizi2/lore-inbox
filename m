Return-Path: <linux-kernel-owner+willy=40w.ods.org-S934292AbWKUCDR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934292AbWKUCDR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 21:03:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934296AbWKUCDR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 21:03:17 -0500
Received: from cavan.codon.org.uk ([217.147.92.49]:5831 "EHLO
	vavatch.codon.org.uk") by vger.kernel.org with ESMTP
	id S934292AbWKUCDQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 21:03:16 -0500
Date: Tue, 21 Nov 2006 02:02:48 +0000
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: Theodore Tso <tytso@mit.edu>, Linus Torvalds <torvalds@osdl.org>,
       "Rafael J. Wysocki" <rjw@sisk.pl>,
       Chuck Ebbert <76306.1226@compuserve.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [patch] PM: suspend/resume debugging should depend on SOFTWARE_SUSPEND
Message-ID: <20061121020247.GA11206@srcf.ucam.org>
References: <200611190320_MC3-1-D21B-111C@compuserve.com> <Pine.LNX.4.64.0611190930370.3692@woody.osdl.org> <200611191844.14354.rjw@sisk.pl> <Pine.LNX.4.64.0611191008310.3692@woody.osdl.org> <20061120221756.GA8708@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061120221756.GA8708@thunk.org>
User-Agent: Mutt/1.5.9i
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: mjg59@codon.org.uk
X-SA-Exim-Scanned: No (on vavatch.codon.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 20, 2006 at 05:17:56PM -0500, Theodore Tso wrote:

> If someone has a suggestion for how I can save the power state of all
> of the various components in my laptop so that the laptop cna be
> brought back to the 18W state after a suspend-to-ram, I'm all ears....

A good start might be to compare the PCI configuration registers before 
and after suspend. However, I suspect it's more complicated than that. 
Are you using the closed ATI drivers? If so, it's possible that they do 
something at X startup that they're not doing on resume. A good 
comparison might be to see if the power consumption is dramatically 
different over suspend/resume if you only boot to text mode - that is, 
never start X at all.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
