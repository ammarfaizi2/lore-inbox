Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131013AbRBLWLy>; Mon, 12 Feb 2001 17:11:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131453AbRBLWLo>; Mon, 12 Feb 2001 17:11:44 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:28166 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S131013AbRBLWL0>; Mon, 12 Feb 2001 17:11:26 -0500
Message-ID: <3A885F72.ED9ADAE8@transmeta.com>
Date: Mon, 12 Feb 2001 14:10:58 -0800
From: "H. Peter Anvin" <hpa@transmeta.com>
Organization: Transmeta Corporation
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.1 i686)
X-Accept-Language: en, sv, no, da, es, fr, ja
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: James Sutherland <jas88@cam.ac.uk>, "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org
Subject: Re: LILO and serial speeds over 9600
In-Reply-To: <E14SQtT-0008C5-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> Sounds like MOP on the old Vaxen. TCP btw isnt as heavyweight as people
> sometimes think. You can (and people have) implemented a simple TCP client
> and IP and SLIP in 8K of EPROM on a 6502. There is a common misconception
> that a TCP must be complex.
> 
> All you actually _have_ to support is receiving frames in order, sending one
> frame at a time when the last data is acked and basic backoff. You dont have
> to parse tcp options, you dont have to support out of order reassembly.
> 

This is true, but one thing I'd really like to have is controlled buffer
overrun, which TCP *doesn't* have.  I really think an ad hoc UDP protocol
(I've already begun sketching on the details) is more appropriate in this
particular case.

	-hpa

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://vger.kernel.org/lkml/
