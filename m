Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288614AbSA2Dlk>; Mon, 28 Jan 2002 22:41:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288623AbSA2Dlb>; Mon, 28 Jan 2002 22:41:31 -0500
Received: from dsl254-112-233.nyc1.dsl.speakeasy.net ([216.254.112.233]:53641
	"EHLO snark.thyrsus.com") by vger.kernel.org with ESMTP
	id <S288614AbSA2DlR>; Mon, 28 Jan 2002 22:41:17 -0500
Message-Id: <200201290341.g0T3fNU30909@snark.thyrsus.com>
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
To: Francesco Munda <syylk@libero.it>
Subject: Re: A modest proposal -- We need a patch penguin
Date: Mon, 28 Jan 2002 22:42:19 -0500
X-Mailer: KMail [version 1.3.1]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200201282213.g0SMDcU25653@snark.thyrsus.com> <200201290137.g0T1bwB24120@karis.localdomain>
In-Reply-To: <200201290137.g0T1bwB24120@karis.localdomain>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 28 January 2002 08:37 pm, Francesco Munda wrote:
> On Mon, 28 Jan 2002 09:10:56 -0500
>
> Rob Landley <landley@trommello.org> wrote:
> > Patch Penguin Proposal.
> >
> > [...]
>
> You mean some sort of proxy/two-tier development? A "commit/rollback"
> transaction model on the kernel itself?

Think how Alan Cox's tree used to work.  Just because Alan accepted a patch 
didn't guarantee Linus wasn't going to come up with a reason to shoot it 
down.  It just meant the patch wasn't going to be ignored, and if it WAS 
dropped there would probably going to be some kind of explanation.

Whether the patch penguin wants to use some kind of tool to maintain their 
tree (like CVS) with a "commit/rollback" model is a seperate issue.  Linus 
isn't going to use it, and linus isn't going to have to see it.  Linus gets 
the kid of patches he likes, which have already had merge clashes and the 
really obvious thinkos resolved before he sees them, and have probably even 
been tested by the foolhardy individuals currently downloading the -ac, -dj, 
and -aa trees.

Right now, Alan's tree is in the process of going back into circulation.  He 
tells me that his tree is basically a delta against marcello (2.4), and DJ is 
doing a delta against linus (2.5).  Over time, the need for a 2.4 delta will 
probably diminish as new development shifts over to 2.5.  Right now, the 
patch constipation we've been seeing is, in my opinion, directing development 
to occur against 2.4 that should at the very least be eyeing 2.5.  (Alan is 
probably NOT interested in integrating patches that Marcelo has no intention 
of eventually integrating into 2.5.  So he's not taking the new development 
integration pressure off, that's DJ's job.)

I think DJ could definitely use a clearer mandate.

> I deeply agree with you, especially in keeping "many eyes" to look at the
> same kernel tree, and not chosing one of the many subtrees; as added bonus,
> this stuff is buzzword compliant! What we can ask more? :)
>
> Now, Linus' call to accept _your_ patch. Fingers crossed already.

I'm getting a lot more support off the list than on the list.  People seem to 
be afraid to cc: linux-kernel.  I underestimated how deeply steeped in 
politics this issue seems to have become.  It seems a fairly straightforward 
optmiziation, mainly a clarification of of the way things have been done in 
the past and a formalization of a position that got a bit confused in the 
transition from one officeholder to another.

Before posting here, I bounced an earlier draft off of both Alan Cox and Dave 
Jones.  Alan's response was, and I quote:

> I'm certainly fine with DaveJ being the victim 8)

Dave didn't seem to have any major objections but raised a lot technical 
points to the effect of "I'm already doing this bit".  Both of them gave me 
permission to post most of our conversation to the list, but seem unwilling 
to do it themselves. :)

I've gotten several other agreements, some from people trying to find an 
off-list place we could discuss it (okay, so what's THIS list for again)?  
And one person, who shall remain nameless (at least as long as he refuses to 
speak for himself. :) brought up the subject of Linus co-designing bitkeeper 
way back when to cope with exactly some of these problems.

Bitkeeper is a technical tool attempting to deal with a social problem.  
Merging patches, resolving conflicts between them, testing them, and keeping 
them current as the tree changes under them requires programmer work.  A 
human needs to do it.  Whether that human uses bitkeeper, CVS, a directory 
full of patch files, or manually keeps all the patches in printouts in a shoe 
box is a side issue.  A human can feed Linus better patches than any software 
tool possibly could.

Now if the patch penguin wants to use bitkeeper for his own internal 
patch-wrangling, that's a seperate issue.  One you should take up with the 
patch penguin, once we have one.  (Of course the developer community and the 
maintainers might exert some pressure on the patch penguin to use CVS, but 
how is this a bad thing from Linus's perspective: it means they'e NOT bugging 
HIM about using CVS anymore.  And again, this is an enhancement/detail that 
can be resolved later.)

As for attracting Linus's attention, there's a penguin and egg problem here: 
without an integration lieutenant Linus is largely too swamped to reliably be 
aware of this kind of thread on the list, so how can he get the suggestion to 
anoint someone with holy penguin pee to basically act as his secretary and 
clean up this mess of patches so he can properly sort through them once 
they've been organized and laid out in front of him in nice neat rows.  Hence 
the drive to get people to agree to it so the thread grows large enough to 
attract Linus's attention, and also passes his "it's been discussed enough to 
find any particularly obvious holes with it" filter...

So everybody who thinks this is a good idea, please say so.  Those who don't 
like it, please say so too so the objection can be aired and maybe resolved.  
The core idea here really is to save Linus time and effort.  Everything else 
is either a direct consequence of that, or a fringe benefit.

> -- FM

Rob
