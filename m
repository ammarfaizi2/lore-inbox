Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292937AbSBVTGK>; Fri, 22 Feb 2002 14:06:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292952AbSBVTGA>; Fri, 22 Feb 2002 14:06:00 -0500
Received: from pc-62-31-92-140-az.blueyonder.co.uk ([62.31.92.140]:47846 "EHLO
	kushida.apsleyroad.org") by vger.kernel.org with ESMTP
	id <S292937AbSBVTFo>; Fri, 22 Feb 2002 14:05:44 -0500
Date: Fri, 22 Feb 2002 19:04:31 +0000
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Dan Kegel <dank@kegel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Zach Brown <zab@zabbo.net>
Subject: Re: is CONFIG_PACKET_MMAP always a win?
Message-ID: <20020222190431.A16926@kushida.apsleyroad.org>
In-Reply-To: <20020222180957.A16796@kushida.apsleyroad.org> <E16eKbx-0002k2-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <E16eKbx-0002k2-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Fri, Feb 22, 2002 at 06:40:01PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> > >    Overhead: kernel does a full memcpy of the packet body to get it
> > >    into the ring buffer, and my program does another to get it out.
> > 
> > I had a look at this about a year ago, and it seems there is no method
> > provided to read the packets without copying them, if you need them in
> > user space.
> 
> You can process them in the ring buffer. If you can't keep up then you
> are screwed any way you look at it 8)

That still doesn't avoid copying: af_packet copies the whole packet (if
you want the whole packet) from the original skbuff to the ring buffer.

-- Jamie
