Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317396AbSIIP2u>; Mon, 9 Sep 2002 11:28:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317399AbSIIP2u>; Mon, 9 Sep 2002 11:28:50 -0400
Received: from chaos.analogic.com ([204.178.40.224]:27778 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S317396AbSIIP2s>; Mon, 9 Sep 2002 11:28:48 -0400
Date: Mon, 9 Sep 2002 11:35:34 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: "Rechenberg, Andrew" <ARechenberg@shermanfinancialgroup.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: syslogd: recvfrom inet: resource temporarily unavailable
In-Reply-To: <CDF05CB9FCA0C845B9778F9E463C476101FC76@cinshrexc01.shermfin.com>
Message-ID: <Pine.LNX.3.95.1020909113020.16494B-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 Sep 2002, Rechenberg, Andrew wrote:

> I am using a Dell PowerEdge 2300 running Red Hat Linux 7.2 for a
> syslog consolidation machine.  It is also our network monitoring
> system and it runs Cricket, NMIS, and cflowd and Flowscan for Cisco
> NetFlow collection.
> 
[SNIPPED]
> Lately the machine has been running extremely slow whenever anything
> that happens on the box needs to syslog something (su, logins, etc.). 
> I've checked /var/log/messages and it repeatedly contains the
> following line:
[SNIPPED]

> ESTABLISHED
> udp        0      0 0.0.0.0:32768           0.0.0.0:*
> udp    41056      0 0.0.0.0:514             0.0.0.0:*
> udp        0      0 0.0.0.0:2055            0.0.0.0:*
> udp        0      0 0.0.0.0:69              0.0.0.0:*
> udp        0      0 0.0.0.0:69              0.0.0.0:*
> udp        0      0 0.0.0.0:734             0.0.0.0:*
> udp        0      0 0.0.0.0:111             0.0.0.0:*

I think that all these 0.0.0.0 addresses are handled just like
broadcast addresses, i.e., your driver will get interrupted for
every packet on the wire. If so, this is not good and will severely
affect the performance of your computer. I think you need a real
"network(ed)" address for these, i.e., 10.0.0.1, 10.0.0.2, etc.
In the "olden" days, 0.0.0.0 was the broadcast address and I think
that Linux still maintains that compatibility.


> Andrew Rechenberg
> Infrastructure Team, Sherman Financial Group
> arechenberg@shermanfinancialgroup.com
> Phone: 513.677.7809
> Fax:   513.677.7838
> -


Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
The US military has given us many words, FUBAR, SNAFU, now ENRON.
Yes, top management were graduates of West Point and Annapolis.

