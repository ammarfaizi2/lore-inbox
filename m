Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132691AbRAXVjY>; Wed, 24 Jan 2001 16:39:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132630AbRAXVjO>; Wed, 24 Jan 2001 16:39:14 -0500
Received: from ezri.xs4all.nl ([194.109.253.9]:63940 "HELO ezri.xs4all.nl")
	by vger.kernel.org with SMTP id <S132691AbRAXVjJ>;
	Wed, 24 Jan 2001 16:39:09 -0500
Date: Wed, 24 Jan 2001 22:39:06 +0100 (CET)
From: Eric Lammerts <eric@lammerts.org>
To: Mark Longair <list-reader@ideaworks3d.com>
cc: <linux-kernel@vger.kernel.org>,
        "Richard B. Johnson" <root@chaos.analogic.com>
Subject: Re: [2.2.18] outgoing connections getting stuck in SYN_SENT
In-Reply-To: <871ytt1239.fsf@starfruit.iwks.multi.local>
Message-ID: <Pine.LNX.4.32.0101242233300.26720-100000@ally.lammerts.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 24 Jan 2001, Mark Longair wrote:
> It turned out that this was caused by using autofw to forward a range
> of ports (2300-2400 in this case.)  It seems that these ports aren't
> reserved in any way, so eventually the server tries to use one as a
> local port on an outgoing connection.
>
> I'm looking at finding fix for that.

Tell the kernel to use a different range for automatically
assigned ports, that doesn't conflict with your forwarded ports.
For example:
echo "49152 59999" >/proc/sys/net/ipv4/ip_local_port_range

Eric

-- 
Eric Lammerts <eric@lammerts.org> | The best way to accelerate a computer
http://www.lammerts.org           | running Windows is at 9.8 m/s^2.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
