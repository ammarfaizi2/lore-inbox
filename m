Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315358AbSFON1U>; Sat, 15 Jun 2002 09:27:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315370AbSFON1T>; Sat, 15 Jun 2002 09:27:19 -0400
Received: from pizda.ninka.net ([216.101.162.242]:12675 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S315358AbSFON1T>;
	Sat, 15 Jun 2002 09:27:19 -0400
Date: Sat, 15 Jun 2002 06:22:33 -0700 (PDT)
Message-Id: <20020615.062233.123620674.davem@redhat.com>
To: rml@mvista.com
Cc: alan@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.4-ac: sparc64 support for O(1) scheduler
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <1024075953.4799.224.camel@sinai>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Robert Love <rml@mvista.com>
   Date: 14 Jun 2002 10:32:32 -0700
   
   I am explicitly refraining from sending Alan any code that is not
   well-tested in 2.5 and my machines first.  As Ingo's new switch_mm()
   bits are not even in 2.5 yet, I plan to wait a bit before sending
   them... (I am currently putting together all the scheduler bits we have
   been working on for a 2.4-ac patch...)

Your sparc64 kernel/sched.c bits have zero testing in any kernel.
What point are you trying to make?  It disables a very important
optimization on SMP sparc64.  It's simply unacceptable.

Ingo's change which deletes the frozen locking bits has to be
installed with the patches which allow sparc64 to continue working
without the deadlock bug, they cannot be added seperately.
