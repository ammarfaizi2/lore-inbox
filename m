Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289004AbSA3JVg>; Wed, 30 Jan 2002 04:21:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289005AbSA3JVX>; Wed, 30 Jan 2002 04:21:23 -0500
Received: from femail45.sdc1.sfba.home.com ([24.254.60.39]:8119 "EHLO
	femail45.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S289004AbSA3JVB>; Wed, 30 Jan 2002 04:21:01 -0500
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
To: Linus Torvalds <torvalds@transmeta.com>,
        Daniel Phillips <phillips@bonn-fries.net>
Subject: Re: A modest proposal -- We need a patch penguin
Date: Wed, 30 Jan 2002 04:22:10 -0500
X-Mailer: KMail [version 1.3.1]
Cc: Alexander Viro <viro@math.psu.edu>, Ingo Molnar <mingo@elte.hu>,
        <linux-kernel@vger.kernel.org>, Rik van Riel <riel@conectiva.com.br>
In-Reply-To: <Pine.LNX.4.33.0201292326110.1428-100000@penguin.transmeta.com>
In-Reply-To: <Pine.LNX.4.33.0201292326110.1428-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020130092100.KCMT17610.femail45.sdc1.sfba.home.com@there>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 30 January 2002 02:48 am, Linus Torvalds wrote:

> One thing intrigued me in this thread - which was not the discussion
> itself, but the fact that Rik is using bitkeeper.
>
> How many other people are actually using bitkeeper already for the kernel?
> I know the ppc guys have, for a long time, but who else is? bk, unlike
> CVS, should at least be _able_ to handle a "network of people" kind of
> approach.

One thing that's intrigued ME is the explanation of the hierarchy of 
maintainers.  There ARE specific people that patches should be reviewed by 
before being sent to you, there even seems to be a directed graph of them.

It would be kind of nice if it was documented enough that at least the 
maintainers in the maintainers list knew what it was, and who they should 
forward stuff on to after reviewing it.  That might go a ways towards 
addressing the "hitting resend isn't working" problem...

You've said that the tier under you (who you DO semi-reliably accept patches 
from) is a group of ten to twenty people.  If we knew who those people were, 
we could bug them to name THEIR secretary lists (or figure it out from the 
maintainers list)...

In your original response to the patch penguin proposal, you mentioned:

>The fact is, we've had "patch penguins" pretty much forever, and they
>are called subsystem maintainers.  They maintain their own subsystem, ie
>people like David Miller (networking), Kai Germaschewski (ISDN), Greg KH
>(USB), Ben Collins (firewire), Al Viro (VFS), Andrew Morton (ext3), Ingo
>Molnar (scheduler), Jeff Garzik (network drivers) etc etc. 

You also said:

> The VM stuff right now seems to be Andrea, Dave or you yourself.

That was responding to Rik van Riel, I'm guessing "Dave" is Dave Jones(?), 
and of course Andrea would be Andrea Arcangeli.  It seems that Andrea 
Arcangeli is the default VM maintainer, and that Dave Jones is gradually 
getting sucked into Alan Cox's old position as "miscelaneous maintainer" 
putting out a "this needs wider testing" tree.

The above seems to be about the full list I can assemble from recent emails.  
(You've also used David Miller again as an example in a later email, you put  
Paul Mackerras as a subordinate maintainer under him, and "Greg" 
(Kroah-Hartmann) had Johannes Erdfelt under him handling UHCI.  This isn't 
really new information about the top ten, more like some examples to help in 
tree building under them.)

This is eleven "top level" maintainers, one of whom is handling ext3 which 
sounds kind of odd...  (If David Miller is networking and Jeff Garzik is 
network drivers, would there be a "filesystem drivers" guy paired off with Al 
Viro?  Does EXT2 go through Andrew Morton as well?  Would Hans Reiser submit 
directly to you for ReiserFS patches, or should he get a signoff from...  
Um...  Andrew?  Al?  Try to get it into the -dj tree first?  Could I have a 
hint?)

To clarify what I'm aiming at: Are these eleven people a significant portion 
of the group of people who, if code makes it as far as them and they sign off 
on it, you'd then be willing to at least review it and if necessary 
explicitly reject? [1]  Should some of them be forwarding their patches to 
somebody other than you?  Are there more people on the list that lower level 
maintainers should be funneling patches to in order to eventually get them 
into your tree?

A two tier maintainer system definitely sounds like an improvement if that 
will help the process scale.  It's just that today is the first I've heard 
about it, and I had TRIED to study the situation before opening my big 
mouth...

> 		Linus

Rob

[Footnote 1] Implicit rejections can be REALLY stressful when combined with 
delaying the of inclusion of code that isn't actually rejected, but just not 
convenient to include right now.  It means that code that isn't merged 
immediately soon starts to smell of failure.  The throught process seems to 
go "If Linus hasn't accepted it, and Linus ignores patches he's rejecting, 
maybe he's rejecting this.  If so, the reason is something we need to figure 
out on our own, so let's all pile on the code and start badmouthing it until 
we figure out why Linus doesn't like it."  This can easily go beyond useful 
code review into pointless flame wars.  Arranging a system where it's 
possible to have some kind of progress indicator (even a "distance from 
Linus" index as patches progress through the maintainer tree) seems like a 
good thing to me...
