Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751471AbWI3WZF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751471AbWI3WZF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Sep 2006 18:25:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751473AbWI3WZF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Sep 2006 18:25:05 -0400
Received: from mx1.suse.de ([195.135.220.2]:51871 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751471AbWI3WZA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Sep 2006 18:25:00 -0400
From: Andi Kleen <ak@suse.de>
To: "Eric Rannaud" <eric.rannaud@gmail.com>
Subject: Re: BUG-lockdep and freeze (was: Arrr! Linux 2.6.18) II
Date: Sun, 1 Oct 2006 00:24:53 +0200
User-Agent: KMail/1.9.3
Cc: "Linus Torvalds" <torvalds@osdl.org>, "Ingo Molnar" <mingo@elte.hu>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       "Andrew Morton" <akpm@osdl.org>, nagar@watson.ibm.com,
       "Chandra Seetharaman" <sekharan@us.ibm.com>,
       "Jan Beulich" <jbeulich@novell.com>
References: <5f3c152b0609301220p7a487c7dw456d007298578cd7@mail.gmail.com> <200610010009.30123.ak@suse.de> <5f3c152b0609301519p42250850ufe02a79364249622@mail.gmail.com>
In-Reply-To: <5f3c152b0609301519p42250850ufe02a79364249622@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610010024.53854.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 01 October 2006 00:19, Eric Rannaud wrote:
> On 10/1/06, Andi Kleen <ak@suse.de> wrote:
> > I double checked this now. This case Eric ran into should be already
> > fixed by a patch from Jan that went in before 2.6.18 even.
> >
> > He just ran with an old kernel (2.6.18-rc3) that didn't have
> > that particular fix.
> 
> Hmm, not sure I'm following you, but I did try with the released
> v2.6.18 (fourth stacktrace in my first email in this thread). The
> 2.6.13-rc3 (d94a041519f3ab1ac023bf917619cd8c4a7d3c01) version was
> tested only as the result of git-bisect, and is the first kernel that
> crashed in this way. But v2.6.18 crashed in a similar way as well.
> Are you saying v2.6.18 should contain a fix preventing it from crashing?

2.6.18 should have showed the backtrace from lockdep, but not the oops at 
the end of the backtrace in show_trace()

-Andi
