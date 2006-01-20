Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751133AbWATSQM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751133AbWATSQM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 13:16:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751134AbWATSQL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 13:16:11 -0500
Received: from bayc1-pasmtp04.bayc1.hotmail.com ([65.54.191.164]:59830 "EHLO
	BAYC1-PASMTP04.bayc1.hotmail.com") by vger.kernel.org with ESMTP
	id S1751133AbWATSQK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 13:16:10 -0500
Message-ID: <BAYC1-PASMTP0423ADAFBFC527482214EAAE1F0@CEZ.ICE>
X-Originating-IP: [69.156.6.171]
X-Originating-Email: [seanlkml@sympatico.ca]
Date: Fri, 20 Jan 2006 13:11:20 -0500
From: sean <seanlkml@sympatico.ca>
To: Michael Loftis <mloftis@wgops.com>
Cc: James@superbug.co.uk, linux-kernel@vger.kernel.org
Subject: Re: Development tree, please?
Message-Id: <20060120131120.338ebf17.seanlkml@sympatico.ca>
In-Reply-To: <58FE66DF7131B93329558B01@d216-220-25-20.dynip.modwest.com>
References: <D1A7010C56BB90C4FA73E6DD@dhcp-2-206.wgops.com>
	<43D10FF8.8090805@superbug.co.uk>
	<6769FDC09295B7E6078A5089@d216-220-25-20.dynip.modwest.com>
	<BAYC1-PASMTP02748FE950A9EFB4BAB4CFAE1F0@CEZ.ICE>
	<58FE66DF7131B93329558B01@d216-220-25-20.dynip.modwest.com>
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.8.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 20 Jan 2006 18:16:10.0001 (UTC) FILETIME=[96BC3810:01C61DED]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Jan 2006 10:56:25 -0700
Michael Loftis <mloftis@wgops.com> wrote:


> It is.  And the majority of the systems I've built (and still most new 
> installs) use 2.4, but because of the need in many situations for things 
> that only existed starting in 2.5 there's more argument for many cases for 
> 2.6 (and with some of the ARM development I've got going on there's even 
> more argument for 2.6...despite the headers playing games with me right 
> now....)

You see, that's exactly the problem.   Say you have a a mainline "stable" 
tree called 2.8 which still had devfs in it, and a development branch 2.9
with it removed.   If you end up needing something new in the 2.9 branch 
where devfs is remvoed you're in _exactly_  the same situation you find 
yourself in now.   

Essentially what you're saying is you need some stuff from the development 
branch (ie. why 2.4 is unacceptable to you today) but you want to pick 
and choose which pieces.

When you need some of the pieces that are only in the latest mainline
kernels you just _have_ to accept that other things will have changed
as well.   Changing the names of things isn't going to change that one
bit.


> I was under the impression that the consensus has usually been multiple 
> forks dividing a lot of external development resources into their own 
> little camps instead of letting them all contribute to the main kernel was 
> considered a bad thing?  Has this changed?  I know it's better for the 
> developers....but shouldn't they or...'someone' be responsible for 
> maintenance and have a place to do so?  Community maintenance? 
> Developer+maintainer pairs in cases where the developer is unable or 
> unwilling to actually maintain his/her code?
> 
> A target for such efforts, and community support for them would continue 
> the ... 'tradition' of this being a community kernel where efforts are 
> focused, and not where efforts are turned away and told to maintain your 
> own forks.

Well you do have a point there, but the counter point still remains.   The
current mainline developers are just too busy to fill this role.   There 
are costs associated with any model and the current model at least
reduces the costs borne by the mainline developers.   It would be nice
if someone would step up and provide a central repository for a stable
branch; but who?   I really don't know, but complaining to the current
mainline developers is the wrong approach to solving the issue.

> 
> Having a stable tree would atleast give me a place to commit changes to 
> publicly where/if I needed to.  My main concern *today* is the devfs 
> problems which I can solve yes and were known about yes, but require quite 
> a bit of effort just to support the second problem of *today* which is 
> Intel's latest e1000 variant.  That though is just today's troubles right 
> now.  I can see others coming, and I'm concerned.

There's no doubt that there are upsides to a mainline stable tree.    The
point is that there are also _costs_.   _You_ have to suggest a solution
that would offer a stable mainline tree and not cost the current mainline
developers anything.

> 
> I understand the reason, but the problem it creates is it does give a lot 
> of places incentive to just not contribute their bugfixes, and instead fork 
> since they're not interested in getting involved in API changes 'right now'.
> 

Yes.   It's all about tradeoffs.   The current model spreads the costs out
to more people than just the mainline developers.   In the end it's more 
fair than the older model and actually allows the developers to provide
us all with a better cutting edge kernel faster.   No doubt that there
are some downsides, but you haven't offered a way to pay for the costs
associated with going back to the old model.  

Sean
