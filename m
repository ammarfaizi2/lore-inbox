Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264454AbTF0Oqm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jun 2003 10:46:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264453AbTF0Oqm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jun 2003 10:46:42 -0400
Received: from franka.aracnet.com ([216.99.193.44]:20192 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S264448AbTF0Oqf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jun 2003 10:46:35 -0400
Date: Fri, 27 Jun 2003 08:00:30 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Matti Aarnio <matti.aarnio@zmailer.org>,
       "David S. Miller" <davem@redhat.com>
cc: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org,
       netdev@oss.sgi.com
Subject: Re: networking bugs and bugme.osdl.org
Message-ID: <25450000.1056726028@[10.10.2.4]>
In-Reply-To: <20030627075914.GO28900@mea-ext.zmailer.org>
References: <20030626.223002.21926109.davem@redhat.com> <18330000.1056692768@[10.10.2.4]> <20030626.224739.88478624.davem@redhat.com> <20030627075914.GO28900@mea-ext.zmailer.org>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I have recently pondered usage of Request Tracker  for this
> kind of tasks.   The problem with "post to the list" is that
> sometimes things slip thru without anybody catching them.
> 
> Integrating  linux-kernel  and  RT ...   urgh..  result would
> be quite ugly.  (Flame wars and out-of-topic threads going on
> as requests...)

Yeah, that is tricky ... see below.
 
>> This way not that "someone", but "everyone" on the lists
>> can participate and contribute to responding to the bug.
> 
> That needs merely message arriving to the list.

That's easy. I actually already hand filter the bugs, and forward to
linux-kernel those that seem to have enough information in to be useful
to people, and aren't already fixed.

There's also a mailing list for seeing every new bug that people can 
sign up for if they want (send me private email). 

> Ok, responding so that the response appears also
> at the bug db is another story.

That is possible to do - there's patches to Bugzilla that implement an
email interface, but it has some problems like the one you pointed out
above. One possiblility is to make people manually do something to the
email for each reply, but that's rather ugly. 

Hopefully we can discuss this more at OLS this year, and get a plan 
going forward that people are happy with. I'm well aware that Bugzilla
is not the perefect tool, but I think it's better than what we had 
before (yeah, I know some of us disagree), and is easy to change.
I'd rather start with something simple, and evolve it to the needs of
the community than try dumping something complex onto people up front.

> Bugzilla could be adapted to this use:
>   - Bugs are to be assigned to, e.g.   linux-net/netdev   list
>   - Everybody can comment on them at bugme (after signing on)
>   - Only some meta-admin (and original bug creator) can
>     alter status (e.g. mark as RESOLVED)
> 
> Having plenty of bugme group admins (half a dozen or so) to do
> the initial bugzilla assigment work, those people taking the task
> seriously, and everybody of them going en masse to assign arrived
> things.  That way people can have time off - as long as they
> coordinate among themselves.

Yup, that's easy to set up if you like. Or we can do it as a new list
if you prefer.

> In addition to assinging an OWNER to the bug, there should be
> automatic assignment of   linux-net  or  netdev   as  Cc,  IMO...
> That will handle the "publish widely" issue that DaveM is
> complaining about.

There's a QA field we can hack into doing that easily, but I want to
ensure people are happy auto-cc'ing lists before I do it. Or I can
forward the relevant ones by hand if you prefer. If it's going to piss 
people off more than it makes them happy, it's not worth it though.

Moreover, the bugme default owner doesn't have to be the code maintainer,
so if Dave wants someone else to do the "bug shuffling" stuff, that's
another way to go.

M.
