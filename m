Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290931AbSAaFP1>; Thu, 31 Jan 2002 00:15:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290932AbSAaFPV>; Thu, 31 Jan 2002 00:15:21 -0500
Received: from femail29.sdc1.sfba.home.com ([24.254.60.19]:1482 "EHLO
	femail29.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S290931AbSAaFPG>; Thu, 31 Jan 2002 00:15:06 -0500
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
To: Larry McVoy <lm@bitmover.com>
Subject: Re: A modest proposal -- We need a patch penguin
Date: Thu, 31 Jan 2002 00:16:13 -0500
X-Mailer: KMail [version 1.3.1]
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <3C586C8D.2C100509@inet.com> <20020131031113.KFXH25423.femail46.sdc1.sfba.home.com@there> <20020130195154.R22323@work.bitmover.com>
In-Reply-To: <20020130195154.R22323@work.bitmover.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020131051505.MGLL25889.femail29.sdc1.sfba.home.com@there>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 30 January 2002 10:51 pm, Larry McVoy wrote:

>Sigh.  OK, I'm taking one more pass at trying to get you to see the light
>and then I give up.

And I'm trimming the cc list back a bit...

> > I'm not quite sure how Linus does this, but how I'd do it is [a really
> > complicated solution based on patches that won't work]

A) It's not really all that complicated.  The minimal commands are "untar" 
and "patch".  If you don't feel like doing fixups at all (with a third 
command, an editor), the rejected patches can be bounced.  It does mean 
you're keeping track of patches manually, but I'm just talking about what 
happens between -pre releases, which is not an infinitely large set of 
patches to wrangle...

B) It's a solution that is working, and has been for years.  It certainly has 
its disadvantages, but it does in fact function.  What the existing process 
is used to do on a regular basis is the definition of the minimum level of 
functionality I would expect from bitkeeper.

I'm not defending the patch method.  I'm certainly not advocating it as the 
ultimate solution.  But it has worked for years, and a replacement that can't 
easily do things it can easily do seems flawed to me.

If you'd like to say that I'm wrong about bitkeeper and that it CAN easily do 
the above.  (That's kind of the reply I expected.)  But attacking the 
desirability of doing things that the existing patch managment process 
handles on a fairly regular basis...  Seems counter-productive to me.

> Think.  What you are describing is basically what Linus does today.  And
> noone, including you, is happy.  You're the guy who started this thread.

I wasn't trying to get Linus to use CVS.  That's just a fringe benefit.  I 
was trying to figure out how to deal with patches getting dropped to the 
point people were suggesting automatic remailers.  I didn't directly suggest 
changing what Linus did with patches on his own hard drive.  I went out of my 
way to craft a proposal where he DIDN'T have to change any of that.  I was 
mostly talking about the method by which patches got to him, which is where I 
(right or wrong) percieved the existence of a problem.

You can say I suggested the wrong solution, and you can say I identified the 
wrong problem.  But please don't project your desires onto me and try to use 
that to explain why you think I should be agreeing with you.

To clarify: I'm HAPPY to see Linus giving bitkeeper another try.  I think 
this is an EXTREMELY positive development.  I do NOT want to discourage it.  
I also don't want to see it fail because you expect Linus to adapt to 
bitkeeper rather than trying to understand what Linus does and adapt 
bitkeeper to be a good tool for him.

(Some of these are simple documentation questions.  How does Linus do THIS.  
And I intend to go RTFM when I have time to tackle a new project (I.E. not 
tonight), but I'm mostly following up on your replies to questions other 
people originally asked, which I didn't consider to be a real answer to the 
question.)

> However, what you described *completely* misses the point.

The message you're replying to was answering your question, which to me 
seemed to be you changing the subject form the earlier "people have to send 
linus patch A in order to send him a bitkeeper change set with patch B, even 
if they don't want to".  I wasn't talking about  what goes on within Linus's 
tree, it's about what people send to him.  (Bitkeeper change sets seem to 
have descriptions and potentially automatic notification back to the original 
patch submitter that they got looked at and/or applied, which is a potential 
improvement over raw text patches.  The ordering requirements do not seem to 
me to be a pure improvement, but instead something that takes extra effort to 
work around.)


