Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262503AbRENVZM>; Mon, 14 May 2001 17:25:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262504AbRENVZE>; Mon, 14 May 2001 17:25:04 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:9154 "HELO havoc.gtf.org")
	by vger.kernel.org with SMTP id <S262503AbRENVYw>;
	Mon, 14 May 2001 17:24:52 -0400
Message-ID: <3B004D1D.6E7140C@mandrakesoft.com>
Date: Mon, 14 May 2001 17:24:45 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.5-pre1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        "H. Peter Anvin" <hpa@transmeta.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        viro@math.psu.edu
Subject: Re: LANANA: To Pending Device Number Registrants
In-Reply-To: <3B003EFC.61D9C16A@mandrakesoft.com>
		<Pine.LNX.4.31.0105141328020.22874-100000@penguin.transmeta.com> <15104.17957.253821.765483@notabene.cse.unsw.edu.au>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Brown wrote:
> So I need a major number - to give to devfs_register_blkdev at least.
> You don't want me to have a hardcoded one (which is fine) so I need a
> dynamically allocated one - yes?
> 
> This means that we need some analogue to {get,put}_unnamed_dev that
> manages a range of dynamically allocated majors.
> Is there such a beast already, or does someone need to write it?
> What range(s) should be used for block devices?

register_blkdev will assign a dynamic major to your block device, if a
static one is not provided.  This has been true since 2.2, maybe 2.0
IIRC.

-- 
Jeff Garzik      | Game called on account of naked chick
Building 1024    |
MandrakeSoft     |
