Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965077AbWJXDxz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965077AbWJXDxz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 23:53:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965081AbWJXDxz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 23:53:55 -0400
Received: from cavan.codon.org.uk ([217.147.92.49]:43708 "EHLO
	vavatch.codon.org.uk") by vger.kernel.org with ESMTP
	id S965077AbWJXDxy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 23:53:54 -0400
Date: Tue, 24 Oct 2006 04:53:46 +0100
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Shem Multinymous <multinymous@gmail.com>,
       David Zeuthen <davidz@redhat.com>,
       David Woodhouse <dwmw2@infradead.org>, linux-kernel@vger.kernel.org,
       olpc-dev@laptop.org, greg@kroah.com, len.brown@intel.com,
       sfr@canb.auug.org.au
Subject: Re: Battery class driver.
Message-ID: <20061024035346.GA24538@srcf.ucam.org>
References: <1161627633.19446.387.camel@pmac.infradead.org> <1161641703.2597.115.camel@zelda.fubar.dk> <41840b750610231956ib1c7204tafb23ecd76f5d9d2@mail.gmail.com> <20061024032704.GA24320@srcf.ucam.org> <1161661707.10524.547.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1161661707.10524.547.camel@localhost.localdomain>
User-Agent: Mutt/1.5.9i
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: mjg59@codon.org.uk
X-SA-Exim-Scanned: No (on vavatch.codon.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 24, 2006 at 01:48:27PM +1000, Benjamin Herrenschmidt wrote:
> On Tue, 2006-10-24 at 04:27 +0100, Matthew Garrett wrote:

> > Reading the battery status has the potential to call an SMI that might 
> > take an arbitrary period of time to return, and we found that having 
> > querying at around the 1 second mark tended to result in noticable 
> > system performace degredation.

> I think it's up to the backend to poll more slowly and cache the results
> on those machines then.

The kernel backend or the userspace backend? We need to decide on 
terminology :) There's no good programmatic way of determining how long 
a query will take other than doing it and looking at the result. I guess 
we could do that at boot time.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
