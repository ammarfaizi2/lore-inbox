Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129292AbRCZVy3>; Mon, 26 Mar 2001 16:54:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129393AbRCZVyU>; Mon, 26 Mar 2001 16:54:20 -0500
Received: from colorfullife.com ([216.156.138.34]:63241 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S129292AbRCZVyD>;
	Mon, 26 Mar 2001 16:54:03 -0500
Message-ID: <00c701c0b63f$2d4fe720$5517fea9@local>
From: "Manfred Spraul" <manfred@colorfullife.com>
To: "LA Walsh" <law@sgi.com>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <009201c0b61e$c83f7550$5517fea9@local> <3ABF9B40.6B93ECA2@sgi.com>
Subject: Re: 64-bit block sizes on 32-bit systems
Date: Mon, 26 Mar 2001 23:53:05 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "LA Walsh" <law@sgi.com>
> Manfred Spraul wrote:
> >
> > >4k page size * 2GB = 8TB.
> >
> > Try it.
> > If your drive (array) is larger than 512byte*4G (4TB) linux will eat
> > your data.
> ---
> I have a block device that doesn't use 'sectors'.  It
> only uses the logical block size (which is currently set for
> 1K).  Seems I could up that to the max blocksize (4k?) and
> get 8TB...No?
>
> I don't use the generic block make request (have my
> own).
>
Which field do you access? bh->b_blocknr instead of bh->r_sector?

There were plans to split the buffer_head into 2 structures: buffer
cache data and the block io data.
b_blocknr is buffer cache only, no driver should access them.

http://groups.google.com/groups?q=NeilBrown+io_head&hl=en&lr=&safe=off&r
num=1&seld=928643305&ic=1

--
    Manfred

