Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261530AbVBHNmS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261530AbVBHNmS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Feb 2005 08:42:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261531AbVBHNmS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Feb 2005 08:42:18 -0500
Received: from mx1.elte.hu ([157.181.1.137]:6863 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261530AbVBHNmO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Feb 2005 08:42:14 -0500
Date: Tue, 8 Feb 2005 14:41:56 +0100
From: Ingo Molnar <mingo@elte.hu>
To: pageexec@freemail.hu
Cc: linux-kernel@vger.kernel.org, Arjan van de Ven <arjanv@redhat.com>,
       "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: Sabotaged PaXtest (was: Re: Patch 4/6  randomize the stack pointer)
Message-ID: <20050208134156.GA5017@elte.hu>
References: <42080689.15768.1B0C5E5F@localhost> <42093CC7.5086.1FC83D3E@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42093CC7.5086.1FC83D3E@localhost>
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


* pageexec@freemail.hu <pageexec@freemail.hu> wrote:

> > btw., do you consider PaX as a 100% sure solution against 'code
> > injection' attacks (meaning that the attacker wants to execute an
> > arbitrary piece of code, and assuming the attacked application has a
> > stack overflow)? I.e. does PaX avoid all such attacks in a guaranteed
> > way?
> 
> your question is answered in http://pax.grsecurity.net/docs/pax.txt
> that i suggested you to read over a year ago. the short answer is that
> it's not only about stack overflows but any kind of memory corruption
> bugs, and you need both a properly configured kernel (for PaX/i386
> that would be SEGMEXEC/MPROTECT/NOELFRELOCS) and an access control
> system (to take care of the file system and file mappings) and a
> properly prepared userland (e.g., no text relocations in ELF
> executables/libs, which is a good thing anyway).

i'm just curious, assuming that all those conditions are true, do you
consider PaX a 100% sure solution against 'code injection' attacks?
(assuming that the above PaX and access-control feature implementations
are correct.) Do you think the upstream kernel could/should integrate it
as a solution against code injection attacks?

	Ingo
