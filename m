Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu id <154170-4055>; Wed, 30 Sep 1998 10:57:50 -0400
Received: from gorski.net ([206.137.184.10]:6514 "HELO gorski.net" ident: "NO-IDENT-SERVICE[2]") by vger.rutgers.edu with SMTP id <154108-4055>; Wed, 30 Sep 1998 10:42:52 -0400
From: Andrew Tridgell <tridge@samba.anu.edu.au>
To: linux-kernel@vger.rutgers.edu
In-reply-to: <Pine.LNX.3.96.980930160126.538B-100000@dragon.bogus> (message from Andrea Arcangeli on Thu, 1 Oct 1998 00:45:32 +1000)
Subject: Re: jitterbug
Reply-to: tridge@samba.anu.edu.au
References: <Pine.LNX.3.96.980930160126.538B-100000@dragon.bogus>
Message-Id: <19980930154533Z12669167-25139+12715@samba.anu.edu.au>
Date: Thu, 1 Oct 1998 01:45:26 +1000
Sender: owner-linux-kernel@vger.rutgers.edu
Reply-To: linux-kernel@vger.rutgers.edu

Andrea wrote:
> I never used it and I don' t like it. This because my poor ppp connection
> is slow everywhere. The only TCP reliable service here is smtp (because
> it' s off-line of course ;-). 
> 
> I will feel confortable with jitterbug if somebody would act as a
> mail->jitterbug filter for me ;-). 

I wrote JitterBug and setup the linux-patches use of it so I'll try to
explain how it works for email-only people.

Patches come into the system by being emailed to the address
linux-patches@samba.anu.edu.au. The system then assigns an ID and send
an auto-reply to the submitter telling them how to find the status of
their patch.

The mail is then automatically forwarded to an address that Linus
setup on his machine (I think it goes to one of his pine
folders). Before forwarding the To: is changed to be Linus's address
and the CC is set to linux-patches@samba.anu.edu.au. If Linus does a
"reply all" then the reply will be sent direct to the patch submitter
as well as to the linux-patches system where it will be recognised as
a reply and added into the appropriate place in the system. If the
submitter then replies to that mail then the reply goes to Linus and
also to the linux-patches system, where it appears as a "followup".

Next are "notifications". People with "linux-patches accounts" can set
themselves up as wanting to be notified by email of a status change in
a particular message or in a whole directory of messages. For example,
davem gets email notification on the "done" directory so he knows when
something has been applied by Linus.

Note that the description up till now has only involved email. 

If you want to actually view the status of messages, download other
peoples patches, move messages between directories, add notes to them
etc then you need to use a web browser. When you do that you also get
a whole pile of other goodies that really aren't suitable for a email
interface. 

I was hoping that linux-patches would keep being used right through
the code freeze as I think that during a code freeze it is perhaps
more important than ever for everyone to know what is going on and
what the status of patches is. Linus decided to stop using it as a way
of discouraging "feature" patches. Maybe the current deferred
directory, or a new directory called "For 2.3" could be used to handle
inappropriate patches instead?

The big disadvantage of the linux-patches JitterBug is that it is more
work for Linus. He needs to use a browser to change the status of
patches when he accepts/rejects them (lots of "mousing around" as he
puts it). The big advantage is that it allows everyone to see the
status of pending patches and the explanations (attached as notes to
the patch) of why it was accepted/rejected/deferred. If Linus is
willing to do the mousing around then I think that the other
developers could benefit a lot from the system, but it is for Linus to
decide if he can afford that time.

Finally, I don't really want to become involved in setting the
policies for use of linux-patches. I'm very happy to add features as
needed or advise as to how to get the best from the system but I'm not
heavily enough involved in day-to-day kernel development at the moment
to make any judgements on the policy of its use. I initially proposed
using JitterBug after a mixup over a patch I submitted to Linus. I
proposed it as a technological fix to what I thought was a problem in
communication between kernel developers. Like most technological fixes
it doesn't address all the human aspects of the problem :-)

Cheers, Tridge

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
