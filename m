Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750850AbWBCORT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750850AbWBCORT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 09:17:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750849AbWBCORT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 09:17:19 -0500
Received: from bender.bawue.de ([193.7.176.20]:41149 "EHLO bender.bawue.de")
	by vger.kernel.org with ESMTP id S1750842AbWBCORR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 09:17:17 -0500
Date: Fri, 3 Feb 2006 15:16:51 +0100
From: Joerg Sommrey <jo@sommrey.de>
To: "Brown, Len" <len.brown@intel.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-acpi@vger.kernel.org, tony@atomide.com, erik@slagter.name,
       alan@lxorguk.ukuu.org.uk
Subject: Re: [PATCH] amd76x_pm: C3 powersaving for AMD K7
Message-ID: <20060203141651.GA15228@sommrey.de>
Mail-Followup-To: "Brown, Len" <len.brown@intel.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org, tony@atomide.com, erik@slagter.name,
	alan@lxorguk.ukuu.org.uk
References: <F7DC2337C7631D4386A2DF6E8FB22B3005EFE84D@hdsmsx401.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <F7DC2337C7631D4386A2DF6E8FB22B3005EFE84D@hdsmsx401.amr.corp.intel.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 03, 2006 at 03:45:59AM -0500, Brown, Len wrote:
> >- Enabling C2/C3 in the BIOS would be a very bad thing IMHO.
> >  From all he testing with amd76x_pm I found that is very tricky
> >  to go into C2/C3 "the right way".
> 
> Who defines the "right way"?  Is it guaranteed to work on all
> models and all configurations?  Exactly what is the reward
> for the cost we'd be paying and the risk we'd be taking?
> 
I'd be glad to know "the right way".  All I have is something that seems
to work on a number of boxes :-(
There are some benefits from using it and there are some known issues.
Whoever wants to use this must decide for himself if he's willing to
take the risk.  I'll emphasise this in the documentation.

> >  Simply reading the PM register without a
> >  suitable logic around leads to all kinds of instabilities.  You need
> >  to implement this logic and then enable the hardware.  The BIOS cannot
> >  do this.
> 
> How about if we put it this way...
> If the ACPI maintainer were an AMD employee,
> and he accepted a patch like this specific to Intel hardware --
> a patch that rejects whatever validation Intel, the BIOS
> vendor and the board vendor have put into the product --
> I'd call for his expulsion for ineptitude.

Don't get me wrong: I didn't ask for inclusion of this patch into
something official.  All I want is to tell people: here is something
that is useful for me and might be useful for you.

My point was to say, that *for me* this stuff doesn't look that
dangerous in exactly the environment it was written for:
AMD K7 + 762 + 766/768.

You have a well-defined position not to include this into the ACPI
subsystem, you pointed out your reasons for (not) doing so and I accept
that.

For me there are just a few questions left:
What is an appropiate way of announcing this patch on linux-kernel in the
future?  Does anybody feel uncomfortable with the way I did it in the
past?  Shall I cc: linux-acpi in the future, as suggested by Andrew?

-jo

-- 
-rw-r--r--  1 jo users 63 2006-02-03 14:28 /home/jo/.signature
