Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265305AbTAXUaz>; Fri, 24 Jan 2003 15:30:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265373AbTAXUay>; Fri, 24 Jan 2003 15:30:54 -0500
Received: from potnoodle.l-w.net ([198.161.91.10]:33751 "EHLO
	potnoodle.l-w.net") by vger.kernel.org with ESMTP
	id <S265305AbTAXUay>; Fri, 24 Jan 2003 15:30:54 -0500
Date: Fri, 24 Jan 2003 13:46:10 -0700 (MST)
From: lost@l-w.net
To: linux-kernel@vger.kernel.org
Subject: Re: SSH Hangs in 2.5.59 and 2.5.55 but not 2.4.x, through Cisco PIX
In-Reply-To: <Pine.LNX.4.44.0301241237160.29548-100000@harappa.oldtrail.reston.va.us>
Message-ID: <Pine.LNX.4.51.0301241337080.28717@potnoodle.l-w.net>
References: <Pine.LNX.4.44.0301241237160.29548-100000@harappa.oldtrail.reston.va.us>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Jan 2003, David C Niemi wrote:

> I have been experiencing some baffling SSH client hangs under 2.5.59 (and
> 55) in which the session totally hangs up after I have typed (typically)
> 10-100 characters.  Right before it hangs permanently, a character is
> echo'd back to the screen several seconds late.  Interestingly, data due
> back for my client which is initiated by the server side does make it, I
> just can't type anything further.

<snip>

> Neither "ifconfig" nor dmesg show *any* errors whatsoever.
>
> Anyone else seeing SSH client hangs to nonlocal hosts under 2.5.59?

I'm seeing the same problem with a D-Link NIC (8139too driver). Exact same
symptoms - a delayed echo followed by no further echos. Checking netstat
shows an output queue for the socket but it never transmits anything.
Messages echoed by the remote server also make it through the connection.

The same problem does not occur using "telnet" to connect to the remote
host.


William Astle
finger lost@l-w.net for further information

Geek Code V3.12: GCS/M/S d- s+:+ !a C++ UL++++$ P++ L+++ !E W++ !N w--- !O
!M PS PE V-- Y+ PGP t+@ 5++ X !R tv+@ b+++@ !DI D? G e++ h+ y?
