Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265885AbTBLDcT>; Tue, 11 Feb 2003 22:32:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266041AbTBLDcT>; Tue, 11 Feb 2003 22:32:19 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:56077 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S265885AbTBLDcT>; Tue, 11 Feb 2003 22:32:19 -0500
Date: Tue, 11 Feb 2003 19:38:16 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Roland McGrath <roland@redhat.com>
cc: Daniel Jacobowitz <dan@debian.org>, Ingo Molnar <mingo@redhat.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: another subtle signals issue
In-Reply-To: <200302120323.h1C3NCA19787@magilla.sf.frob.com>
Message-ID: <Pine.LNX.4.44.0302111931190.3440-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 11 Feb 2003, Roland McGrath wrote:
> 
> There is no argument about this.  Dan and I are talking about real cases
> that are definitely specified by POSIX, and you have not responded about them.

First off, realize that 

 - POSIX is less relevant than "what the 2.4.x" do. MUCH less. Binary 
   compatibility is very important, much more so than some paper standard.

 - and even if you care 100% about POSIX, that still leaves the fact that 
   everybody who has ever implemented POSIX also did their "this is how we
   differ" exception lists. It's part of the process. 

With that out of the way, I think I _did_ respond about them: ^Z _will_
cause interruptible system calls to return EINTR/ERESTARTNOHAND or one of
the versions thereof. There are no ifs, buts and maybes about it. It will
happen. It's very fundamental to how Linux signal handling and job control
has always worked, and it's not even worth worrying about it (see above on
_why_ it's not worth worrying about).

		Linus

