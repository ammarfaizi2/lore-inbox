Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315208AbSDWNzs>; Tue, 23 Apr 2002 09:55:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315209AbSDWNzq>; Tue, 23 Apr 2002 09:55:46 -0400
Received: from mail44-s.fg.online.no ([148.122.161.44]:7866 "EHLO
	mail44.fg.online.no") by vger.kernel.org with ESMTP
	id <S315208AbSDWNzo>; Tue, 23 Apr 2002 09:55:44 -0400
Date: Tue, 23 Apr 2002 16:55:59 +0200
From: Dag Bakke <dag@bakke.com>
To: linux-kernel@vger.kernel.org
Subject: Re: BUG: 2 NICs on same network
Message-ID: <20020423165559.G18305@dagb>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 23, 2002 at 11:39:35AM +0200, Frank Louwers wrote:
> Our situation is this: we have a server with 2 nics, each with a
> different IP on the same network, connected to the same switch. Let's
> assume eth0 has ip 1.2.3.1 and eth1 has 1.2.3.2, with a both with a
> netmask of 255.255.255.0.
>
> Now the strange thing is that traffic for 1.2.3.2 arrives at eth0 no
> matter what!
>
> Even if we disconnect the cable for eth1, 1.2.3.2 still replies to
> pings, ssh, web, ...

Do:
netstat -rn

and you will (should?) understand why.

See:
/usr/src/linux/Documentation/networking/bonding.txt

to (possibly) achieve what you want..

Dag B
