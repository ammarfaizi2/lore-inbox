Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290599AbSA3VFV>; Wed, 30 Jan 2002 16:05:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290598AbSA3VFC>; Wed, 30 Jan 2002 16:05:02 -0500
Received: from femail28.sdc1.sfba.home.com ([24.254.60.18]:43471 "EHLO
	femail28.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S290597AbSA3VEn>; Wed, 30 Jan 2002 16:04:43 -0500
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
To: m.knoblauch@teraport.de, Martin Knoblauch <Martin.Knoblauch@teraport.de>,
        jfv@trane.bluesong.net
Subject: Re: [PATCH]: O(1) 2.4.17-J7 Tuneable Parameters
Date: Wed, 30 Jan 2002 16:05:53 -0500
X-Mailer: KMail [version 1.3.1]
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <3C57F347.26527F73@TeraPort.de>
In-Reply-To: <3C57F347.26527F73@TeraPort.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020130210442.EYN1833.femail28.sdc1.sfba.home.com@there>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 30 January 2002 08:21 am, Martin Knoblauch wrote:
> > [PATCH]: O(1) 2.4.17-J7 Tuneable Parameters
> >
> >
> > Hi Ingo,
> >
> >         This patch synchronizes with J7 and I think makes the changes
> > you wished. A couple of important points:
> >
> >                 - This patch can be applied to EITHER 2.4.17 OR 2.4.18
> > pre 7 as long as Ingo's J7 patch is applied first.
> >
> >                 - While I agree with you on not wanting these in the
> > mainline kernel, I ran Hackbench on one of our new Foster systems with
> > and without the tuneable parameters, and while the numbers do degrade
> > slightly, its rather suprisingly small. So dont be afraid to use this as
> > a system tuning aid.
>
>  How big is the actual degradation in your test? IIR, Ingo is afraid
> that the tunables could easily screw things up, which of course is true.
> What about adding a kernel-build option that leaves the sysctl interface
> read-only by default and enables writing only if it is requested at
> build time?

Nah, as long as the permissions say only root can write to it, you're pretty 
much covered.  (It's certainly no worse than root going cat /dev/zero > 
/dev/hda...)

Rob
