Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135652AbRAHWBW>; Mon, 8 Jan 2001 17:01:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135597AbRAHWBC>; Mon, 8 Jan 2001 17:01:02 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:62727 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S135424AbRAHWAw>; Mon, 8 Jan 2001 17:00:52 -0500
Subject: Re: Delay in authentication.gy
To: davem@redhat.com (David S. Miller)
Date: Mon, 8 Jan 2001 22:01:26 +0000 (GMT)
Cc: mhvl@linuxia.ih.lucent.com, clubneon@hereintown.net,
        linux-kernel@vger.kernel.org
In-Reply-To: <200101082117.NAA21459@pizda.ninka.net> from "David S. Miller" at Jan 08, 2001 01:17:36 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14FkM5-0005Rv-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> It was intentionally changed because there is no way for the "ICMP
> port unreachable" message coming back to be uniquely matched to that
> UDP socket.  It can reset sockets illegally in high load scenerios.
> 
> Solaris and other systems act identically.

And have identical bad problems with auth failures. Right now I've given up
trying to make 2.4 and YP mix because my RH setup assumes NIS auth will fail
fast during boot up scripts and it doesnt.

Unfortunately for the quickfix folks, Dave is right about needing to sort it,
and that means someone has to sort glibc to use the new interfaces

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
