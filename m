Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267432AbTACClX>; Thu, 2 Jan 2003 21:41:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267433AbTACClX>; Thu, 2 Jan 2003 21:41:23 -0500
Received: from pizda.ninka.net ([216.101.162.242]:11457 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S267432AbTACClW>;
	Thu, 2 Jan 2003 21:41:22 -0500
Date: Thu, 02 Jan 2003 18:42:14 -0800 (PST)
Message-Id: <20030102.184214.32718859.davem@redhat.com>
To: tom@rhadamanthys.org
Cc: linux-kernel@vger.kernel.org, lm@bitmover.com
Subject: Re: [PATCH] TCP Zero Copy for mmapped files
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20030103004543.GA12399@window.dhis.org>
References: <20030102221210.GA7704@window.dhis.org>
	<20030102.151346.113640740.davem@redhat.com>
	<20030103004543.GA12399@window.dhis.org>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Thomas Ogrisegg <tom@rhadamanthys.org>
   Date: Fri, 3 Jan 2003 01:45:43 +0100

   > This isn't a priority for us.  People who want the best possible
   > performance can code their apps up to take advantage of sendfile()
   > on systems that have it.
   
   So you want to chain people to your "propritaery solution"?
   
I don't hide my APIs.

   > (and really, show me how many systems
   > lack a sendfile mechanism these days).
   
   What kind of systems are you talking about? Operating systems?
   Nearly all.
   
HPUX has it, Solaris has it, Microsoft has something very similar,
FreeBSD has it as does I believe NetBSD.  Show me the exceptions.

   It might be a bit difficult to convert all applications to
   sendfile. Especially those for which you don't have the
   source code.
   
If the performance really must be top notch, someone will invest
the time for a given application.  Otherwise, if it's not that
important enough to port why should it be important enough to put
a hack into the OS for it?

   I don't see your point. Applications which really need the
   performance will switch to sendfile anyway because of the
   problems with mmap, you mentioned.
   
Right, so why bother with your patch?

   My patch is very simple and takes less than 1KB of code but
   will speed up many applications and doesn't have a real
   drawback (except when sending "normal" data which is larger
   than a page - but that shouldn't happen very often).
   
What about the extra checks you are placing in a fast path?
