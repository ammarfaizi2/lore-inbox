Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272589AbTHKNop (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 09:44:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272578AbTHKNoB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 09:44:01 -0400
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:33753
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S272585AbTHKNjY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 09:39:24 -0400
From: Rob Landley <rob@landley.net>
Reply-To: rob@landley.net
To: Nick Piggin <piggin@cyberone.com.au>, Con Kolivas <kernel@kolivas.org>
Subject: Re: [PATCH] O13int for interactivity
Date: Mon, 11 Aug 2003 02:48:09 -0400
User-Agent: KMail/1.5
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
References: <200308050207.18096.kernel@kolivas.org> <200308052022.01377.kernel@kolivas.org> <3F2F87DA.7040103@cyberone.com.au>
In-Reply-To: <3F2F87DA.7040103@cyberone.com.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308110248.09399.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 05 August 2003 06:32, Nick Piggin wrote:

> But by employing the kernel's services in the shape of a blocking
> syscall, all sleeps are intentional.

Wrong.  Some sleeps indicate "I have run out of stuff to do right now, I'm 
going to wait for a timer or another process or something to wake me up with 
new work".

Some sleeps indicate "ideally this would run on an enormous ramdisk attached 
to gigabit ethernet, but hard drives and internet connections are just too 
slow so my true CPU-hogness is hidden by the fact I'm running on a PC instead 
of a mainframe."

There is are "I have nothing to do right now, and I'm okay with that" sleeps, 
and there are "I have requested more work, and it should hurry up and get 
here" sleeps.

Rob
