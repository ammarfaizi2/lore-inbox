Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750802AbWATSny@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750802AbWATSny (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 13:43:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750803AbWATSny
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 13:43:54 -0500
Received: from free.wgops.com ([69.51.116.66]:524 "EHLO shell.wgops.com")
	by vger.kernel.org with ESMTP id S1750802AbWATSnx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 13:43:53 -0500
Date: Fri, 20 Jan 2006 11:43:19 -0700
From: Michael Loftis <mloftis@wgops.com>
To: sean <seanlkml@sympatico.ca>
Cc: James@superbug.co.uk, linux-kernel@vger.kernel.org
Subject: Re: Development tree, please?
Message-ID: <52ADBB95A163182693969541@d216-220-25-20.dynip.modwest.com>
In-Reply-To: <BAYC1-PASMTP0423ADAFBFC527482214EAAE1F0@CEZ.ICE>
References: <D1A7010C56BB90C4FA73E6DD@dhcp-2-206.wgops.com>
 	<43D10FF8.8090805@superbug.co.uk>
 	<6769FDC09295B7E6078A5089@d216-220-25-20.dynip.modwest.com>
 	<BAYC1-PASMTP02748FE950A9EFB4BAB4CFAE1F0@CEZ.ICE>
 	<58FE66DF7131B93329558B01@d216-220-25-20.dynip.modwest.com>
 <BAYC1-PASMTP0423ADAFBFC527482214EAAE1F0@CEZ.ICE>
X-Mailer: Mulberry/4.0.4 (Mac OS X)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
X-MailScanner-Information: Please contact support@wgops.com
X-MailScanner: WGOPS clean
X-MailScanner-From: mloftis@wgops.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--On January 20, 2006 1:11:20 PM -0500 sean <seanlkml@sympatico.ca> wrote:

> You see, that's exactly the problem.   Say you have a a mainline "stable"
> tree called 2.8 which still had devfs in it, and a development branch 2.9
> with it removed.   If you end up needing something new in the 2.9 branch
> where devfs is remvoed you're in _exactly_  the same situation you find
> yourself in now.

Except for there's atleast an old stable branch, as there has been in the 
past, and the change was made and having to track the NEW stable branch. 
Where do people apply security updates and patches to now that there's no 
stable branch out there?  Or is that just discouraged now?

> Essentially what you're saying is you need some stuff from the
> development  branch (ie. why 2.4 is unacceptable to you today) but you
> want to pick  and choose which pieces.

Negative, my big problem is the lack of a stable branch.  2.4 is really 
showing it's age in many places.  Lack of hardware support, lack of a lot 
of networking improvments in 2.6, lack of SMP improvments in 2.6....the 
list is pretty good.  If 2.6 isn't stable then why the 2.5->2.6 at all. 
Why isn't this still 2.5?  because people want/needed a new stable rev.

I know there will *always* be problems and issues with picking any point in 
time, arbitrary or not, to say lets work up for a feature freeze for 
release.  The Debian project knows this all to well.  However the quality 
of their releases has been so much better than anyone elses, I still stick 
with them as much as I can.

> When you need some of the pieces that are only in the latest mainline
> kernels you just _have_ to accept that other things will have changed
> as well.   Changing the names of things isn't going to change that one
> bit.

OK so I should have to change all my userland utilities, installers, etc 
just because I need a new PCI ID?  Or just because there's a *HUGE* bug in 
say, aic7xxx?  devfs is just one facet of a potentially bigger problem. 
(which you do seem to understand, so...a lot of this reply is for the 
benefit of the larger audience)


> Well you do have a point there, but the counter point still remains.   The
> current mainline developers are just too busy to fill this role.   There
> are costs associated with any model and the current model at least
> reduces the costs borne by the mainline developers.   It would be nice
> if someone would step up and provide a central repository for a stable
> branch; but who?   I really don't know, but complaining to the current
> mainline developers is the wrong approach to solving the issue.

If someone were to step up with a svn (or git...i'm not familiar with git 
yet though) or similar repository, would it be 'blessed' by the developers 
though, and able to maintain a version stream?  This would give the 
community, and the developers that wished or were able a place to push out 
changes that are of a maintenance nature.  Yes maintenance is a headache, 
but 90% of development is maintenance ;)  atleast in the long view.  I 
don't want, nor think that the developers should 'maintain' indefinitely 
old versions, but having a target for maintenance would be good, assuming 
it was 'blessed' and made to be a common place.

> There's no doubt that there are upsides to a mainline stable tree.    The
> point is that there are also _costs_.   _You_ have to suggest a solution
> that would offer a stable mainline tree and not cost the current mainline
> developers anything.
>
>>
>> I understand the reason, but the problem it creates is it does give a
>> lot  of places incentive to just not contribute their bugfixes, and
>> instead fork  since they're not interested in getting involved in API
>> changes 'right now'.
>>
>
> Yes.   It's all about tradeoffs.   The current model spreads the costs out
> to more people than just the mainline developers.   In the end it's more
> fair than the older model and actually allows the developers to provide
> us all with a better cutting edge kernel faster.   No doubt that there
> are some downsides, but you haven't offered a way to pay for the costs
> associated with going back to the old model.

OK well....we're certainly on the same page....and seem to have an idea of 
where to go.  I guess just how to get there is the problem.

If a community effort was started...and provided we (this proposed 
community effort, which will probably have atleast some overlap with some 
mainline kernel developers) can get the blessing of the mainline effort I 
think it might work.  Especially if one or more distro's would sign on to 
the effort and publish their maintenance and bugfixes there as well.  The 
general idea being that a certain number of releases are picked to maintain 
as maintenance releases, hopefully with feedback from people on bugs and 
preferably with feedback of patches and/or commits to fix bugs and maintain 
a 'stable' branch that has atleast some hope of having a larger than one 
investment in keeping security updates atleast, and minor enhancements. 
There'd be someone ultimately responsible for it all, just as there is for 
the mainline, to coordinate and make releases based on that.  Likely these 
branches/forks would be pretty quiet just fixing mainline bugs and minor 
things that are needed in the course of normal maintenance of a project.

>
> Sean
>



--
"Genius might be described as a supreme capacity for getting its possessors
into trouble of all kinds."
-- Samuel Butler
