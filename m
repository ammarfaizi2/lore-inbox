Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262125AbRENPQO>; Mon, 14 May 2001 11:16:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262128AbRENPQE>; Mon, 14 May 2001 11:16:04 -0400
Received: from smtp102.urscorp.com ([38.202.96.105]:28680 "EHLO
	smtp102.urscorp.com") by vger.kernel.org with ESMTP
	id <S262125AbRENPPu>; Mon, 14 May 2001 11:15:50 -0400
To: "David S. Miller" <davem@redhat.com>
Cc: kuznet@ms2.inr.ac.ru, linux-kernel@vger.kernel.org
Subject: Re: skb->truesize > sk->rcvbuf == Dropped packets
X-Mailer: Lotus Notes Release 5.0.5  September 22, 2000
From: mike_phillips@urscorp.com
Message-ID: <OFE3DC388A.10616F68-ON84256A4C.004C2B8C@urscorp.com>
Date: Mon, 14 May 2001 12:08:06 -0300
X-MIMETrack: Serialize by Router on SMTP102/URSCorp(Release 5.0.5 |September 22, 2000) at
 05/14/2001 11:11:15 AM,
	Serialize complete at 05/14/2001 11:11:15 AM
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > >  > Any suggestions on heuristics for this ? 
> > 
> > Not to set rcvbuf to ridiculously low values. The best variant is not
> > to touch SO_*BUF options at all.

> Hmmm... I don't see how not touching buffer values can solve his
> problem at all.  His MTU is really HUGE, and in this case 300 byte
> packet eats 10k or so space in receive buffer.

> I doubt our buffer size tuning algorithms can cope with this.

Yep, it's no big thing to make the change in the driver, the copy is not 
that expensive and compared to the speed of the physical layer its 
virtually a non-impact. The most I've ever got out of 16 mbps t/r is just 
over 2 mb/second and memory copies can easily keep up with that. (That's 
with 8192 byte mtu's and ftp transfers which wouldn't get copied anyway). 

Mike

