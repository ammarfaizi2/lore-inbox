Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130667AbQKLMYI>; Sun, 12 Nov 2000 07:24:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130648AbQKLMX6>; Sun, 12 Nov 2000 07:23:58 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:22884 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S129947AbQKLMXo>; Sun, 12 Nov 2000 07:23:44 -0500
Date: Sun, 12 Nov 2000 13:23:28 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Peter Samuelson <peter@cadcamlab.org>
Cc: Michael Meissner <meissner@spectacle-pond.org>,
        "Albert D. Cahalan" <acahalan@cs.uml.edu>,
        George Anzinger <george@mvista.com>,
        "linux-kernel@vger.redhat.com" <linux-kernel@vger.kernel.org>
Subject: Re: Where is it written?
Message-ID: <20001112132328.C2366@athlon.random>
In-Reply-To: <20001110184031.A2704@munchkin.spectacle-pond.org> <200011110011.eAB0BbF244111@saturn.cs.uml.edu> <20001110192751.A2766@munchkin.spectacle-pond.org> <20001111163204.B6367@inspiron.suse.de> <20001111171749.A32100@wire.cadcamlab.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20001111171749.A32100@wire.cadcamlab.org>; from peter@cadcamlab.org on Sat, Nov 11, 2000 at 05:17:49PM -0600
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 11, 2000 at 05:17:49PM -0600, Peter Samuelson wrote:
> I'd say go for it -- set up a mailing list and flesh out a better x86
> ABI. [..]

I think it doesn't worth to break binary compatilibity at this late stage.

> design such.)  One issue: ideally you want to use 64-bit regs on AMD
> Hammer for long longs, but then you leave out all legacy x68s. :(

We can't in compatibilty mode because the rex regs are available _only_ in
64bit mode and even assuming the hardware would support that I would not
recommend that since as you said that binary would not run anymore on any other
x86 so causing pain.  Recompiling a program with native x86-64 gcc 64bit (that
uses the 64bit ABI) is the right way to go in that case (64bit mode uses 1
64bit register for long long as all other 64bit architectures of course).

> AIUI gcc can cope OK with multiple ABIs to be chosen at runtime, am I
> right?  IRIX, HP-UX and AIX all have both 32-bit and 64-bit ABIs.

Yes as in other systems, 32bit mode and 64bit mode needs different ABI and they
will coexist in the same system.

Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
