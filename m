Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293510AbSC2S0F>; Fri, 29 Mar 2002 13:26:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293680AbSC2SZz>; Fri, 29 Mar 2002 13:25:55 -0500
Received: from deimos.hpl.hp.com ([192.6.19.190]:17125 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S293245AbSC2SZi>;
	Fri, 29 Mar 2002 13:25:38 -0500
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15524.45472.231096.377756@napali.hpl.hp.com>
Date: Fri, 29 Mar 2002 10:25:36 -0800
To: arjan@fenrus.demon.nl
Cc: davidm@hpl.hp.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] generic show_stack facility
In-Reply-To: <200203291716.g2THGNq08251@fenrus.demon.nl>
X-Mailer: VM 7.01 under Emacs 21.1.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Fri, 29 Mar 2002 17:16:23 GMT, arjan@fenrus.demon.nl said:

  >> BTW: this is not at all an ia64-specific issue.  It applies to
  >> any arch that doesn't maintain a frame pointer on the stack.
  >> Basic compiler technology.

  Arjan> oh you mean like x86 ?

As far as I know, the x86 version of show_trace() still relies on the
fact that (a) return addresses are stored on the memory stack, (b)
they are stored in the order in which the routines were called, and
(c) that there aren't too many other values on the stack that look
like kernel text addresses.  As long as an x86 compiler uses the CALL
instruction, that should be the case.  But this certainly isn't the
case for all architectures (though I do agree that it is a heuristic
should work reasonably well for several architectures).

	--david
