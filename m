Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264305AbUAVFQX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jan 2004 00:16:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264363AbUAVFPd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jan 2004 00:15:33 -0500
Received: from stat1.steeleye.com ([65.114.3.130]:43435 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S266172AbUAVFOT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jan 2004 00:14:19 -0500
Subject: Re: AIC7xxx kernel problem with 2.4.2[234] kernels
From: James Bottomley <James.Bottomley@steeleye.com>
To: "Justin T. Gibbs" <gibbs@scsiguy.com>
Cc: Xose Vazquez Perez <xose@wanadoo.es>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Tosatti <marcelo.tosatti@cyclades.com>,
       linux-scsi <linux-scsi@vger.kernel.org>
In-Reply-To: <4022195408.1074577421@aslan.btc.adaptec.com>
References: <400BDC85.8040907@wanadoo.es>	<1074532919.1895.32.camel@mulgrave>		<37477754
	 08.1074537497@aslan.btc.adaptec.com>	<1074559838.2078.1.camel@mulgrave>
	<3942145408.1074564149@aslan.btc.adaptec.com>
	<1074573912.2081.81.camel@mulgrave> 
	<4022195408.1074577421@aslan.btc.adaptec.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 22 Jan 2004 00:14:09 -0500
Message-Id: <1074748451.2124.78.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-01-20 at 00:43, Justin T. Gibbs wrote: 
> As for control, the type of control "I seek" does exist.  You have it.
> You can also delegate some of that control if it suits you.

Well, as you have heard from the horse's mouth: I don't. 

> I provided all of the information required for you to make a reasoned
> decision of which change sets to integrate.  I had no idea that you
> would completely disregard the wealth of information in the change sets
> and change set comments when coming up with an integration point.  Your
> actions show that you didn't review or understand the changes well enough
> to submit them into the tree.  You probably didn't even test the resulting
> driver on real hardware before you submitted the changes.

Actually, I would have done nothing but for some 2.6 migration reports
of total lockups with the then in tree aic79xx driver.  The patch that
went into the tree was tested by the people reporting the lockups. 

> > The recovery code does work.  You may want it to work differently, and
> > that may make it work better, but that's an enhancement not a bug fix.
> 
> No.  The recovery code doesn't work.  Many of the people that know this
> don't bother complaining to you about it.  They complain to the HBA driver
> authors and the tech support departments of the companies that make the HBAs.
> The HBA driver authors then do what they have to ensure that the system
> remains viable after recovery.  

You haven't outlined any incorrect cases in your emails, just could do
better cases.  If you have all these bug reports that you haven't been
passing on, could you at least distil them to the mid layer failure
scenario that we can discuss fixing? 

> I mean honestly.  Do you think I would have gone to all of the trouble
> I did in doing my own watchdog recovery if the recovery code worked
> correctly?  Or that I would stand so firm in my position if these issues
> didn't have real customer impact?

Well, in coming up with the mid layer changes from 2.4 to 2.6 I did look
at what issues the main drivers had work arounds for. I used these work
arounds and an email you sent in September 2002 as the basis for a lot
of the mid-layer changes in 2.6.  None of the other drivers does this
timer interception and the issue wasn't mentioned in your email, so I am
dubious about the seriousness of the impact.

The way fixes get into linux is either lots of people complain, or one
person sends a fix, neither has happened in this case, which again leads
me to suspect that it's not a huge problem.

The still outstanding question is, now that you have a clearer idea what
being a Maintainer entails, do you wish to be the maintainer for
aic7xxx?

James


