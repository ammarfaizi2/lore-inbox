Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289305AbSANXtY>; Mon, 14 Jan 2002 18:49:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289301AbSANXtO>; Mon, 14 Jan 2002 18:49:14 -0500
Received: from femail45.sdc1.sfba.home.com ([24.254.60.39]:7663 "EHLO
	femail45.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S289305AbSANXs4>; Mon, 14 Jan 2002 18:48:56 -0500
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
To: Robert Love <rml@tech9.net>, "J.A. Magallon" <jamagallon@able.es>
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
Date: Mon, 14 Jan 2002 10:46:52 -0500
X-Mailer: KMail [version 1.3.1]
Cc: Stephan von Krawczynski <skraw@ithnet.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, zippel@linux-m68k.org,
        ken@canit.se, arjan@fenrus.demon.nl, linux-kernel@vger.kernel.org
In-Reply-To: <200201140033.BAA04292@webserver.ithnet.com> <20020114160256.A2922@werewolf.able.es> <1011036915.4604.2.camel@phantasy>
In-Reply-To: <1011036915.4604.2.camel@phantasy>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020114234853.BLLD21559.femail45.sdc1.sfba.home.com@there>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 14 January 2002 02:35 pm, Robert Love wrote:
> On Mon, 2002-01-14 at 10:02, J.A. Magallon wrote:
> > Yup. That remind me of...
> > Would there be any kernel call every driver is doing just to hide there
> > a conditional_schedule() so everyone does it even without knowledge of it
> > ? Just like Apple put the SystemTask() inside GetNextEvent()...
>
> It's not nearly that easy.  If it were, we would all certainly switch to
> the preemptive kernel design, and preempt whenever and wherever we
> needed.
>
> Instead, we have to worry about reentrancy and thus can not preempt
> inside critical regions (denoted by spinlocks).  So we can't have
> preempt there, and have more work to do -- thus this discussion.
>
> 	Robert Love

The real question is: what can get in.

Variants of the explicit scheduling points have been around for over a year, 
since Ingo's original version.  Just a few days ago Marcello once again said 
that if all the patch does is add scheduling points, he had no intention of 
integrating it.  Linus's opinion on the matter has pretty much been about the 
same since Ingo's version.

If explicit scheduling points ARE a better first step than preempt (which 
doesn't necessarily elminate preempt, it just lets us move forward while 
arguing), when the heck might they possibly appear in a mainline kernel we 
don't have to manually patch each new release of?

Rob
