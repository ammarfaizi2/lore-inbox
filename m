Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S932209AbWFDKRS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932209AbWFDKRS (ORCPT <rfc822;akpm@zip.com.au>);
	Sun, 4 Jun 2006 06:17:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932211AbWFDKRS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jun 2006 06:17:18 -0400
Received: from a222036.upc-a.chello.nl ([62.163.222.36]:1214 "EHLO
	laptopd505.fenrus.org") by vger.kernel.org with ESMTP
	id S932209AbWFDKRR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jun 2006 06:17:17 -0400
Subject: Re: [patch, -rc5-mm3] lock validator: fix ns83820.c irq-flags part
	3
From: Arjan van de Ven <arjan@linux.intel.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: "Barry K. Nathan" <barryn@pobox.com>, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@osdl.org>
In-Reply-To: <20060604101136.GA14693@elte.hu>
References: <20060604083017.GA8241@elte.hu>
	 <1149411525.3109.73.camel@laptopd505.fenrus.org>
	 <986ed62e0606040253pfe9c300qf88029f88ae65039@mail.gmail.com>
	 <1149415707.3109.96.camel@laptopd505.fenrus.org>
	 <20060604101136.GA14693@elte.hu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sun, 04 Jun 2006 12:16:53 +0200
Message-Id: <1149416213.3109.98.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-06-04 at 12:11 +0200, Ingo Molnar wrote:
> * Arjan van de Ven <arjan@linux.intel.com> wrote:
> 
> > On Sun, 2006-06-04 at 02:53 -0700, Barry K. Nathan wrote:
> > > On 6/4/06, Arjan van de Ven <arjan@linux.intel.com> wrote:
> > > > just the preempt the next email from Barry; while fixing this one I
> > > > looked at the usage of the locks more and found another patch needed...
> > > [snip]
> > > 
> > > Nice try, but it didn't work. ~_^
> > > 
> > > I was about to reply to the previous ns83820 patch with my dmesg, when
> > > I saw this one. I applied this patch too, and like the previous patch,
> > > it reports an instance of illegal lock usage. My dmesg follows.
> > > -- 
> > 
> > ok this is a real driver deadlock:
> 
> preexisting bug, right? So this fix should go into 2.6.16/17 too, 
> correct?

yes; this is real driver deadlock that has been there for quite some
time
