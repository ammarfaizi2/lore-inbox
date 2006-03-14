Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752064AbWCNKLF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752064AbWCNKLF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 05:11:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752070AbWCNKLF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 05:11:05 -0500
Received: from mail05.syd.optusnet.com.au ([211.29.132.186]:29121 "EHLO
	mail05.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1752064AbWCNKLE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 05:11:04 -0500
From: Con Kolivas <kernel@kolivas.org>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: [2.6.16-rc6 patch] remove sleep_avg multiplier
Date: Tue, 14 Mar 2006 21:10:36 +1100
User-Agent: KMail/1.9.1
Cc: Mike Galbraith <efault@gmx.de>, lkml <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
References: <1142329861.9710.16.camel@homer> <20060314095654.GA8756@elte.hu> <200603142105.38225.kernel@kolivas.org>
In-Reply-To: <200603142105.38225.kernel@kolivas.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603142110.37017.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 14 March 2006 21:05, Con Kolivas wrote:
> On Tuesday 14 March 2006 20:56, Ingo Molnar wrote:
> > * Mike Galbraith <efault@gmx.de> wrote:
> > > Greetings,
> > >
> > > The patchlet below removes the sleep_avg multiplier.  This multiplier
> > > was necessary back when we had 10 seconds of dynamic range in
> > > sleep_avg, but now that we only have one second, it causes that one
> > > second to be compressed down to 100ms in some cases.  This is
> > > particularly noticeable when compiling a kernel in a slow NFS mount,
> > > and I believe it to be a very likely candidate for other recently
> > > reported network related interactivity problems.
> > >
> > > In testing, I can detect no negative impact of this removal.  IMHO,
> > > this constitutes a bug-fix, and as such is suitable for 2.6.16.
> >
> > looks good to me. The biggest complaint against the current scheduler is
> > over-eager interactivity boosting - this patch moderates that in a
> > smooth way.
>
> I actually think Mike is right about the change, but has anyone else tested
> this patch to also confirm "it has no negative impact" warranting it's
> rapid inclusion in 2.6.16?

/me smacks himself for misusing "it's"

How about an interbench run before and after Mike?

Cheers,
Con
