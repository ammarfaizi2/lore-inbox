Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263207AbRE2EqD>; Tue, 29 May 2001 00:46:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263208AbRE2Epx>; Tue, 29 May 2001 00:45:53 -0400
Received: from [209.226.175.53] ([209.226.175.53]:16296 "EHLO
	tomts9-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S263207AbRE2Epr>; Tue, 29 May 2001 00:45:47 -0400
Subject: Re: (via-rhine.c problem) 2.4.5 and pppd/pppoe
From: Daniel Rose <daniel.rose@datalinesolutions.com>
To: linux-kernel@vger.kernel.org
In-Reply-To: <991081135.1399.0.camel@rocket.novakayne.net>
In-Reply-To: <991081135.1399.0.camel@rocket.novakayne.net>
Content-Type: text/plain
X-Mailer: Evolution/0.10 (Preview Release)
Date: 29 May 2001 00:34:29 -0400
Message-Id: <991110870.912.3.camel@rocket>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, I have decided the problem lays in via-rhine.c, the ethernet driver
for my card. The second boot finds the mac address as 00's all the time,
regardless of whether the driver is compiled as a module, or monolith.

On 28 May 2001 16:18:55 -0400, Daniel Rose wrote:
> 
> Hello,
> I'm having problems with 2.4.5 and my pppoe connection.
> The kernel compiles fine, and works fine too, until I reboot, at which
> time it decides it no longer wants to work, and any time I attempt to
> call my start-pppoe script, i get:
> 
> May 28 15:54:28 rocket pppd[3091]: pppd 2.4.1 started by root, uid 0
> May 28 15:54:28 rocket pppd[3091]: Using interface ppp0
> May 28 15:54:28 rocket pppd[3091]: Connect: ppp0 <--> /dev/ttyp0
> May 28 15:54:43 rocket pppd[3091]: Hangup (SIGHUP)
> May 28 15:54:43 rocket pppd[3091]: Modem hangup
> May 28 15:54:43 rocket pppd[3091]: Connection terminated.
> May 28 15:54:44 rocket pppd[3091]: Exit.
> 
> I am assuming that this is because of my eth0, which shows in ifconfig:
> 
> eth0      Link encap:Ethernet  HWaddr 00:00:00:00:00:00 (it's using
> via-rhine chipset, compiled into kernel, not a module)
> 
> This _only_ occurs after I reboot (ie. i can start up the new 2.4.5
> kernel and work it perfectly once, then reboot and it doesnt work)
> 
> Anybody have any ideas?
> 
> Thanks,
> 
> Daniel Rose
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/



