Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267645AbUJOKxQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267645AbUJOKxQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Oct 2004 06:53:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267625AbUJOKxP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Oct 2004 06:53:15 -0400
Received: from boromix.nask.net.pl ([195.187.245.33]:2280 "EHLO
	boromix.nask.net.pl") by vger.kernel.org with ESMTP id S267645AbUJOKxM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Oct 2004 06:53:12 -0400
Date: Fri, 15 Oct 2004 12:52:29 +0200 (CEST)
From: Mateusz.Blaszczyk@nask.pl
X-X-Sender: mat@boromir
Reply-To: Mateusz.Blaszczyk@nask.pl
To: Ingo Molnar <mingo@elte.hu>
cc: rml@tech9.net, linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       William Lee Irwin III <wli@holomorphy.com>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [patch, 2.6.9-rc4-mm1] fix oops in sched_setscheduler
In-Reply-To: <20041015090336.GA14362@elte.hu>
Message-ID: <Pine.GSO.4.58.0410151251150.5009@boromir>
References: <Pine.GSO.4.58.0410150833330.9897@boromir> <20041015090336.GA14362@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-2
Content-Transfer-Encoding: 8BIT
VirusProtection: checked - Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Oct 2004, Ingo Molnar wrote:

>
> * Mateusz.Blaszczyk@nask.pl <Mateusz.Blaszczyk@nask.pl> wrote:
>
> > Running cdrecord caused oops in sched_setscheduler syscall (i think)
> > so i tested with my little setp.c program that follows. It seems that
> > it always oops - no matter what policy I request. It runs ok on
> > 2.6.9-rc2-mm1, same config. Rc3 not tested. I run setp. 3 times. The
> > first I decoded using ksymoops. My .config follows at the end.
>
> the crash happens if 1) someone doesnt have profiling enabled 2) uses an
> UP kernel and 3) does setscheduler. The patch below fixes 3 problems:
> finishes and fixes the consolidation and fixes the profile=schedule
> feature. Against 2.6.9-rc4-mm1. Tested.

tested, works.

-mat

-- 
Pozdrowienia,Regards,Cheers,Grüße,A plus!,
