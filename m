Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319822AbSIMXM1>; Fri, 13 Sep 2002 19:12:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319823AbSIMXM1>; Fri, 13 Sep 2002 19:12:27 -0400
Received: from air-2.osdl.org ([65.172.181.6]:13954 "EHLO
	wookie-t23.pdx.osdl.net") by vger.kernel.org with ESMTP
	id <S319822AbSIMXM0>; Fri, 13 Sep 2002 19:12:26 -0400
Subject: RE: Killing/balancing processes when overcommited
From: "Timothy D. Witham" <wookie@osdl.org>
To: Rik van Riel <riel@conectiva.com.br>
Cc: jimsibley@earthlink.net, linux-kernel@vger.kernel.org,
       thunder@lightweight.ods.org
In-Reply-To: <Pine.LNX.4.44L.0209131943390.1857-100000@imladris.surriel.com>
References: <Pine.LNX.4.44L.0209131943390.1857-100000@imladris.surriel.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 13 Sep 2002 16:12:14 -0700
Message-Id: <1031958734.1403.249.camel@wookie-t23.pdx.osdl.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 2002-09-13 at 15:44, Rik van Riel wrote:
> On 13 Sep 2002, Timothy D. Witham wrote:
> 
> >   In this case the offense is asking for more memory.  So it is the
> > process that asks for more memory that goes away.  Again sometimes it
> > will be an innocent bystander but hopefully it will eventually be the
> > process that is causing the problem.
> 
> If you kill the process that requests memory, the sequence often
> goes as follows:
> 
> 1) memory is exhausted
> 
> 2) the network driver can't allocate memory and
>    spits out a message
> 
> 3) syslogd and/or klogd get killed
> 
> Clearly you want to be a bit smarter about which process to kill.
>   


Right, you need to have a hold back for the kernel/root items to 
ensure that this sort of thing doesn't happen.


> regards,
> 
> Rik
> -- 
> Bravely reimplemented by the knights who say "NIH".
> 
> http://www.surriel.com/		http://distro.conectiva.com/
> 
> Spamtraps of the month:  september@surriel.com trac@trac.org
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
-- 
Timothy D. Witham - Lab Director - wookie@osdlab.org
Open Source Development Lab Inc - A non-profit corporation
15275 SW Koll Parkway - Suite H - Beaverton OR, 97006
(503)-626-2455 x11 (office)    (503)-702-2871     (cell)
(503)-626-2436     (fax)

