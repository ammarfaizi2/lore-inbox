Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268679AbUJDVud@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268679AbUJDVud (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Oct 2004 17:50:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268677AbUJDVsv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Oct 2004 17:48:51 -0400
Received: from mx2.elte.hu ([157.181.151.9]:24301 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S268533AbUJDVrQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Oct 2004 17:47:16 -0400
Date: Mon, 4 Oct 2004 23:48:55 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: annabellesgarden@yahoo.de, linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc3-mm2
Message-ID: <20041004214855.GA19748@elte.hu>
References: <200410041634.24937.annabellesgarden@yahoo.de> <20041004122304.4f545f3c.akpm@osdl.org> <20041004122533.0a85a1ad.akpm@osdl.org> <20041004212633.GA13527@elte.hu> <20041004143738.5ca9c43f.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041004143738.5ca9c43f.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andrew Morton <akpm@osdl.org> wrote:

> Ingo Molnar <mingo@elte.hu> wrote:
> >
> > Must not put side-effects into a macro that is NOP on
> > !SMP.
> 
> This one, too:
> 
> -		per_cpu(ip_conntrack_stat, get_cpu()).count++;	\
> -		put_cpu();					\

btw., also remove or fix the get_cpu_ptr() definition in percpu.h, it's
buggy for the same reason, but fortunately unused.

	Ingo
