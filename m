Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284627AbRLDAU4>; Mon, 3 Dec 2001 19:20:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284807AbRLDAQ7>; Mon, 3 Dec 2001 19:16:59 -0500
Received: from RAVEL.CODA.CS.CMU.EDU ([128.2.222.215]:54245 "EHLO
	ravel.coda.cs.cmu.edu") by vger.kernel.org with ESMTP
	id <S285141AbRLCU6b>; Mon, 3 Dec 2001 15:58:31 -0500
Date: Mon, 3 Dec 2001 15:58:06 -0500
To: Pavel Machek <pavel@suse.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: ENTRY macro (coda maintainers please listen)
Message-ID: <20011203155805.A7057@cs.cmu.edu>
Mail-Followup-To: Pavel Machek <pavel@suse.cz>,
	kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20011202215232.A1751@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011202215232.A1751@elf.ucw.cz>
User-Agent: Mutt/1.3.23i
From: Jan Harkes <jaharkes@cs.cmu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 02, 2001 at 09:52:32PM +0100, Pavel Machek wrote:
> linux/linkage.h includes macro "ENTRY(a)", while linux/coda_linux
> includes ... macro "ENTRY".

That could lead to a possible problem. We're just lucky that no file in
the Coda code has __ASSEMBLY__ defined.

> It would be good to rename one of them (they are probably not needed
> in one module, anyway, that's not clean)...

Actually all coda_XXX.h files don't even have to be in include/linux/,
only coda.h contains structs/defines that should be 'visible' outside of
the Coda kernel code, anything else should just go to fs/coda and get a
good dust off to remove a bunch of cruft.

> Oh and there's no entry for CODA in MAINTAINERS file. You probably
> want to fix that.

Gee, oh well. I didn't consider it 'critical bug-fixes only' or
important enough to push a patch for a maintainers entry into a stable
series, and obviously wasn't paying attention during 2.3 development.

Besides I've been sending you updates whenever something critical
changes in coda.o (considering you are using it for podfuk). I would
figure that of all people at least you would know.

Jan

