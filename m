Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261839AbRE2AMV>; Mon, 28 May 2001 20:12:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261845AbRE2AML>; Mon, 28 May 2001 20:12:11 -0400
Received: from smtp1.cern.ch ([137.138.128.38]:1043 "EHLO smtp1.cern.ch")
	by vger.kernel.org with ESMTP id <S261839AbRE2AME>;
	Mon, 28 May 2001 20:12:04 -0400
Date: Tue, 29 May 2001 02:11:56 +0200
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Richard Zidlicky <rz@linux-m68k.org>, tim@cyberelk.net,
        linux-kernel@vger.kernel.org, Fred Barnes <Frederick.Barnes@cern.ch>
Subject: Re: insl/outsl in parport_pc and !CONFIG_PCI
Message-ID: <20010529021156.B6061@pcep-jamie.cern.ch>
In-Reply-To: <20010527191613.A2808@rz.informatik.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010527191613.A2808@rz.informatik.uni-erlangen.de>; from rz@linux-m68k.org on Sun, May 27, 2001 at 07:16:14PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard Zidlicky wrote:
> How is that supposed to work on systems without PCI? For now I have
> defined 
> 
> #define insl(port,buf,len)   isa_insb(port,buf,(len)<<2)
> #define outsl(port,buf,len)  isa_outsb(port,buf,(len)<<2)

Tim, Fred,

Will 4 * inb() cycles have the same effect as 1 * inl() cycle for an EPP
mode read?

By the way, it's probably worth a check whether insl() is actually
faster than a loop doing inl() these days.  Guess I should do that :)

cheers,
-- Jamie
