Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130022AbRAQRFU>; Wed, 17 Jan 2001 12:05:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131552AbRAQRFK>; Wed, 17 Jan 2001 12:05:10 -0500
Received: from lsb-catv-1-p021.vtxnet.ch ([212.147.5.21]:27665 "EHLO
	almesberger.net") by vger.kernel.org with ESMTP id <S130022AbRAQRFC>;
	Wed, 17 Jan 2001 12:05:02 -0500
Date: Wed, 17 Jan 2001 18:04:33 +0100
From: Werner Almesberger <Werner.Almesberger@epfl.ch>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.0 + iproute2
Message-ID: <20010117180433.A4979@almesberger.net>
In-Reply-To: <14945.26991.35849.95234@pizda.ninka.net> <Pine.LNX.4.30.0101141013080.16469-100000@jdi.jdimedia.nl> <14945.28354.209720.579437@pizda.ninka.net> <20010114115215.A22550@gruyere.muc.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010114115215.A22550@gruyere.muc.suse.de>; from ak@suse.de on Sun, Jan 14, 2001 at 11:52:15AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> Configuring a complex subsystem like CBQ which has dozens of parameters
> with only a single ed'esque error message (EINVAL) when something goes
> wrong is just bad.

The underlying problem is of course that all those sanity checks should
be done in user space, not in the kernel.

(See also ftp://icaftp.epfl.ch/pub/people/almesber/slides/tmp-tc.ps.gz
The bitching starts on slide 11, some ideas for fixing the problem on
slide 16, but heed the warning on slide 15.)

Besides that, I agree that we have far too many EINVALs in the kernel.
Maybe we should just record file name and line number of the EINVAL
in *current and add an eh?(2) system call ;-)

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, ICA, EPFL, CH           Werner.Almesberger@epfl.ch /
/_IN_N_032__Tel_+41_21_693_6621__Fax_+41_21_693_6610_____________________/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
