Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129210AbQLEPw2>; Tue, 5 Dec 2000 10:52:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129226AbQLEPwT>; Tue, 5 Dec 2000 10:52:19 -0500
Received: from www.microgate.com ([216.30.46.105]:44305 "EHLO
	sol.microgate.com") by vger.kernel.org with ESMTP
	id <S129210AbQLEPwB>; Tue, 5 Dec 2000 10:52:01 -0500
Message-ID: <002101c05ece$ac46aa00$0c00a8c0@diemos>
From: "Paul Fulghum" <paulkf@microgate.com>
To: "Ivan Passos" <lists@cyclades.com>,
        "Linux Kernel List" <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.10.10012042135090.5269-100000@main.cyclades.com>
Subject: Re: [RFC-2] Configuring Synchronous Interfaces in Linux
Date: Tue, 5 Dec 2000 09:18:50 -0600
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.2919.6700
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2919.6700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Ivan Passos" <lists@cyclades.com>
> the parameters we currently need to configure on our board (the
> PC300) are as follows:
>
> - Media: V.35, RS-232, X.21, T1, E1
> - Protocol: Frame Relay, (Cisco)-HDLC, PPP, X.25 (not sure whether that is
>             already supported by the 'hw' option)
> - Clock: 'ext' (or 0, which implies external clock) or some numeric value
>          > 0 (which implies internal clock); setting it to 'int' would set
>          it to some fixed numeric value > 0 (useful for T1/E1 links, just
>          to indicate master clock as opposed to slave or 'ext' clock)
> - Frame Relay only:
> - End type: DCE or DTE (maybe this applies to other interface
>                     types as well)
> - DLCI: DLC number for the interface
> - T1/E1 only:
> - Line code:
> - Frame mode:
> - LBO (T1 only): line-build-out
> - Rx Sensitivity: short-haul or long-haul
> - Active channels: mask that represents the possible 24/32
>                            channels (timeslots) on a T1/E1 line

Some others (less common):
- Serial Encoding (NRZ/NRZI)
- Transmit Idle Mode (Flags/Marks)
- Transmit Preamble

> having a unified interface and making the drivers compliant to it is not
that hard
> and surely would help users to dump the currently ridiculous set of
> individual config. tools for these cards (yes, we currently have our own
> pc300cfg, along with the -- not absolute -- "standard" sethdlc utility).
>
> I'm willing to go for this implementation, but I wanted to know first:
> - whether ifconfig is the right place to do it;
> - where I should create the new ioctl's to handle these new parameters.

The ioctl interface is more universally applicable for my driver
(synclink.c) which offers both the network oriented sync interface
*and* a tty oriented sync interface.

Paul Fulghum paulkf@microgate.com
Microgate Corporation www.microgate.com


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
