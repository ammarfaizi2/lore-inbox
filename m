Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130446AbRDMMIC>; Fri, 13 Apr 2001 08:08:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130038AbRDMMHw>; Fri, 13 Apr 2001 08:07:52 -0400
Received: from ferret.lmh.ox.ac.uk ([163.1.18.131]:17935 "HELO
	ferret.lmh.ox.ac.uk") by vger.kernel.org with SMTP
	id <S129669AbRDMMHr>; Fri, 13 Apr 2001 08:07:47 -0400
Date: Fri, 13 Apr 2001 13:07:43 +0100 (BST)
From: Chris Evans <chris@scary.beasts.org>
To: Dawson Engler <engler@csl.Stanford.EDU>
cc: <linux-kernel@vger.kernel.org>, <mc@cs.Stanford.EDU>
Subject: Re: [CHECKER] security rules?
In-Reply-To: <200104130947.CAA21780@csl.Stanford.EDU>
Message-ID: <Pine.LNX.4.30.0104131304390.29623-100000@ferret.lmh.ox.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Dawson,

Excellent project.

Can I suggest that you check for signedness issues? A typical signature of
a signedness problem is:

int i = get_from_userspace_somehow();
/* Sanity check i */
if (i > MAX_LEN_FOR_I)
  goto bad_bad_out;
/* Bug here!! i can be negative! */


I suspect you find a lot of these sort of errors. I've already nailed a
few.

Cheers
Chris

On Fri, 13 Apr 2001, Dawson Engler wrote:

>
> We're looking at making a set of security checkers.  Does anyone have
> suggestions for good things to go after in addition to the usual
> copy_*_user and buffer overrun bugs?  For example, are there any
> documents that describe the rules for when/how 'capable' is supposed to
> be used?
>
> Thanks for any help,
> Dawson
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

