Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129228AbQLPASI>; Fri, 15 Dec 2000 19:18:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129319AbQLPAR6>; Fri, 15 Dec 2000 19:17:58 -0500
Received: from lsb-catv-1-p021.vtxnet.ch ([212.147.5.21]:44048 "EHLO
	almesberger.net") by vger.kernel.org with ESMTP id <S129228AbQLPARn>;
	Fri, 15 Dec 2000 19:17:43 -0500
Date: Sat, 16 Dec 2000 00:47:14 +0100
From: Werner Almesberger <Werner.Almesberger@epfl.ch>
To: "J . A . Magallon" <jamagallon@able.es>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linus's include file strategy redux
Message-ID: <20001216004714.V573@almesberger.net>
In-Reply-To: <20001215152137.K599@almesberger.net> <NBBBJGOOMDFADJDGDCPHAENMCJAA.law@sgi.com> <20001215222117.S573@almesberger.net> <20001215234857.A689@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20001215234857.A689@werewolf.able.es>; from jamagallon@able.es on Fri, Dec 15, 2000 at 11:48:57PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

J . A . Magallon wrote:
> Easier: public kernel interfaces only work through pointers.

Requires more elaborate wrappers or a new layer of wrapper functions
around system calls, if you want to make this completely general.
Also, doesn't provide FOOSIZE to "public" space.

> Too kind-of-classroom-not-real-world-useless-thing ?

I'm afraid so ...

I don't think there are many opaque types where there's no trival
solution. Actually, I don't think there are many opaque types at
kernel APIs to start with. The one I know offhand is atm_kptr_t
in include/linux/atmapi.h, in this case, there's little risk in
exposing the internal structure.

So I'd consider opaque types more as a hypothetical obstacle.

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, ICA, EPFL, CH           Werner.Almesberger@epfl.ch /
/_IN_N_032__Tel_+41_21_693_6621__Fax_+41_21_693_6610_____________________/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
