Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261709AbREVNqv>; Tue, 22 May 2001 09:46:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261715AbREVNqk>; Tue, 22 May 2001 09:46:40 -0400
Received: from t2.redhat.com ([199.183.24.243]:13041 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S261709AbREVNq2>; Tue, 22 May 2001 09:46:28 -0400
X-Mailer: exmh version 2.3 01/15/2001 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <15113.31946.548249.53012@gargle.gargle.HOWL> 
In-Reply-To: <15113.31946.548249.53012@gargle.gargle.HOWL>  <20010520165952.A9622@devserv.devel.redhat.com> <20010518113726.A29617@devserv.devel.redhat.com> <20010518114922.C14309@thyrsus.com> <8485.990357599@redhat.com> <20010520111856.C3431@thyrsus.com> <15823.990372866@redhat.com> <20010520114411.A3600@thyrsus.com> <16267.990374170@redhat.com> <20010520131457.A3769@thyrsus.com> <18686.990380851@redhat.com> <20010520164700.H4488@thyrsus.com> <25499.990399116@redhat.com> 
To: John Stoffel <stoffel@casc.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Background to the argument about CML2 design philosophy 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 22 May 2001 14:45:53 +0100
Message-ID: <7938.990539153@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


stoffel@casc.com said:
> David> for the sake of the sanity of all concerned, do things one at a
> David> time. Provide for merging into 2.5 a set of rules which 
> David> reproduce the existing CML1 behaviour in this respect.

> Can you define what you mean here?  It's not really clear to me, and I
> suspect others.  

You appear to be responding to my email, yet you did not do me the courtesy 
of including me in the recipients. Should I assume you're asking this 
question of me directly, or was it a rhetorical question?

stoffel@casc.com said:
> I don't think he is introducing new modes, he's just trying to make
> sure that you can't create a .config which is broken. 

Good. You should be prevented from creating a .config which is broken, and 
the existing CML1 rules attempt to achieve this. CML2 should continue to do 
so, and indeed should do so more effectively and flexibly.

> - fear that CML2 won't let them make crazy configurations, such as an
>   8-way SMP box with ISA.  Can't see how CML2 would restrict this
>   choice myself.

I do not fear that CML2 itself will prevent these 'crazy' configurations.
That is why I said that the issue is entirely orthogonal to CML2.

However, it would obviously be possible to introduce new dependencies to the
rules files -- either CML1 or CML2 -- which do prevent such configurations.

What I fear is that such new, unwanted, dependencies may be introduced to
the kernel -- either by accident or by deception -- in the large patch which
introduces CML2 and converts the existing rules files. Subtle changes to 
the behaviour could easily go unnoticed in such a large patch.

I am asking that such a deception should not be attempted. The CML2 rules
introduced to 2.5.n should exactly represent the behaviour of the CML1 rules
in 2.5.(n-1). Changes to the policy represented within the rules files can
then be presented afterwards, and should be considered entirely separate to
the change in mechanism.

stoffel@casc.com said:
> If you run into a case where you have a config which would work, but
> CML2 doesn't let you, why don't you fix the grammar instead of saying
> CML2 is wrong? 

I think you are being overly defensive. I was not saying that CML2 is 
wrong. I said that I was ambivalent about CML2, and the point I'm talking 
about is entirely irrelevant to CML2 - except that I'm trying to make sure 
that the large CML2 patch is not used as a vehicle for sneaking other, more 
contentious, changes into the kernel. 

I want to discuss those changes _separately_ once the CML2 issue is
out of the way, because otherwise people just won't bother to read what I
said, and will assume I'm arguing against CML2 itself.

--
dwmw2


