Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262112AbRETRbN>; Sun, 20 May 2001 13:31:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262113AbRETRbD>; Sun, 20 May 2001 13:31:03 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:33050 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S262112AbRETRau>; Sun, 20 May 2001 13:30:50 -0400
Date: Sun, 20 May 2001 19:30:43 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: root <root@nospam.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.5pre2aa1 panic during boot
Message-ID: <20010520193043.B30738@athlon.random>
In-Reply-To: <3B07F7ED.7C22DAFD@nospam.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3B07F7ED.7C22DAFD@nospam.com>; from root@nospam.com on Mon, May 21, 2001 at 01:59:25AM +0900
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 21, 2001 at 01:59:25AM +0900, root wrote:
> Andrea told us that he will not care for anything
> compiled with gcc-2.95 or version lower than that.

I said I don't care about bugreport of alpha kernel crashes if the
_alpha_ kernel was compiled with gcc 2.95.*. 2.95 is fine on the x86,
but it's broken on the alpha. In short:

	x86 2.4 kernels		->	use 2.95.[34] or egcs 1.1.2 (I
					use 2.95.4 from the
					gcc_2_95_branch of CVS)
	alpha 2.4 kernel	->	use egcs 1.1.2 or 2.96 with some
					houndred of patches (I
					personally still use the egcs
					1.1.2)

> However, it seems that this kernel panic has anything
> to do with gcc-2.95.

Please try to reproduce with egcs 1.1.2 to be sure.

> Anyway, gcc-2.95 is still the official release of gcc.
> Even SuSE-7.1 has this version only.  I wish SuSE puts

x86 and alpha are completly different issues with regard to the
compiler. I never heard of problems with 2.95.4 on x86 and I would never
replace 2.95.4 from the gcc_2_95_branch for the latest 2.96 on my x86
boxes, I'd instead try again gcc 3.0 after the inline asm fixes for "+="
constranints on local variables are done.

Andrea
