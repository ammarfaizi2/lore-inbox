Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289849AbSA2TrT>; Tue, 29 Jan 2002 14:47:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289844AbSA2TrB>; Tue, 29 Jan 2002 14:47:01 -0500
Received: from wagner.napster.com ([216.220.181.4]:50702 "EHLO
	wagner.napster.com") by vger.kernel.org with ESMTP
	id <S289849AbSA2Tql>; Tue, 29 Jan 2002 14:46:41 -0500
Date: Tue, 29 Jan 2002 11:46:55 -0800
Subject: Re: A modest proposal -- We need a patch penguin
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v480)
From: Jordan Mendelson <jordy@napster.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
In-Reply-To: <200201282213.g0SMDcU25653@snark.thyrsus.com>
Message-Id: <F372EB76-14F0-11D6-AA55-0003930408F0@napster.com>
X-Mailer: Apple Mail (2.480)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Monday, January 28, 2002, at 06:10  AM, Rob Landley wrote:

> Okay everybody, this is getting rediculous. Patches FROM MAINTAINERS are
> getting dropped on the floor on a regular basis. This is burning out
> maintainers and is increasing the number of different kernel trees (not 
> yet a
> major fork, but a lot of cracks and fragmentation are showing under the
> stress). Linus needs an integration lieutenant, and he needs one NOW.

While I'm not going to debate the fact that maintainence of the kernel 
is suboptimal, I would like to point out that the system that has been 
put in place is the correct way of doing it if you have someone with the 
vision necessary to oversee development. There are many ways to go about 
developing software, but many of them were created because of the lack 
of a strong leader and fortunately the Linux community has one (many in 
fact).

> We need to create the office of "patch penguin", whose job would be to 
> make
> Linus's life easier by doing what Alan Cox used to do, and what Dave 
> Jones is
> unofficially doing right now. (In fact, I'd like to nominate Dave Jones 
> for
> the office, although it's Linus's decision and it would be nice if Dave 
> got
> Alan Cox's blessing as well.)

Having one person who looks after patches is just going to create 
another bottleneck. The real problem is not Linus not accepting patches, 
but the process by which the patches are sent to him and the general 
impatience of the developer community.

We all know the kernel is broken up into a set of subsystems and those 
subsystems have maintainers. What is lacking however appears to be the 
leadership by these maintainers to:

* Delegate ownership of components in their subsystems to others.

* Prioritize small easily code reviewable patches for submission to 
Linus with adequate information about the contents of the changes 
including who has reviewed it, who wrote it, why it should be included 
and it's testing status is.

* Provide feedback to patch creators about the status of their patch 
including reasons why it was denied, suggestions for improvement, etc.

Of course, this isn't universally true. There are many instances where, 
especially in the case of device drivers, delegation has taken place, 
but a formal process of accepting patches that is actually adhered to by 
independent developers still appears to be lacking.

> Linus doesn't scale, and his current way of coping is to silently drop 
> the
> vast majority of patches submitted to him onto the floor. Most of the 
> time
> there is no judgement involved when this code gets dropped. Patches 
> that fix
> compile errors get dropped. Code from subsystem maintainers that Linus
> himself designated gets dropped. A build of the tree now spits out 
> numerous
> easily fixable warnings, when at one time it was warning-free. Finished 
> code
> regularly goes unintegrated for months at a time, being repeatedly 
> resynced
> and re-diffed against new trees until the code's maintainer gets sick 
> of it.
> This is extremely frustrating to developers, users, and vendors, and is
> burning out the maintainers. It is a huge source of unnecessary work. 
> The
> situation needs to be resolved. Fast.

I ague that the vast majority of patches submitted to Linus should be 
dropped on the floor. There is no reason why a compilation bug fix for 
an IDE chipset driver, PCI subsystem layer or even top-level Makefile 
should be sent directly to Linus by an independent developer.

The amount of time necessary to walk through code submitted by those who 
you don't know, don't trust and simply don't have an understanding of 
proper kernel development makes submitting patches directly to Linus 
like calling up the President to contest the suspension of your child 
from school. You may have a valid fix for a bug, but the system simply 
doesn't work if everyone decides to bypass local authority and go right 
to the top.

> The fact that 2.5 has "pre" releases seems suggestive of a change in 
> mindset.
> A patch now has to be widely used, tested, and recommended even to get 
> into
> 2.5, yet how does the patch get such testing before it's integrated 
> into a
> buildable kernel? Chicken and egg problem there, you want more testing 
> but
> without integration each testers can test fewer patches at once.

There is no chicken and egg problem. A patch gets wide testing by 
submitting it for peer review exactly like what goes on day in and day 
out on linux-kernel and various other subsystem mailing lists. The patch 
gets integrated into various forks of the tree for one reason or another 
and obtains even wider testing and sooner or later, it makes it into the 
kernel.

The patch tracking problem does exist. Maintainers loose track of 
changes. People integrate changes into their forks and the patch creator 
assumes that because someone is using their patch, their work is done. 
Worst of all, the people maintaining these forked trees forget where the 
patches they applied came from and bug fixes and public comments get 
missed.

There has been a lot of discussion about augmenting the kernel 
development process with automated tools of one sort of another, but 
tools are only as good as the people using them.

* Linus's email is obviously overloaded so the first thing that should 
be done is to get him a mailing list where only people he trusts can 
post patches they have reviewed. As a matter of policy, every other 
patch should simply be ignored by Linus.

* A hierarchical structure should be drawn out that shows who owns what 
and the flow of patches. This exists somewhat in the MAINTAINERS file, 
but I have a feeling that in some cases, the chain of command or is 
mostly unknown as not all maintainers should have direct contact with 
Linus. A real benefit would be to place the maintainers email address or 
associated mailing list in the top of every file they own (which exists 
mostly, but I don't believe it is part of a formal process.)

* A system of documentation for patches should be put in place. Each 
patch should have associated information about why it exists, who has 
approved it, what priority it is, change lists and of course, who wrote 
it. When a comment is made, it needs to be sent back to the author of 
the patch otherwise the author is just going to become frustrated and 
attempt to escalate the issue himself.

* A system by which maintainers can prioritize the patches they submit 
to Linus. Some patches are simply more important than others and 
developers are just going to have to deal with the fact that submitting 
a patch doesn't mean getting it integrated the next day.

Now this may sound like a lot of bureaucracy, but if the number of 
people Linus trusts can be expanded and the hierarchy kept shallow, the 
faster patches can be accepted or denied.

A final word. One thing that I have noticed over the years is because of 
the frantic pace of development, people tend to get a bit impatient when 
submitting patches. This mentality has also infected the average user 
who seem to upgrade to the bleeding edge for no apparent reason. What 
people need to remember is the 'stable' label given to the 2.4 tree 
refers to the type and frequency of changes made to the code base, not 
the stability of a running kernel. As developers, we need to be more 
patient when submitting patches. The world doesn't end because a patch 
doesn't make it into the bleeding edge kernels. If distributions need 
the patch, they'll integrate it, but that fact alone doesn't justify the 
patch making it into the kernel.

Of course that's just my opinion, I could be wrong.

Jordan

