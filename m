Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293012AbSBVVoh>; Fri, 22 Feb 2002 16:44:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293009AbSBVVo1>; Fri, 22 Feb 2002 16:44:27 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:48368
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S293010AbSBVVoP>; Fri, 22 Feb 2002 16:44:15 -0500
Date: Fri, 22 Feb 2002 13:44:08 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jamie Lokier <lk@tantalophile.demon.co.uk>, Dan Kegel <dank@kegel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Zach Brown <zab@zabbo.net>
Subject: Re: is CONFIG_PACKET_MMAP always a win?
Message-ID: <20020222214408.GI20060@matchmail.com>
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Jamie Lokier <lk@tantalophile.demon.co.uk>,
	Dan Kegel <dank@kegel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Zach Brown <zab@zabbo.net>
In-Reply-To: <20020222190431.A16926@kushida.apsleyroad.org> <E16eLoz-0002vD-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E16eLoz-0002vD-00@the-village.bc.nu>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 22, 2002 at 07:57:33PM +0000, Alan Cox wrote:
> > > You can process them in the ring buffer. If you can't keep up then you
> > > are screwed any way you look at it 8)
> > 
> > That still doesn't avoid copying: af_packet copies the whole packet (if
> > you want the whole packet) from the original skbuff to the ring buffer.
> 
> I'd make a handwaved claim that the first copy of the packet from a DMA
> receiving source is free. Its certainly pretty close to free because the
> overhead of sucking it into L1 cache will dominate and you need to do that
> anyway.
> 

Doesn't DMA access system memory directly and leave processor caches alone?
If so, then the fewer copies that have to pollute the L1/2 caches the better.

Even if it does for UP, I'd immagine that it doesn't for SMP...

Mike
