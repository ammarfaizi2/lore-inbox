Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S130219AbQK0JjF>; Mon, 27 Nov 2000 04:39:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S130299AbQK0Ji4>; Mon, 27 Nov 2000 04:38:56 -0500
Received: from lsb-catv-1-p021.vtxnet.ch ([212.147.5.21]:4114 "EHLO
        almesberger.net") by vger.kernel.org with ESMTP id <S130219AbQK0Jir>;
        Mon, 27 Nov 2000 04:38:47 -0500
Date: Mon, 27 Nov 2000 10:08:20 +0100
From: Werner Almesberger <Werner.Almesberger@epfl.ch>
To: "David S. Miller" <davem@redhat.com>
Cc: adam@yggdrasil.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] removal of "static foo = 0"
Message-ID: <20001127100820.V573@almesberger.net>
In-Reply-To: <200011270556.VAA12506@baldur.yggdrasil.com> <20001127094139.H599@almesberger.net> <200011270839.AAA28672@pizda.ninka.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200011270839.AAA28672@pizda.ninka.net>; from davem@redhat.com on Mon, Nov 27, 2000 at 12:39:55AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote:
> There is no guarentee that contiguous data or bss section members
> will appear contiguous and in the same order, in the final object.

That's a different issue and actually okay in this case.

What I meant to show is an example where the compiler happens to
allocate the variables in sequence, and where it could access them
either by referencing each by absolute address, with relocation (so
that objdump-patcher could change that), or by generating a pointer
and using pointer-relative addressing or pointer increment (so we
only get one relocation and never know what may go wrong with the
other variables).

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, ICA, EPFL, CH           Werner.Almesberger@epfl.ch /
/_IN_N_032__Tel_+41_21_693_6621__Fax_+41_21_693_6610_____________________/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
