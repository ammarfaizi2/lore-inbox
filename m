Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284144AbSA2WKN>; Tue, 29 Jan 2002 17:10:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284300AbSA2WKF>; Tue, 29 Jan 2002 17:10:05 -0500
Received: from dsl-213-023-043-145.arcor-ip.net ([213.23.43.145]:28296 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S284180AbSA2WJu>;
	Tue, 29 Jan 2002 17:09:50 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: <mingo@elte.hu>
Subject: Re: A modest proposal -- We need a patch penguin
Date: Tue, 29 Jan 2002 23:07:56 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Rob Landley <landley@trommello.org>,
        Linus Torvalds <torvalds@transmeta.com>,
        <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0201291544420.6701-100000@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.33.0201291544420.6701-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16VgQ0-0000AS-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On January 29, 2002 03:52 pm, Ingo Molnar wrote:
> On Tue, 29 Jan 2002, Daniel Phillips wrote:
> 
> > [...] Consider my patch to fix group descriptor corruption in Ext2,
> > submitted half a dozen times to Linus and other maintainers over the
> > course of two years, which was clearly explained, passed scrutiny on
> > ext2-devel and lkml, fixed a real problem that really bit people and
> > which I'd been running myself over the entire period.  Which one of
> > cleanliness, concept, timing or testing did I violate?
> >
> > If the answer is 'none of the above', then what is wrong with this
> > picture?
> 
> am i correct that you are referring to this patch?:
> 
>    http://www.uwsg.iu.edu/hypermail/linux/kernel/0011.3/0861.html
> 
> was this the first iteration of your patch? Your mail is a little more
> than 1 year old.

No, there are versions before that.  The first version, which really was 
inadequate because I didn't know about diff -u at the time (my first patch) 
is about 23 months old.

> You rated the patch as: 'The fix below is kind of
> gross.'. Clearly, this does not help getting patches applied.

Note who the email is addressed to.  I have tried many different techniques 
for communicating with this gentleman, including self-deprecation, and they 
all seem to have the same result: no patch applied, long wait, eventually 
some other patch a long time later will obsolete my patch in some way, and 
the whole thing drifts off into forgotten history.  Err, almost forgotten, 
because the bad taste remains.

And yes, there was a successor to the patch in which I did the job 'properly' 
by cleaning up some other infrastructure instead of just fixing the bug 
locally.  There was also a long lag after I created and submitted that 
version before the bug was actually fixed, and then it was only fixed in 2.4.

All of this only 'since you asked'.  I'd prefer not to dwell on it further, 
but as you could imagine, this story would not have developed this way if we 
have even a minimal form of patch tracking.  At least the bugs would have 
been fixed in all trees, nearly two years earlier.

> the ext2 bh-handling code had cleanliness issues before. I had ext2
> patches rejected by Linus because they kept the method of passing around
> double-pointers, and i have to agree that the code was far from clean.

Exactly.  The successor patch to the 'kind of gross' patch got rid of the 
double-pointers, it was the proper fix, though there is still no excuse for 
leaving the bug hanging around while coming up with the better version.

> Al did lots of cleanups in this area, and i think he fixed this issue as
> well, didnt he? So where is the problem exactly, does 2.4 still have this
> bug?

Oh yes, there are a few problems with what happened:

  - It left the bug circulating out in the wild far longer than
    necessary, and it bit people, pissing them off, especially when
    they figured out there was a patch not applied.

  - While it got fixed in the 2.4 tree, it didn't get fixed in 2.2 or
    for all I know, 2.0.

  - It pissed me off.

> in terms of 2.2 and 2.0, you should contact the respective maintainers.

This was taken care of by a good samaritan:

   http://marc.theaimsgroup.com/?l=linux-kernel&m=100989249313641&w=2

-- 
Daniel
