Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129189AbQKTRbX>; Mon, 20 Nov 2000 12:31:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129345AbQKTRbM>; Mon, 20 Nov 2000 12:31:12 -0500
Received: from lsb-catv-1-p021.vtxnet.ch ([212.147.5.21]:46091 "EHLO
	almesberger.net") by vger.kernel.org with ESMTP id <S129189AbQKTRaz>;
	Mon, 20 Nov 2000 12:30:55 -0500
Date: Mon, 20 Nov 2000 18:00:32 +0100
From: Werner Almesberger <Werner.Almesberger@epfl.ch>
To: "Charles Turner, Ph.D." <cturner@quark.analogic.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Defective Red Hat Distribution poorly represents Linux
Message-ID: <20001120180032.C599@almesberger.net>
In-Reply-To: <Pine.LNX.3.95.1001120084920.580A-100000@quark.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.3.95.1001120084920.580A-100000@quark.analogic.com>; from cturner@quark.analogic.com on Mon, Nov 20, 2000 at 08:53:19AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Charles Turner, Ph.D. wrote:
> I can even see obvious bugs in the trace, i.e., :
> stat("/usrusr/lib/ldscripts", 0xbffffa7c) = -1 ENOENT (No such file or directory)

Probably only a cosmetic problem. A regular run (RedHat binutils-2.9.5.0.22-6)
yields:

stat("/usrusr/lib/ldscripts", 0xbffff5c4) = -1 ENOENT (No such file or directory
)
stat("/usr/bin/ldscripts", 0xbffff5c4)  = -1 ENOENT (No such file or directory)
stat("/usr/bin/../lib/ldscripts", {st_mode=S_IFDIR|0755, st_size=1024, ...}) = 0

So it's not perfect, but it works. 

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, ICA, EPFL, CH           Werner.Almesberger@epfl.ch /
/_IN_N_032__Tel_+41_21_693_6621__Fax_+41_21_693_6610_____________________/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
