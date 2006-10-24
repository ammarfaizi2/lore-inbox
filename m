Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752070AbWJXFp0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752070AbWJXFp0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Oct 2006 01:45:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752071AbWJXFp0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Oct 2006 01:45:26 -0400
Received: from gate.crashing.org ([63.228.1.57]:27885 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1752070AbWJXFpZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Oct 2006 01:45:25 -0400
Subject: Re: Battery class driver.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Shem Multinymous <multinymous@gmail.com>,
       David Zeuthen <davidz@redhat.com>,
       David Woodhouse <dwmw2@infradead.org>, linux-kernel@vger.kernel.org,
       olpc-dev@laptop.org, greg@kroah.com, len.brown@intel.com,
       sfr@canb.auug.org.au
In-Reply-To: <20061024035346.GA24538@srcf.ucam.org>
References: <1161627633.19446.387.camel@pmac.infradead.org>
	 <1161641703.2597.115.camel@zelda.fubar.dk>
	 <41840b750610231956ib1c7204tafb23ecd76f5d9d2@mail.gmail.com>
	 <20061024032704.GA24320@srcf.ucam.org>
	 <1161661707.10524.547.camel@localhost.localdomain>
	 <20061024035346.GA24538@srcf.ucam.org>
Content-Type: text/plain
Date: Tue, 24 Oct 2006 15:43:42 +1000
Message-Id: <1161668623.10524.579.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-10-24 at 04:53 +0100, Matthew Garrett wrote:
> On Tue, Oct 24, 2006 at 01:48:27PM +1000, Benjamin Herrenschmidt wrote:
> > On Tue, 2006-10-24 at 04:27 +0100, Matthew Garrett wrote:
> 
> > > Reading the battery status has the potential to call an SMI that might 
> > > take an arbitrary period of time to return, and we found that having 
> > > querying at around the 1 second mark tended to result in noticable 
> > > system performace degredation.
> 
> > I think it's up to the backend to poll more slowly and cache the results
> > on those machines then.
> 
> The kernel backend or the userspace backend? We need to decide on 
> terminology :) 

The kernel. Userspace don't have to know the details of how hard it is
for the backend to fetch the data imho.

> There's no good programmatic way of determining how long 
> a query will take other than doing it and looking at the result. I guess 
> we could do that at boot time.

Ben.