> Do you start to see the problem?  You were yelling and screaming
> "BitKeeper sucks because it can't take a patch out" when in fact
> it can do exactly what you said it can't.

Yelling and screaming?  Was I?  (I think you read too much into the rant tag. 
 The point of one of those things is "not everybody is expected to agree with 
me on this"...)

There's a difference between "if you can't take the patch out, then maybe 
bitkeeper sucks" and "bitkeeper definitely sucks because I just KNOW you 
can't..."  You seem to have missed the conditional and homed right in on 
defending your baby from hypothetical criticism.  Maybe I'm not expressing 
myself clearly.  It's happened before...

You just answered my question: bitkeeper can take the patch out, the problem 
isn't a real problem.  Thanks, that's what I wanted to know.

> On top of that, what you
> were complaining about isn't the point.  The thing that you say
> BK can't do, but it can, is not what Linus wants.  Not even close.
>
> And you haven't begun to understand that BK is a distributed, replicated
> system.  You can turn all that off and you've got CVS, so turning it
> off isn't an option.

If you turn off the distributed/replicated nature of bitkeeper, it acquires 
problems with file renames and reproducibility?  Without being distributed, 
you have problems with file renames and reproducibility?  Several other 
developers use a CVS or BK repositories which nobody else ever directly 
checks any code into.  They import patches, and then do their own development 
in that tree.  The source management system is purely for their own 
convenience.  Code goes to other developers as unified diffs.

I'm not talking about fun bells and whistles with which Linus could IMPROVE 
his process.  I'm trying to make sure there are no holes that stop him from 
doing what he could do before.  (There SHOULDN'T be.  But if there aren't, 
why did it take so long to adopt?  Seems worth a check.  Several people who 
use bitkeeper have said things along the lines of "I want to do this and 
haven't figured out how", and you actually seem to have replied "no you don't 
really want to do that" on more than one occasion.  I'm hoping this is a 
miscommunication, which is why I'm trying to follow up.  I mostly just wanted 
clarification and reassurance...)

> Leaving it on means that the revision history is replicated.

You seem to have an unquestioning assumption that infinitely replicating the 
revision history is a good thing.

Linus himself seems to have denied this assumption.  Just because a 
downstream developer took two months to come up with a subsystem and did 
eight hundred seperate checkins of which only maybe 20% of the code made it 
into the final version, does NOT mean that Linus cares.  That level of detail 
IS more information, but there's a limit to how much information you want 
before it becomes cruft in Linus's tree.

> So it isn't an option to collapse a pile of changes into a smaller pile,
> the bigger pile will come back the next time he updates
> with the other tree.

And I'm saying I'm not convinced this is necessarily a good thing.

> And once again, you come back with another post that shows you just want
> to yell

I occasionally use caps to emphasize a word because you can't put italics or 
underlines in non-html email.  I do not however PUT MULTIPLE CAPITALIZED 
WORDS TOGETHER.  That is shouting, yes...)

> and you haven't thought it through, into my kill file you go,

By all means.  I've made it back into Al Viro's now.  (I'm a bit confused how 
I managed to get OUT of it, but I probably changed email addresses...)

Generally, I don't consider putting my fingers in my ears and going "la la la 
I can't hear you" to be the logical equivalent to proving your point in an 
argument.  When I don't feel progress can be made, I generally just stop 
replying.

> my blood pressure goes down, you get to yell all you want, everybody
> is happy.  I'm willing to try and make BK do what is needed here; I'm
> not willing to tolerate people who don't think.

And of course the other person not seeing your point is always entirely 
because they're all not thinking?  There's no possibility of legitimate 
miscommunication, or legitimate difference of opinion about anything?

That must save time.

Rob
