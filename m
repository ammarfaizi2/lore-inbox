Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267043AbRGPTRH>; Mon, 16 Jul 2001 15:17:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267676AbRGPTQ6>; Mon, 16 Jul 2001 15:16:58 -0400
Received: from thebsh.namesys.com ([212.16.0.238]:43527 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S267043AbRGPTQn>; Mon, 16 Jul 2001 15:16:43 -0400
Message-ID: <3B533D98.B9D1074@namesys.com>
Date: Mon, 16 Jul 2001 23:16:40 +0400
From: Hans Reiser <reiser@namesys.com>
Organization: Namesys
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.4 i686)
X-Accept-Language: en, ru
MIME-Version: 1.0
To: Jussi Laako <jlaako@pp.htv.fi>
CC: Daniel Phillips <phillips@bonn-fries.net>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: Stability of ReiserFS onj Kernel 2.4.x (sp. 2.4.[56]{-ac*}
In-Reply-To: <E15LopT-0004Cm-00@the-village.bc.nu> <3B51C864.C98B61DE@namesys.com> <01071523304400.06482@starship> <3B53221B.28B8D5A1@pp.htv.fi>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jussi Laako wrote:
> 
> Daniel Phillips wrote:
> >
> > We are not that far away from being able to handle 8K blocks, so that
> > would bump it up to 32 TB.
> 
> That's way too small. Something like 32 PB would be better... ;)
> We need at least one extra bit in volume/file size every year.
> 
>  - Jussi Laako
> 
> --
> PGP key fingerprint: 161D 6FED 6A92 39E2 EB5B  39DD A4DE 63EB C216 1E4B
> Available at PGP keyservers
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


Daniel, if I was real sure that 64k blocks were the right answer, I would agree with you.  I think
nobody knows what will happen with reiserfs if we go to 64k blocks.  It could be great.  On the
other hand, the average number of bytes memcopied with every small file insertion increases with
node size.  Scalable integers (Xanadu project idea in which the last bit of an integer indicates
whether the integer is longer than the base size by an amount equal to the base size, chain can be
infinitely long, they used a base size of 1 byte, but we could use a base size of 32 bits, and limit
it to 64 bits rather than allowing infinite scaling) seem like more conservative coding.

Hans
