Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751137AbWF1Txc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751137AbWF1Txc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 15:53:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751141AbWF1Txb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 15:53:31 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:7081 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751137AbWF1Txb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 15:53:31 -0400
Date: Wed, 28 Jun 2006 21:53:16 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Sebastian =?iso-8859-1?Q?K=FCgler?= <sebas@kde.org>
Cc: suspend2-devel@lists.suspend2.net,
       Andreas Mohr <andi@rhlx01.fht-esslingen.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Nigel Cunningham <ncunningham@linuxmail.org>
Subject: Re: swsusp / suspend2 reliability (was Re: [Suspend2-devel] Re: Suspend2 - Request for review & inclusion in	-mm)
Message-ID: <20060628195316.GB18039@elf.ucw.cz>
References: <200606270147.16501.ncunningham@linuxmail.org> <200606280039.06296.sebas@kde.org> <20060627225105.GC8642@elf.ucw.cz> <200606280118.23270.sebas@kde.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200606280118.23270.sebas@kde.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2006-06-28 01:18:10, Sebastian Kügler wrote:
> On Wednesday 28 June 2006 00:51, Pavel Machek wrote:
> > On Wed 2006-06-28 00:38:59, Sebastian Kügler wrote:
> > > On Wednesday 28 June 2006 00:22, Pavel Machek wrote:
> > > > I do not think suspend2 works on more machines than in-kernel
> > > > swsusp. Problems are in drivers, and drivers are shared.
> > > >
> > > > That means that if you have machine where suspend2 works and swsusp
> > > > does not, please tell me. I do not think there are many of them.
> > >
> > > Maybe not machines, but definitely usage scenarios. I've tried both
> > > implementations lately, and swsusp would often -- especially under high
> > > memory load -- just return from trying, while suspend2 succeeds in
> > > freeing enough memory to be able to suspend _every_ time.
> >
> > Refrigerator fixes should help with this one. Does it still happen in
> > 2.6.17?
> 
> Last release I tested was 2.6.17-rc6-git7.
> 
> > > Is that something uswsusp is likely to change anytime soon?
> >
> > Actually this is common code for both swsusp and uswsusp; yes this
> > should be fixed.
> 
> In the above mentioned release it definitely is not fixed.

Okay, can I get some details? Like how much memory does system have,
what stress test causes the failure?
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
