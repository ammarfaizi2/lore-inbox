Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130539AbRA0WKD>; Sat, 27 Jan 2001 17:10:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130552AbRA0WJy>; Sat, 27 Jan 2001 17:09:54 -0500
Received: from hibernia.clubi.ie ([212.17.32.129]:59528 "EHLO
	hibernia.jakma.org") by vger.kernel.org with ESMTP
	id <S130539AbRA0WJp>; Sat, 27 Jan 2001 17:09:45 -0500
Date: Sat, 27 Jan 2001 22:13:08 +0000 (GMT)
From: Paul Jakma <paul@clubi.ie>
X-X-Sender: <paul@fogarty.jakma.org>
To: Miquel van Smoorenburg <miquels@traveler.cistron-office.nl>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: routing between different subnets on same if.
In-Reply-To: <94v7nc$28g$1@ncc1701.cistron.net>
Message-ID: <Pine.LNX.4.31.0101272202060.2119-100000@fogarty.jakma.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 27 Jan 2001, Miquel van Smoorenburg wrote:

> Did you enable forwarding with echo 1 > /proc/sys/net/ipv4/ip_forward ?
>

yes. the machine already routes correctly between the 2 subnets and
the internet which is on a seperate interface. i also disabled
/proc/sys/net/ipv4/conf/all/send_redirects, to no avail.

the setup is so:

eth1: public IP
eth0: 192.168.0/24 and 192.168.3/24

routing table has correct entries, the 2 private subnets are routed
out thru dev eth0 with appropriate src. eventually i just installed a
seperate NIC for 192.168.3/24 and it worked as i expected it to.

however, i still need to know how to get linux 2.2 to do complete
forwarding of packets between different logical subnets that share
the same link.(i still have a couple more logical subnets that this
machine has to route).

So do i need a seperate NIC for each logical subnet? i'm sure i
don't, but i don't see what i'm supposed to do with the 'ip' command?
different scope or realm? or ... ??

> Mike.

regards,
-- 
Paul Jakma	paul@clubi.ie	paul@jakma.org
PGP5 key: http://www.clubi.ie/jakma/publickey.txt
-------------------------------------------
Fortune:
"Nuclear war can ruin your whole compile."
		-- Karl Lehenbauer

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
