Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261578AbVBHQ63@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261578AbVBHQ63 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Feb 2005 11:58:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261590AbVBHQ61
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Feb 2005 11:58:27 -0500
Received: from mx1.elte.hu ([157.181.1.137]:17822 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261578AbVBHQ4m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Feb 2005 11:56:42 -0500
Date: Tue, 8 Feb 2005 17:56:34 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Julien TINNES <julien.tinnes@francetelecom.com>
Cc: linux-kernel@vger.kernel.org, Arjan van de Ven <arjanv@redhat.com>,
       "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: Sabotaged PaXtest (was: Re: Patch 4/6  randomize the stack pointer)
Message-ID: <20050208165634.GB9903@elte.hu>
References: <42080689.15768.1B0C5E5F@localhost> <42093CC7.5086.1FC83D3E@localhost> <20050208134156.GA5017@elte.hu> <4208CBDA.5010903@francetelecom.REMOVE.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4208CBDA.5010903@francetelecom.REMOVE.com>
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


* Julien TINNES <julien.tinnes.NOSPAM@francetelecom.REMOVE.com> wrote:

> But if you consider code injection as in your previous post:
> 
> >btw., do you consider PaX as a 100% sure solution against 'code
> >injection' attacks (meaning that the attacker wants to execute an
> >arbitrary piece of code, and assuming the attacked application has a
> >stack overflow)? I.e. does PaX avoid all such attacks in a guaranteed
> >way?
> 
> then the answer to your question is no because a stack overflow
> usually allows two things: injection of new code, and execution flow
> redirection. While the former is prevented, the later is not and the
> attacker could use chaining techniques as in [1] to execute "arbitrary
> code" (but not directly as an arbitrary, newly injected sequence of
> opcodes). Address space obfuscation (address space layout
> randomization is one way) is making it harder (but not impossible,
> esp. if you don't have anything preventing the attacker from
> bruteforcing...) to use existing code.

precisely my point (see my previous, very long post).

obviously it's not us who defines what 'code injection' is but the laws
of physics and the laws of computer science. Restricting to the native
CPU's machine code format may cover an important special-case, but it
will prevent arbitrary code execution just as much as a house that has a
locked door but an open window, where the owner defines "burglary" as
"the bad guy tries to open the door". Correct in a sense, but not secure
in guaranteed way :-|

	Ingo
