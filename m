Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264839AbTGBIp2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jul 2003 04:45:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264842AbTGBIp2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jul 2003 04:45:28 -0400
Received: from smithers.nildram.co.uk ([195.112.4.34]:57613 "EHLO
	smithers.nildram.co.uk") by vger.kernel.org with ESMTP
	id S264839AbTGBIp1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jul 2003 04:45:27 -0400
Date: Wed, 2 Jul 2003 09:59:51 +0100
From: Joe Thornber <thornber@sistina.com>
To: Kevin Corry <kevcorry@us.ibm.com>
Cc: DevMapper <dm-devel@sistina.com>,
       Linux Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC 3/3] dm: v4 ioctl interface
Message-ID: <20030702085951.GB410@fib011235813.fsnet.co.uk>
References: <20030701145812.GA1596@fib011235813.fsnet.co.uk> <20030701150246.GD1596@fib011235813.fsnet.co.uk> <200307011505.07184.kevcorry@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200307011505.07184.kevcorry@us.ibm.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 01, 2003 at 03:05:07PM -0500, Kevin Corry wrote:
> The "unregister" call needs to be before the actual rename. Same patch as a 
> couple weeks ago.

Agreed.

> > +static int check_name(const char *name)
> > +{
> > +	if (strchr(name, '/')) {
> > +		DMWARN("invalid device name");
> > +		return -EINVAL;
> > +	}
> > +
> > +	return 0;
> > +}
> 
> Can't we allow slashes in device names? I thought we discussed this before 
> (http://marc.theaimsgroup.com/?t=104628092700011&r=1&w=2). Any reason for the 
> change?

I think I made the wrong decision before.  Still thinking about it though.

> Does this imply that if the dm_swap_table() call fails, then the "inactive" 
> mapping is automatically deleted?

Yes, that is the behaviour ATM.  Would you rather it didn't ?

> As a side note, the __bind() function in dm.c currently will never return an 
> error, so dm_swap_table() doesn't necessarily need to check for one.

y, __bind can become void.

- Joe
