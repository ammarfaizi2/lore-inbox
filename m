Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265863AbRFYRkL>; Mon, 25 Jun 2001 13:40:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265889AbRFYRkC>; Mon, 25 Jun 2001 13:40:02 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:3847 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S265863AbRFYRjs>;
	Mon, 25 Jun 2001 13:39:48 -0400
Date: Mon, 25 Jun 2001 14:39:39 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
To: Jeff Dike <jdike@karaya.com>
Cc: Bulent Abali <abali@us.ibm.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, James Stevenson <mistral@stev.org>
Subject: Re: all processes waiting in TASK_UNINTERRUPTIBLE state 
In-Reply-To: <200106251825.NAA02909@ccure.karaya.com>
Message-ID: <Pine.LNX.4.21.0106251437160.7419-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Jun 2001, Jeff Dike wrote:
> abali@us.ibm.com said:
> > Can you give more details?  Was there an aic7xxx scsi driver on the
> > box? run_task_queue(&tq_disk) should eventually unlock those pages but
> > they remain locked.  I am trying to narrow it down to fs/buffer code
> > or the SCSI driver aic7xxx in my case.
> 
> Rik would be the one to tell you whether there was an aic7xxx driver
> on the physical box.  There obviously isn't one on UML, so if we're
> looking at the same bug, it's in the generic code.

The box has as AIC-7880U controller. OTOH, my dual P5 also has
an AIC7xxx controller and I've never seen the problem there...

On our quad Xeon this problem really seems to be phase-of-moon
related; it hasn't shown up in the last 5 days or so under heavy
stress testing, but when the kernel is compiled just a little bit
different it doesn't happen. ;)

regards,

Rik
--
Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

http://www.surriel.com/		http://distro.conectiva.com/

Send all your spam to aardvark@nl.linux.org (spam digging piggy)

