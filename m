Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129431AbQLFSIN>; Wed, 6 Dec 2000 13:08:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129834AbQLFSIE>; Wed, 6 Dec 2000 13:08:04 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:38916 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129431AbQLFSHs>; Wed, 6 Dec 2000 13:07:48 -0500
Message-ID: <3A2E793F.E9633E6C@transmeta.com>
Date: Wed, 06 Dec 2000 09:37:03 -0800
From: "H. Peter Anvin" <hpa@transmeta.com>
Organization: Transmeta Corporation
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-test11 i686)
X-Accept-Language: en, sv, no, da, es, fr, ja
MIME-Version: 1.0
To: Alan Cox <alan@redhat.com>
CC: Giacomo Catenazzi <cate@student.ethz.ch>,
        Linus Torvalds <torvalds@transmeta.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: That horrible hack from hell called A20
In-Reply-To: <200012061301.eB6D17B08279@devserv.devel.redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> > INT 15-2401 disable A20
> > INT 15-2402 query status A20
> > INT 15-2403 query A20 support (kdb or port 92)
> >
> > IBM classifies these functions as optional, but it is enabled on a lot
> > of
> > new BIOS, no know conflicts, thus we can call this function to enable
> > A20,
> > check the result and only after failure we can try the old methods.
> 
> I trust Linus over BIOS vendors, every single time.
> 

The problem here is Linus doing things right, and the BIOS vendors not...
and the BIOS getting confused.  If INT 15:24xx is supported, we might
actually want to use it, under the assumption that if it works, the BIOS
Suspend-to-Foo routines probably won't get too confused.

	-hpa

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
