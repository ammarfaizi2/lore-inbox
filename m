Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262700AbVCDKqz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262700AbVCDKqz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 05:46:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262633AbVCDKqz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 05:46:55 -0500
Received: from s2.ukfsn.org ([217.158.120.143]:7043 "EHLO mail.ukfsn.org")
	by vger.kernel.org with ESMTP id S262747AbVCDKqE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 05:46:04 -0500
Message-ID: <42283C67.4060302@dgreaves.com>
Date: Fri, 04 Mar 2005 10:45:59 +0000
From: David Greaves <david@dgreaves.com>
User-Agent: Debian Thunderbird 1.0 (X11/20050116)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: tglx@linutronix.de, linux-kernel@vger.kernel.org,
       Jens Axboe <axboe@suse.de>, Linus Torvalds <torvalds@osdl.org>,
       Jeff Garzik <jgarzik@pobox.com>,
       Andrew James Wade 
	<ajwade@cpe0020e06a7211-cm0011ae8cd564.cpe.net.cable.rogers.com>
Subject: Re: RFD: Kernel release numbering
References: <20050302205826.523b9144.davem@davemloft.net>	<4226C235.1070609@pobox.com>	<20050303080459.GA29235@kroah.com>	<4226CA7E.4090905@pobox.com>	<Pine.LNX.4.58.0503030750420.25732@ppc970.osdl.org>	<422751C1.7030607@pobox.com>	<20050303181122.GB12103@kroah.com>	<20050303151752.00527ae7.akpm@osdl.org>	<20050303234523.GS8880@opteron.random>	<20050303160330.5db86db7.akpm@osdl.org>	<20050304025746.GD26085@tolot.miese-zwerge.org>	<20050303213005.59a30ae6.akpm@osdl.org>	<1109924470.4032.105.camel@tglx.tec.linutronix.de> <20050304005450.05a2bd0c.akpm@osdl.org>
In-Reply-To: <20050304005450.05a2bd0c.akpm@osdl.org>
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>-rc just means "please start testing", not "deploy me on your corporate
>database server".
>  
>
Does it? Where on www.kernel.org does it say that?


Since people's trust was lost (a bit) when the -rc convention was 
"embraced and extended", it seems like it would be a good idea to 
_explicitly publish_ (and promote) the definitions (when they are agreed).

I am assuming that the problem is still essentially:
 "We need more testers"

And that one objective of this discussion is actually to clarify how the 
numbering scheme presents the risks and rewards associated with running 
a particular kernel? (yes, you're also sorting out development workflow 
but that's another issue)


Since the "show us the code" principle applies, I'm trying to draft some 
text that I propose linking to from a prominent place on www.kernel.org
(yes it may be hosted elsewhere)

My gut-feel working title was : "Our Promises To The Linux Kernel 
Community" - but I think that's going to be wrong :)

Here's the very very draft text - I've barely proof read it and I've not 
researched the process so I know it's not expressed well.
It's the kind of thing I'd want to read to assess which kernels to test 
- hell, right now it's not even obvious if you _want_ me to test them.

--------------------------------------

Background
The 'vanilla' linux kernel produced by Linus et al isn't for everyone.
Many, indeed most, users should be using the kernel that comes with 
their distribution (Debian, Fedora etc)
However, if _everyone_ did that then no-one would find the problems with 
the kernel - the 'many eyes' part of the FOSS community is essential - 
and you can be an active part of it!

This document aims to describe how people of different skill and 
experience levels can help.
Be warned - it can be hard work - but that's what makes it worthwhile.

The Problem
The kernel developers let you grab hold of a kernel tree at any time - 
which one should you use?

The key to all this is in the numbering; it indicates what stage of 
development that particular version of the kernel is at now.
Broadly the way it works is this(?):
* Developers send code and fixes to maintainers who have their own tree
* Maintainers keep an eye on the code quality and send it through to 
Linus when they think it's ready
* Linus holds the main, stable(ish) tree
* Distributions take a stable-ish tree and may apply their own changes 
and back-port bugs to try and get a very stable tree

Kernel Numbering
The kernel numbering usually looks like: 2.6.10; The X.Y.Z should be 
read as:
* X and Y indicate the main and sub versions of the kernel - probably 
'2.6' for quite a while yet.
* The Z indicates incremental 'releases' that the kernel community 
(Linus) think are OK to use in most 'production' environments.

But the beauty (and complexity) of the linux kernel is that you get to 
see it whilst it's putting its make-up on!!

Applying the Make-up - Developer Kernels
There are lots of developers who have their own 'bk' trees of the kernel 
that have changes applied from minute to minute.
Eventually the changes in these trees settle down a bit and elements of 
the trees are pulled into a major maintainers tree (eg -mm,  Andrew 
Morton's tree - more later)
Finally they're pulled into Linus' tree.

-pre Kernels
After a bit Linus feels that there have been quite a few changes and 
decides to get everyone back on the same page so he releases 2.6.x-pre1.
This is a developers release.
It won't be announced on linux-kernel-announce.
It will have bugs but it should compile cleanly and shouldn't corrupt 
your data (unless noted). It's very useful if you're helping to test 
some new hardware or feature and you don't mind if the machine crashes 
(maybe a lot - and maybe kills your data too!).
The cycle repeats through -pre2, -pre3 etc until Linus feels that it's 
time to think about a new proper release. During these cycles, 
developers can add new features and things that used to work may break.

So he takes the last -preN release and re-releases it as -rc1 ... a 
Release Candidate.

-rc Kernels
At this point he's saying that he'd _like_ to release it so it won't 
corrupt your data and the developers can't find any obvious bugs (unless 
noted) but there  *will* be some 'cos it's not been tested on every 
machine on the planet!
This is a testing release.
It will be announced on linux-kernel-announce.
You should be able to run it on normal hardware without crashes or any 
other problems. But you're part of the test team so there is a risk.
This cycle repeats through -rc2, -rc3 etc. During these cycles, _NO_ new 
features will be added. Only bugs will be fixed and it should be very 
rare for something that worked in -rcX to fail in -rcX+1.
When the bug reports stop appearing it's time for a release.
Linus will take the last -rcN and re-release it as 2.6.x (possibly with 
some errata of known bugs)

2.6.x.y Kernels
But it doesn't stop there :)
There may still be unknown bugs because no-one's tested a particular 
combination of components that triggers them.
So if a fix for a simple bug is discovered a group of people will review 
it and, if it's deemed to be very safe they will apply it to the 2.6.x 
and release 2.6.x.1 (or patches or whatever - yet to be agreed AFAICS)
It will be announced on linux-kernel-announce.

Wait, There's More...
Remember about the maintainers kernels? -mm and the like?
Well there's a list of them <here - where?> which explains how to get 
them and what their 'manifesto' is.
For the more sophisticated of you out there it may be worth trying out 
the -mm kernel (or a friend); they follows the same basic lines as 
Linus' - (in a sense they're based on them - but they are the leading 
edge of the linux kernel and have extra features and performance 
tweaks). They are often more experimental (and risky) than Linus' kernel 
though some strive to be more stable - read the manifesto to find out more.
They will be announced on their own lists (see manifesto)


So What To Do?
Join in - run the latest kernel and report back bugs - the kernel 
community _do_ want your help.
Just make sure you understand the risks and protect yourself appropriately.


To be continued... (mention kernelnewbies or other links, automating the 
process, ketchup etc - thanks Horst, Jan Dittmer, Andrew James Wade)


David
PS To be clear, I'm contributing this text in case anyone feels they can 
use it in any way.

