Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262363AbVAENPd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262363AbVAENPd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 08:15:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262361AbVAENPd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 08:15:33 -0500
Received: from eurogra4543-2.clients.easynet.fr ([212.180.52.86]:5078 "HELO
	server5.heliogroup.fr") by vger.kernel.org with SMTP
	id S262363AbVAENPX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 08:15:23 -0500
From: Hubert Tonneau <hubert.tonneau@fullpliant.org>
To: Francois Romieu <romieu@fr.zoreil.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.10 TCP troubles
Date: Wed, 05 Jan 2005 12:50:57 GMT
Message-ID: <0508ECY12@server5.heliogroup.fr>
X-Mailer: Pliant 93
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Francois Romieu wrote:
>
> Hubert Tonneau <hubert.tonneau@fullpliant.org> :
> > Here is the senario:
> > the Linux machine is writting through libsmbclient
> > to an OSX machine running Samba
> > 
> > Switching the Linux machine from 2.6.8 to 2.6.10 made the network speed
> > drop drastically: 20 seconds with 2.6.8, 800 seconds with 2.6.10
> 
> Are there any differences in:
> - dmesg output

No.

> - /proc/interrupts 
> - disk traffic
> - tcpdump output (of course there will)

I cannot see anymore since it's our main production server, so I switched
back at once. Sorry about that. Anyway, both network traffic and disk traffic
was very low.

The problem is not related to the Linux machine beeing slow because the network
exchange was very fast with other gigabit with flow control connected machines.
The problem seems to me to be related to the way the TCP layer is handling small
troubles (probably lost packets on the Mac side because the Linux machine is
gigabit connected to the switch, with flow control enabled, and the Mac is
100 Mbps connected, full duplex, but without flow control).

Please notice that the Linux machine is the client, and is pushing files to
the Mac, which is quite unusual. If the Mac was the client pulling files from
the PC, I bet things might be very different.

