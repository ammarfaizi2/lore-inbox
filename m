Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130931AbRCFFFc>; Tue, 6 Mar 2001 00:05:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130933AbRCFFFW>; Tue, 6 Mar 2001 00:05:22 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:12304 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S130931AbRCFFFN>; Tue, 6 Mar 2001 00:05:13 -0500
Message-ID: <3AA47000.5CE66D95@transmeta.com>
Date: Mon, 05 Mar 2001 21:05:04 -0800
From: "H. Peter Anvin" <hpa@transmeta.com>
Organization: Transmeta Corporation
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0 i686)
X-Accept-Language: en, sv, no, da, es, fr, ja
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Kenn Humborg <kenn@linux.ie>, "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org
Subject: Re: kmalloc() alignment
In-Reply-To: <E14a6zQ-0008Gz-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> > > It might be worth asking the question if larger blocks are more
> > > aligned?
> >
> > OK, I'll bite...
> > Are larger blocks more aligned?
> 
> Only get_free_page()
> 

I wonder if it would be practical/reasonable to guarantee better
alignment for larger allocations (at least for sizes that are powers of
two); especially 8- and 16-byte alignment is sometimes necessary.

	-hpa

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
