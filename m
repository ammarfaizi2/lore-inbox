Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261243AbUKWN7x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261243AbUKWN7x (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 08:59:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261252AbUKWN7x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 08:59:53 -0500
Received: from 41-052.adsl.zetnet.co.uk ([194.247.41.52]:47634 "EHLO
	mail.esperi.org.uk") by vger.kernel.org with ESMTP id S261243AbUKWN7r
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 08:59:47 -0500
To: Duncan Sands <duncan.sands@math.u-psud.fr>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       Mitchell Blank Jr <mitch@sfgoth.com>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>
Subject: Re: sparse segfaults
References: <20041120143755.E13550@flint.arm.linux.org.uk>
	<20041122183956.GA50325@gaz.sfgoth.com>
	<Pine.LNX.4.58.0411221047140.20993@ppc970.osdl.org>
	<200411222130.46247.duncan.sands@math.u-psud.fr>
From: Nix <nix@esperi.org.uk>
X-Emacs: Lovecraft was an optimist.
Date: Tue, 23 Nov 2004 13:59:19 +0000
In-Reply-To: <200411222130.46247.duncan.sands@math.u-psud.fr> (Duncan
 Sands's message of "22 Nov 2004 20:53:34 -0000")
Message-ID: <87y8gswts8.fsf@amaterasu.srvr.nix>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 22 Nov 2004, Duncan Sands mused:
> Generalized lvalues have been removed.  Check out
> http://gcc.gnu.org/ml/gcc/2004-11/msg00604.html

There is talk of putting a subset of them back again, because a *lot* of
code does things like

((foo_t *)foo)++;

and the generalized lvalues extension makes that work as expected. Yes,
all such code is technically broken, but a large number of non-GCC
compilers also implement the extension enough for the construct above to
be valid.


Where it's really bad is in C++, where it can change the semantics of
some otherwise-valid code (due to the way it interacts with function
overloading). The whole generalized lvalues extension is definitely not
coming back, because fixing that C++ bug was a major reason why it was
removed in the first place.

-- 
`The sword we forged has turned upon us
 Only now, at the end of all things do we see
 The lamp-bearer dies; only the lamp burns on.'
