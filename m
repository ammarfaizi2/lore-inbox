Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261848AbVBIQjW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261848AbVBIQjW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Feb 2005 11:39:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261849AbVBIQjW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Feb 2005 11:39:22 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:25996 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261848AbVBIQjL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Feb 2005 11:39:11 -0500
Date: Wed, 9 Feb 2005 11:03:20 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Todd Shetter <tshetter-lkml@earthlink.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.x kernel BUG at filemap.c:81
Message-ID: <20050209130319.GA13986@logos.cnet>
References: <42099C57.9030306@earthlink.net> <20050209121011.GA13614@logos.cnet> <420A3A8D.9030705@earthlink.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <420A3A8D.9030705@earthlink.net>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 09, 2005 at 11:30:05AM -0500, Todd Shetter wrote:
> Marcelo Tosatti wrote:
> 
> >On Wed, Feb 09, 2005 at 12:15:03AM -0500, Todd Shetter wrote:
> > 
> >
> >>Running slackware 10 and 10.1, with kernels 2.4.26, 2.4.27, 2.4.28, 
> >>2.4.29 with highmem 4GB, and highmem i/o support enabled, I get a system 
> >>lockup. This happens in both X and console. Happens with and without my 
> >>Nvidia drivers loaded. I cannot determine what makes this bug present it 
> >>self besides highmem and high i/o support enabled. Im guessing the 
> >>system is fine until highmem is actually used to some point and then it 
> >>borks, but I really have no idea and so im just making a random guess. I 
> >>ran memtest86 for a few hours a while ago thinking that it may be bad 
> >>memory, but that did not seem to be the problem.
> >>
> >>If you need anymore information, or have questions, or wish me to test 
> >>anything, PLEASE feel free to contact me, I would really like to see 
> >>this bug resolved. =)
> >>
> >>--
> >>Todd Shetter
> >>
> >>
> >>Feb  8 19:49:31 quark kernel: kernel BUG at filemap.c:81!
> >>Feb  8 19:49:31 quark kernel: invalid operand: 0000
> >>Feb  8 19:49:31 quark kernel: CPU:    0
> >>Feb  8 19:49:31 quark kernel: EIP:    0010:[<c01280d1>]    Tainted: P
> >>   
> >>
> >
> >Hi Todd, 
> >
> >Why is your kernel tainted ?
> >-
> >To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> >the body of a message to majordomo@vger.kernel.org
> >More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >Please read the FAQ at  http://www.tux.org/lkml/
> >
> > 
> >
> I had the nvidia 1.0-6629 driver loaded when I got that error. I 
> compiled the kernel using the slackware 10.1 config, enabled highmem 4GB 
> support, highmem i/o, and then some kernel hacking options including 
> debugging for highmen related things.
> 
> I booted, loaded X with KDE, opened firefox a few times, and then 
> started running hdparm because some newer 2.4.x kernels dont play nice 
> with my SATA, ICH5, and DMA. hdparm segfaulted while running the drive 
> read access portion of its tests, and things locked up from there in 
> about 30secs.
> 
> I've gotten the same error with the nvidia driver not loaded, so I dont 
> think that is part of the problem.
> 
> As I said, if you want me to test or try anything feel free to ask.  =)

Todd,

Would be interesting to have the oops output without the kernel nvidia module. 

Do you have that saved?


