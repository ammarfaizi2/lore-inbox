Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290491AbSAQWQO>; Thu, 17 Jan 2002 17:16:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290492AbSAQWPy>; Thu, 17 Jan 2002 17:15:54 -0500
Received: from extmail01.raleigh.ibm.com ([204.146.167.242]:2220 "EHLO
	extmail01m.raleigh.ibm.com") by vger.kernel.org with ESMTP
	id <S290488AbSAQWPo>; Thu, 17 Jan 2002 17:15:44 -0500
Message-ID: <3C474BFE.885AD719@uk.ibm.com>
Date: Thu, 17 Jan 2002 22:11:10 +0000
From: Christopher Turcksin <turcksin@raleigh.ibm.com>
Organization: IBM Global Services
X-Mailer: Mozilla 4.75 [en] (Windows NT 5.0; U)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH] Re: 2.5.3-pre1 compile error
In-Reply-To: <20020115194316.I17477@redhat.com> <Pine.LNX.4.33.0201151644180.1213-100000@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:

> > Well, I actually disagree on this.  For large include files (fs.h is the
> > worst), and complicated arrangement, this technique eliminates spurious
> > includes and saves a lot on compile time (really!).
> 
> Numbers please.

The GNU C preprocessor remembers if an include file was completely
inside an #ifndef/#endif conditional (modulo whitespace and comments)
and will skip the #include for the same file if the macro in #ifndef is
already defined. I suspect putting guards around the include will not
save any more time.

bfn,
Christopher Turcksin <turcksin@uk.ibm.com>

IBM Global Services
