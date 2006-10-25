Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932277AbWJYTxM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932277AbWJYTxM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Oct 2006 15:53:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932278AbWJYTxL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Oct 2006 15:53:11 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:44197 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S932277AbWJYTxK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Oct 2006 15:53:10 -0400
Subject: Re: oprofile can cause an NMI to schedule (was: [RT] scheduling
	and oprofile)
From: Lee Revell <rlrevell@joe-job.com>
To: Mike Kravetz <kravetz@us.ibm.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, John Levon <levon@movementarian.org>,
       phil.el@wanadoo.fr, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org, oprofile-list@lists.sourceforge.net,
       george@mvista.com
In-Reply-To: <20061025185813.GA4114@monkey.ibm.com>
References: <20061023212307.GA21498@monkey.beaverton.ibm.com>
	 <1161656674.13276.17.camel@localhost.localdomain>
	 <20061024124650.GA2668@totally.trollied.org>
	 <Pine.LNX.4.58.0610240852450.949@gandalf.stny.rr.com>
	 <20061025185813.GA4114@monkey.ibm.com>
Content-Type: text/plain
Date: Wed, 25 Oct 2006 15:52:59 -0400
Message-Id: <1161805980.3982.319.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-10-25 at 11:58 -0700, Mike Kravetz wrote:
> Newer RT kernels (such as linux-2.6.18-rt5) have reenabled the
> add_preempt_count/sub_preempt_count calls in nmi_enter/exit.  If I
> understand correctly the reason one could not modify the preempt_count
> from NMI code is that it could have been in the process of being
> modified by non-NMI code.  But, in recent RT kernels it appears that
> preempt_count is still a single word modified by both NMI and
> non-NMI code.  What am I missing that now makes this safe?
> 

It's not safe.  NMI causes hard lockups on 2.6.18-rt5.  Get 2.6.18-rt7.

Lee

