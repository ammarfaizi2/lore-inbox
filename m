Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261256AbUKBPLA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261256AbUKBPLA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 10:11:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261817AbUKBO6m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 09:58:42 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:24244 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S262137AbUKBOyY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 09:54:24 -0500
Subject: Re: [PATCH] [CPU-HOTPLUG] convert cpucontrol to be a rwsem
From: Lee Revell <rlrevell@joe-job.com>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Zwane Mwaikambo <zwane@linuxpower.ca>,
       Dominik Brodowski <linux@dominikbrodowski.de>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1099352903.20402.2.camel@localhost.localdomain>
References: <20041101084337.GA7824@dominikbrodowski.de>
	 <Pine.LNX.4.61.0411010656380.19123@musoma.fsmlabs.com>
	 <1099332277.3647.43.camel@krustophenia.net>
	 <1099352903.20402.2.camel@localhost.localdomain>
Content-Type: text/plain
Date: Tue, 02 Nov 2004 09:54:22 -0500
Message-Id: <1099407263.1563.4.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-11-02 at 10:48 +1100, Rusty Russell wrote:
> On Mon, 2004-11-01 at 13:04 -0500, Lee Revell wrote:
> > On Mon, 2004-11-01 at 07:00 -0700, Zwane Mwaikambo wrote:
> > > Agreed it makes a lot more sense, i think there could be some places where 
> > > we use preempt_disable to protect against cpu offline which could 
> > > converted, but that can come later.
> > > 
> > 
> > You know I picked up Robert Love's book the other day and was surprised
> > to read we are not supposed to be using preempt_disable, there is a
> > per_cpu interface for exactly this kind of thing.  Which is currently
> > recommended?
> 
> get_cpu() both ensures that this CPU won't go down, and ensures we won't
> get scheduled off it.  It returns the current processor ID, as well.
> put_cpu() puts the CPU back.
> 
> In my experience it's usually clearer than preempt_disable().

To answer Zwane's earlier question, Love's book covers this on page 136,
then all of Appendix B.  I also completely missed this the first time...

Lee

