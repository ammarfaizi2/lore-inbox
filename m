Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286468AbSASSOa>; Sat, 19 Jan 2002 13:14:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286521AbSASSOT>; Sat, 19 Jan 2002 13:14:19 -0500
Received: from pcp100548pcs.glstrt01.nj.comcast.net ([68.45.112.151]:37249
	"EHLO localhost") by vger.kernel.org with ESMTP id <S286468AbSASSOH>;
	Sat, 19 Jan 2002 13:14:07 -0500
Date: Sat, 19 Jan 2002 12:14:19 -0500
From: Mike Phillips <phillim2@home.com>
To: Kent E Yoder <yoder1@us.ibm.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Jeff Garzik <jgarzik@mandrakesoft.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] IBM Lanstreamer bugfixes
Message-ID: <20020119171418.GA14412@home.com>
In-Reply-To: <OF0DC8C676.D07D3CD8-ON85256B45.007E1B7C@raleigh.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OF0DC8C676.D07D3CD8-ON85256B45.007E1B7C@raleigh.ibm.com>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 18, 2002 at 05:02:57PM -0600 or sometime in the same epoch, Kent E Yoder scribbled:
>   Ok, I thought of one thing that might make things clearer here: when I 
> say "the write failed", I mean that we saw the write go out on the PCI bus 
> and then the box locked up.  We were looking at it on a PCI bus analyzer. 
> That, and it wasn't just this write, or just writes in general, it really 
> seemed random.
> 

Kent,

We had this on olympic for certain high end IBM boxen. Spent forever
trying to trap it as I couldn't emulate the behaviour on my test
boxes. We weren't getting correct values from pci reads/write and we
were running out of buffers as they weren't getting flushed. The
machine wouldn't lock but the adapter would stop tx/rx.

Turned out the pci bridge on the machine itself was causing the
problems. Tweaking the pci bus fixed the problem.  

-- 
Mike Phillips
Linux Token Ring Project
http://www.linuxtr.net
mailto: mikep@linuxtr.net

