Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274757AbRJNHvx>; Sun, 14 Oct 2001 03:51:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274756AbRJNHvn>; Sun, 14 Oct 2001 03:51:43 -0400
Received: from cs181088.pp.htv.fi ([213.243.181.88]:8064 "EHLO
	cs181088.pp.htv.fi") by vger.kernel.org with ESMTP
	id <S274752AbRJNHva>; Sun, 14 Oct 2001 03:51:30 -0400
Message-ID: <3BC9441C.887258DA@welho.com>
Date: Sun, 14 Oct 2001 10:51:56 +0300
From: Mika Liljeberg <Mika.Liljeberg@welho.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.10-ac10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: TCP acking too fast
In-Reply-To: <3BC8DAF0.3D16A546@welho.com>
		<20011013.234016.104032175.davem@redhat.com>
		<3BC9393D.765A156@welho.com> <20011014.004744.51856957.davem@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" wrote:
> 
>    From: Mika Liljeberg <Mika.Liljeberg@welho.com>
>    Date: Sun, 14 Oct 2001 10:05:33 +0300
> 
>    I've attached a fragment of tcpdump output from the middle of steady
>    state transfer. Looking at the dump, it seems that most arriving
>    segments have the PSH bit set. This leads me to believe that the
>    transfer is mostly application limited at the sender side.
> 
> This means the application is doing many small writes.

Nope, it simply means that the remote machine has a 100 Mbit Ethernet
card that keeps emptying the transmit queue faster than it can be
filled.

>  To be honest,
> to only sure way to cure any performance problems from that is to
> fix the application in question.  What is this application?

I don't control the remote machine, but it's linux (don't know which
version). I tried with both HTTP (Apache 1.3.9) and FTP. I doubt it's
the application. :-)

Regards,

	MikaL
