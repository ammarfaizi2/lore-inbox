Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751362AbWBZWcc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751362AbWBZWcc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Feb 2006 17:32:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751412AbWBZWcc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Feb 2006 17:32:32 -0500
Received: from 41-052.adsl.zetnet.co.uk ([194.247.41.52]:12050 "EHLO
	mail.esperi.org.uk") by vger.kernel.org with ESMTP id S1751362AbWBZWcb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Feb 2006 17:32:31 -0500
To: Al Viro <viro@ftp.linux.org.uk>
Cc: Lee Revell <rlrevell@joe-job.com>, Jesper Juhl <jesper.juhl@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Building 100 kernels; we suck at dependencies and drown in
 warnings
References: <200602261721.17373.jesper.juhl@gmail.com>
	<1140986578.24141.141.camel@mindpipe> <87wtfh3i9z.fsf@hades.wkstn.nix>
	<20060226221401.GS27946@ftp.linux.org.uk>
From: Nix <nix@esperi.org.uk>
X-Emacs: impress your (remaining) friends and neighbors.
Date: Sun, 26 Feb 2006 22:32:21 +0000
In-Reply-To: <20060226221401.GS27946@ftp.linux.org.uk> (Al Viro's message of
 "Sun, 26 Feb 2006 22:14:01 +0000")
Message-ID: <87fym53g5m.fsf@hades.wkstn.nix>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Corporate Culture,
 linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 26 Feb 2006, Al Viro moaned:
> On Sun, Feb 26, 2006 at 09:46:32PM +0000, Nix wrote:
>> (i.e., there's a reason that warning uses the word *might*.)
> 
> The bug is in spewing tons of false positives, reducing S/N on that
> warning to nearly useless level.  Note that in this case actually
> missing some would be more useful if what remains is less diluted
> by crap.

I think this might be <http://gcc.gnu.org/PR5035>.

It's in the nature of this warning that improving its accuracy is often,
to quote rth in that bug, `distinctly non-trivial'. The (numerous) new
SSA optimizers in GCC 4.1 may well have fixed it: I'd be surprised if
they hadn't zapped a heap of FPs. I doubt it'll ever improve in 4.0.x,
because the magnitude of the changes required to do so is just so large.

There is ongoing argument on the GCC list between two camps: one that
proposes moving such warnings into the frontend, and says that the
increase in FPs is worth it given the increase in warning stability (the
warnings don't go away just because you change optimization level); the
other argues against this on the basis that a warning that gives lots
of FPs is mostly useless.

Feel free to chip in the next time this argument flares up :)

-- 
`... follow the bouncing internment camps.' --- Peter da Silva
