Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276552AbRJYWaN>; Thu, 25 Oct 2001 18:30:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276576AbRJYW3y>; Thu, 25 Oct 2001 18:29:54 -0400
Received: from Expansa.sns.it ([192.167.206.189]:7695 "EHLO Expansa.sns.it")
	by vger.kernel.org with ESMTP id <S276552AbRJYW3s>;
	Thu, 25 Oct 2001 18:29:48 -0400
Date: Fri, 26 Oct 2001 00:30:35 +0200 (CEST)
From: Luigi Genoni <kernel@Expansa.sns.it>
To: "M. Edward Borasky" <znmeb@aracnet.com>
cc: <linux-kernel@vger.kernel.org>
Subject: RE: concurrent VM subsystems
In-Reply-To: <HBEHIIBBKKNOBLMPKCBBOEPDDPAA.znmeb@aracnet.com>
Message-ID: <Pine.LNX.4.33.0110260000280.8916-100000@Expansa.sns.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 25 Oct 2001, M. Edward Borasky wrote:

> > -----Original Message-----
> > From: linux-kernel-owner@vger.kernel.org
> > [mailto:linux-kernel-owner@vger.kernel.org]On Behalf Of Luigi Genoni
> > Sent: Thursday, October 25, 2001 6:07 AM
> > To: Marton Kadar
> > Cc: linux-kernel@vger.kernel.org
> > Subject: Re: concurrent VM subsystems
>
>
> > In fact, here is the difference beetwen a coordinate and managed project,
> > and the "lets' put all inside" approach.
>
> No, it is the difference between an orderly, predictable, SEI - CMM type
> development process used in military projects and the "brutal meritocracy",
> Darwinian, survival of the fittest, life-at-the-edge-of-chaos process used
> with Linux.
I hate a militar approach, and indeed I was not meaning that.
But also in a darwinian system, you have to make a choice.
Linus is right when he decide for one VM in his tree, so is Alan to choice
another for his own. They take a position in front of the users, and doing
so they
declare which way they are planning for the development.
In this particular darwinian system could happen that the VM for the 2.4
kernels will not be the one choosen
for the 2.5 series.  That is because one VM could be the best for present
situation, but the other
can be better for the future development. As you see this is not
life-at-the-edge-of-chaos. On this point of view, I do trust both Linus
and Alan, that they do a well pondered choice, corresponding to the idea
they have, and to their plan, for the development they want for their
tree.
A darwinian system is very ordered, belive me, is very far from chaos.
 > > That
said. > > Those two VM are good, but for different use, and different HW.
> > It is a choice also which main use the kernel should address as a target.
> >
> > I already exposed my opinion, and both Andrea and Rik know it very well.
> > The VM for servers needs to be predictable, for desktops needs to be as
> > fast as possible, also if it is a little less predictable and stable (who
> > cares if you reboot you desktop once every two days?).
>
> And I've given my opinion, though perhaps not quite as simply as I could. My
> opinion is that there should be *one* VM (and *one* scheduler) *tunable* to
> the purpose of the computer, rather than one which is good for a desktop,
> another for a uniprocessor server, another for a few processors and another
> for "massively parallel" servers. Just out of curiosity, which of the two
> VMs is better for "predictable servers" and which one is better for "who
> cares if you reboot" desktops?
In the perfect OS there is just one VM that is perfect for every use with
every hardware, and every kind of architectures. But is there would be a
perfect OS, we would not need to do any development.
And you are right, the VM should be tunable (see latest AA patches),
but anyway you will have to deal with practical limits.
AA VM, in my tests, showed to be better for
my web servers anmd db, also if there are some details that should be
refined, (Andrea, I sended you the test case), On the other side Rik VM is
better in very particolar HI load, (on sparc64 in my tests), sytuations.
In my opinion, its just now, after we reach a good stability, that we can
start to tune for speed of the VM. I think to servers, because that is
what I have in my hands, and I talk for my esperience.
For servers stability is more important than speed, but when stability is
satisfying, then you
should start to tune for speed, to get the best performance.
 >
> > To have competition this way is also good, because there can also be
> > cooperation and compenetration.
>
> Yes ... the "life at the edge of chaos" I spoke of earlier. But in the end,
> a single tunable algorithm would be preferable in my book to doing *two*
> kernel builds and *two* boots every time one wanted to benchmark VM! One can
> waste *weeks* doing this, when a single tunable algorithm could be optimized
> to a benchmark or a real workload in *minutes*! Really! Just *minutes*, if
> you do it right! It's about respect for the customer's time -- a concept
> that needs to be considered along with all the exciting raw computer science
> we're doing. :-)
That is what system managers are for.
That is also what I like of my job. I have to deal every day with similar
choice with every Unix system I administer. Sometimes
I also need to move cpus and memory beetwen the E!=Ks domains, because
I have to do this to get the work done with full stability and fastly
(BTW, with linux domains I cannot do that without a bring up, and that
forbits me to use linux domains for serious things on E10Ks).

Luigi

> --
> M. Edward (Ed) Borasky, Borasky Research
> Relax! Run Your Own Brain with Neuro-Semantics!
> http://www.borasky-research.net/Flyer.htm
> mailto:znmeb@borasky-research.net
> http://groups.yahoo.com/group/pdx-neuro-semantics
>
> Q: How do you tell when a pineapple is ready to eat?
> A: It picks up its knife and fork.
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

