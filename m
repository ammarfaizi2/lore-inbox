Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751107AbWATRbg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751107AbWATRbg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 12:31:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751108AbWATRbg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 12:31:36 -0500
Received: from free.wgops.com ([69.51.116.66]:8200 "EHLO shell.wgops.com")
	by vger.kernel.org with ESMTP id S1751107AbWATRbf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 12:31:35 -0500
Date: Fri, 20 Jan 2006 10:31:12 -0700
From: Michael Loftis <mloftis@wgops.com>
To: dtor_core@ameritech.net
Cc: James Courtier-Dutton <James@superbug.co.uk>, linux-kernel@vger.kernel.org
Subject: Re: Development tree, PLEASE?
Message-ID: <30D11C032F1FC0FE9CA1CDFD@d216-220-25-20.dynip.modwest.com>
In-Reply-To: <d120d5000601200850w611e8af8v41a0786b7dc973d9@mail.gmail.com>
References: <D1A7010C56BB90C4FA73E6DD@dhcp-2-206.wgops.com>	
 <43D10FF8.8090805@superbug.co.uk>	
 <6769FDC09295B7E6078A5089@d216-220-25-20.dynip.modwest.com>
 <d120d5000601200850w611e8af8v41a0786b7dc973d9@mail.gmail.com>
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



--On January 20, 2006 11:50:32 AM -0500 Dmitry Torokhov 
<dmitry.torokhov@gmail.com> wrote:

> On 1/20/06, Michael Loftis <mloftis@wgops.com> wrote:
>>
>> Well there's a whole grab bag of them that I'll be getting to over the
>> next few months, but the most immediate is the fact that I've gotten new
>> hardware from a venduh that requires me to build a new Debian installer
>> and new debian kernels.  I also have custom packages that depend on
>> devfs being there and now it's not.
>>
>> Yes I realise this change isn't out of the blue or anything, but it's in
>> a 'stable' kernel.  Why bother calling 2.6 stable?  We may as well have
>> stayed at 2.5 if this sort of thing is going to continue to be pulled.
>>
>
> Ok, so you agree that there was an ample warning that devfs is going
> away... Now, what would be different if 2.8.0 released tomorrow
> without devfs and your vendor would require you to build new Debian
> installer and kernel?

Because that would be expected.  That constitutes a major release, and 
should theoretically have had a development tree corresponding before it.

The problem is changing APIs mid-stream in what's being (or atleast been) 
called a stable release.

I'm trying to think of a way to relate this better but I just can't. 
What's needed is a 'target' for incremental updates, things like minor 
changes, bugfixes, etc.  I feel like supporting entirely new hardware 
(provided that the API is 'frozen' when it's realeased mainstream) in a 
stable kernel is fine, even adding features and functionality to existing 
stuff is fine but without having to take the whole damned enchilada of 
changes a development tree entails, which is all of the internal APIs. 
Yeah, it would/will become generally stagnant tree, but that's the point of 
a stable release.

It's horrificly expensive to maintain large numbers of machines (even if 
it's automated) as it is.  If you're doing embedded development too or 
instead, it gets even harder when you need certain bugfixes or minor 
changes, but end up having to redevelop things or start maintaining your 
own kernel fork.

I know there won't be any change today, or right now, or maybe not ever, 
but it seems to me that this is a step backwards in lk development. 
Without a stable release for vendors and distros, and yes, commercial ones 
at that, they either have to spend a LOT more time trying to keep track of 
all the changes and pushing them out constantly to their clients and users, 
it discourages development in that area, makes them go elsewhere where they 
don't have to deal with this.

I'm hearing a lot from developers of embedded type systems about this 
recent change in development.  Though, of those, I'm probably the only one 
who even occasionally pops up on LKML here.

Hopefully this last bit won't get buried in noise....

I really understand atleast some of the reasons from the kernel development 
standpoint, and can see many really good reasons for running a development 
tree like this, and as a method of development I like and agree with it. 
However...for the general consumption there still needs to be some sort of 
stable target that can be used that's 'blessed' with that mark, and will 
get atleast some attention by developers for security updates and (mostly 
major) bugfixes, and that people can contribute these sorts of things to, 
probably with the proviso that they also contribute it to the mainline dev 
kernel maybe IE if you're going to add new supported device to 'stable' 
2.6.16.x then you've got to add it to whatever the current 'dev' line is 
say 2.6.22 or whatever.  The placing of the .'s is just symbolic.  It could 
be 2.6.x and 2.7.x just as in the past or it could be 3.0.0.x and 3.0.0+n


