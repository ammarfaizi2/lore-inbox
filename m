Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S143752AbRAHOfq>; Mon, 8 Jan 2001 09:35:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S143994AbRAHOfg>; Mon, 8 Jan 2001 09:35:36 -0500
Received: from [172.16.18.67] ([172.16.18.67]:11906 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S143752AbRAHOfA>; Mon, 8 Jan 2001 09:35:00 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <01010812305810.02165@www.easysolutions.net> 
In-Reply-To: <01010812305810.02165@www.easysolutions.net>  <Pine.LNX.4.10.10101071938540.28661-100000@penguin.transmeta.com> <23514.978959516@redhat.com> 
To: shane@agendacomputing.com
Cc: Linus Torvalds <torvalds@transmeta.com>,
        "Adam J. Richter" <adam@yggdrasil.com>, parsley@roanoke.edu,
        linux-kernel@vger.kernel.org
Subject: Re: Patch (repost): cramfs memory corruption fix 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 08 Jan 2001 14:34:49 +0000
Message-ID: <7849.978964489@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


shane@agendacomputing.com said:
>  While the topic is raised..., I've hacked up cramfs for linear
> addressing to  kill the "double buffering" effiect.  However as David
> mentions the block  device support thing is an issue here.  What is a
> reasonable way to allow a  cramfs partition to access the device
> directly, like the patch that I wrote,  and be picked up in a
> reasonable way by the init system?

So far, I just cheat. JFFS doesn't need a block device, but uses the minor# 
to determine which MTD device to use. You could use the same trick.

--
dwmw2


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
