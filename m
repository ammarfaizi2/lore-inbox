Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129183AbQLOWHa>; Fri, 15 Dec 2000 17:07:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129352AbQLOWHU>; Fri, 15 Dec 2000 17:07:20 -0500
Received: from lsb-catv-1-p021.vtxnet.ch ([212.147.5.21]:36368 "EHLO
	almesberger.net") by vger.kernel.org with ESMTP id <S129183AbQLOWHK>;
	Fri, 15 Dec 2000 17:07:10 -0500
Date: Fri, 15 Dec 2000 22:36:27 +0100
From: Werner Almesberger <Werner.Almesberger@epfl.ch>
To: "Matt D. Robinson" <yakker@alacritech.com>
Cc: Alexander Viro <viro@math.psu.edu>, LA Walsh <law@sgi.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linus's include file strategy redux
Message-ID: <20001215223627.U573@almesberger.net>
In-Reply-To: <NBBBJGOOMDFADJDGDCPHIENJCJAA.law@sgi.com> <Pine.GSO.4.21.0012141900140.10441-100000@weyl.math.psu.edu> <20001215152137.K599@almesberger.net> <3A3A7284.DE48A381@alacritech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3A3A7284.DE48A381@alacritech.com>; from yakker@alacritech.com on Fri, Dec 15, 2000 at 11:35:32AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt D. Robinson wrote:
> I personally think the definition of an environment variable to point to
> a header file location is the right way to go.

I see two disadvantages of this, compared to a script:
 - need to hard-code a default (unless we assume the variables are always
   set)
 - the way how environment variables are propagated

A script-based approach has the advantage that one can make a single
change (to a file) that instantly affects the whole local environment
(be this system-wide, per-user, or whatever). So there's no risk of
typing "make" to that forgotten xterm and an incompatible build
starts.

I like environment variables as a means to override auto-detected
defaults, though.

Also, environment variables don't solve the problem of conveniently
providing other compiler arguments (the kmodcc idea - the problem is
very old, but I think it's still not solved).

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, ICA, EPFL, CH           Werner.Almesberger@epfl.ch /
/_IN_N_032__Tel_+41_21_693_6621__Fax_+41_21_693_6610_____________________/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
