Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263766AbTCUTVy>; Fri, 21 Mar 2003 14:21:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263735AbTCUTUz>; Fri, 21 Mar 2003 14:20:55 -0500
Received: from freeside.toyota.com ([63.87.74.7]:53717 "EHLO
	freeside.toyota.com") by vger.kernel.org with ESMTP
	id <S263751AbTCUTUF>; Fri, 21 Mar 2003 14:20:05 -0500
Message-ID: <3E7B686F.9030102@tmsusa.com>
Date: Fri, 21 Mar 2003 11:30:55 -0800
From: jjs <jjs@tmsusa.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.2) Gecko/20030208 Netscape/7.02
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jochen Hein <jochen@jochen.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [2.5.65] tun not working
References: <873clgh6t7.fsf@jupiter.jochen.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just as a data point, tun itself works for
me on x86 - I use openvpn between my
lan and our remote pop3 server, so I'd
find out in a big hurry if it ever broke -

(currently running 2.5.65 on the vpn gw)

Sounds like a 390-sepecific issue, or
a hercule-specific issue?

Joe

Jochen Hein wrote:

>I'm using tun to connect my virtual S/390 from hercules to the local
>machine.  That works pretty well with 2.4, but with 2.5.65 hercules
>fails with:
>
>root@gswi1164:~# hercules -f /etc/hercules/hercules.cnf
>Hercules Version 2.16.5
>(c)Copyright 1999-2002 by Roger Bowler, Jan Jaeger, and others
>Built on Jul  9 2002 at 23:09:56
>Build information:
>  Debian
>  Modes: S/370 ESA/390 ESAME
>  Using setresuid() for setting privileges
>  HTTP Server support
>
>Running on Linux i686 2.5.65 #1 Thu Mar 20 19:11:34 CET 2003
>ckddasd: /mount/d/hercules/linux.191 cyls=300 heads=15 tracks=4500
>trklen=47616
>HHC894I Error setting MTU for tun: No such device
>HHC897I Error setting driving system IP addr for tun: No such device
>HHC897I Error setting Hercules IP addr for tun: No such device
>HHC897I Error setting netmask for tun: No such device
>HHC898I Error getting flags for tun: No such device
>HHC848I 0400 configuration failed: hercifc rc=4
>HHC038I Initialization failed for device 0400
>
>hercules uses /dev/net/tun to access the tun device.
>
>The module tun is loaded:
>
>dmesg:
>Universal TUN/TAP device driver 1.5 (C)1999-2002 Maxim Krasnyansky
>
>root@gswi1164:~# lsmod | grep tun
>tun                     6240  0
>
>Any idea why this fails?
>
>Jochen
>
>  
>


