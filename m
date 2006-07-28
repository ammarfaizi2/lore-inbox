Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161320AbWG1Vx7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161320AbWG1Vx7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 17:53:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161321AbWG1Vx6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 17:53:58 -0400
Received: from 63-162-81-169.lisco.net ([63.162.81.169]:65480 "EHLO
	grunt.slaphack.com") by vger.kernel.org with ESMTP id S1161320AbWG1Vx6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 17:53:58 -0400
Message-ID: <44CA8771.1040708@slaphack.com>
Date: Fri, 28 Jul 2006 16:53:53 -0500
From: David Masover <ninja@slaphack.com>
User-Agent: Thunderbird 1.5.0.4 (Macintosh/20060530)
MIME-Version: 1.0
To: Hans Reiser <reiser@namesys.com>
CC: Linus Torvalds <torvalds@osdl.org>,
       "Horst H. von Brand" <vonbrand@inf.utfsm.cl>,
       Jeff Garzik <jeff@garzik.org>, Andrew Morton <akpm@osdl.org>,
       Theodore Tso <tytso@mit.edu>, LKML <linux-kernel@vger.kernel.org>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: metadata plugins (was Re: the " 'official' point of view" expressed
 by kernelnewbies.org regarding reiser4 inclusion)
References: <200607281402.k6SE245v004715@laptop13.inf.utfsm.cl> <44CA31D2.70203@slaphack.com> <Pine.LNX.4.64.0607280859380.4168@g5.osdl.org> <44C9FB93.9040201@namesys.com> <44CA6905.4050002@slaphack.com> <44CA126C.7050403@namesys.com>
In-Reply-To: <44CA126C.7050403@namesys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hans Reiser wrote:

> plugins if not for us.  Our plugins affect no one else.  Our
> self-contained code should not be delayed because other people delayed

And at the moment, I can still use Reiser4.  If I ever make a distro, I 
will include Reiser4 support, probably as the default FS.  That will 
help with getting into the kernel.

So, why is it that it's urgent to get into the kernel?  It will have to 
be bootstrapped one way or another -- either get it into the kernel so 
distros are more likely to include it, or get it into distros so the 
kernel is more likely to include it.

But this is exactly the kind of thing that has happened before.  With 
XFS, with Nvidia even -- clean it up, do it the way the kernel people 
want you to, because they're the ones who will have to maintain it for 
20 years, and make sure it doesn't stop working or break anything else.

> advantage from leading.  If they want to some distant day implement
> generic plugins, for which they have written not one line of code to
> date, fine, we'll use it when it exists, but right now those who haven't
> coded should get out of the way of people with working code.  It is not
> fair or just to do otherwise.  It also prevents users from getting
> advances they could be getting today, for no reason.

It prevents users from doing nothing.

> Our code will not
> be harder to change once it is in the kernel, it will be easier, because
> there will be more staff funded to work on it.

If indeed it can be changed easily at all.  I think the burden is on you 
to prove that you can change it to be more generic, rather than saying 
"Well, we could do it later, if people want us to..."

> As for this "we are all too grand to be bothered with money to feed our
> families" business, building a system in which those who contribute can
> find a way to be rewarded is what managers do.   Free software
> programmers may be willing to live on less than others, but they cannot
> live on nothing, and code that does not ever ship means living on nothing.

Let me put this in perspective the best way I know how, with an inane 
analogy:

Suppose there's a band.  A good band, full of impossible superstars, led 
by a benevolent dictator -- for the sake of argument, let's call him 
Elvis. (the King -- dictator...)  The band's doing really well, and 
Elvis & crew are getting paid fairly well just to share their music.

(Ok, maybe Elvis didn't write anything, but bear with me...)

Now, along comes a young Jimi Hendrix.  He wants to be in the band, and 
Elvis says "Sure, just come up with a song we like and we'll play it, 
and you can even play it with us!"  Sounds like a pretty good deal, so 
Jimi goes and tells all his friends, a couple of girls...

Now, Jimi finishes his song, Elvis listens to it, and if you know 
anything about the music Elvis did and the music Hendrix did, you can 
imagine what happens next.  Elvis says "This song just isn't us.  But if 
you change it here, and here, and maybe here, we'll play it."

Jimi is devastated.  He'd been counting on playing it with them that 
night, and if he doesn't, he won't have any groupies, all his friends 
will laugh at him, and his life will kind of suck.

But, does anyone really think Elvis has any business singing Voodoo 
Child?  Or Purple Haze?  Is it really fair to ask Elvis to completely 
change his act and embarrass himself to help Jimi out?

The answer is, Jimi shouldn't have staked so much on something that was 
never a guarantee.  And what's more, the real-life Jimi Hendrix never 
played with Elvis, but had a very successful band of his own.  And if 
Elvis was still alive, seeing Jimi play might make him change his mind, 
maybe -- but at least with his own band, Jimi's success isn't pinned on 
playing with Elvis.

This analogy is flawed in many ways, aside from just being plain 
chronologically impossible, but while I'm sure Linus feels bad for you, 
I don't think it's his obligation to compromise his kernel to help you 
out with your financial situation.  So it would help a lot if you 
wouldn't keep bringing it up in what should be a technical discussion.



So, if you can't make it work with VFS, then I guess you can't, and 
you're stuck either creating another interface which is not tied to any 
one filesystem and isn't tied to the VFS either, or coming up with a 
better (more specific) idea of how to make the Reiser4 plugin system 
acceptable to kernel maintainers without having to eat Ramen for a few 
years.

Understand that I'm putting on my devil's advocate hat right now.  I'd 
love to see Reiser4 merged tomorrow, or a week from now, exactly as it's 
written today, but I just don't see it happening.  I'd also love to get 
more technical, but I just don't know the Reiser4 internals well enough 
to understand the feasibility (or not) of any of my vague ideas.
