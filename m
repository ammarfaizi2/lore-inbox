Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263062AbRFGTvv>; Thu, 7 Jun 2001 15:51:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263058AbRFGTvm>; Thu, 7 Jun 2001 15:51:42 -0400
Received: from atlrel2.hp.com ([156.153.255.202]:50637 "HELO atlrel2.hp.com")
	by vger.kernel.org with SMTP id <S263038AbRFGTvg>;
	Thu, 7 Jun 2001 15:51:36 -0400
Message-ID: <3B1FDB64.1AB850CF@fc.hp.com>
Date: Thu, 07 Jun 2001 13:52:04 -0600
From: Khalid Aziz <khalid@fc.hp.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Nico Schottelius <nicos@pcsystems.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: scsi disk defect or kernel driver defect ?
In-Reply-To: <3B1FAA63.130E556A@pcsystems.de> <3B1FD67D.8DFDAE58@pcsystems.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nico Schottelius wrote:
> 
> Hi all!
> 
> The problem is solved, if I disconnect the hp streamer
> from the bus. I wonder why there is a problem.
> The aic7880 has two busses:
> 
> ultra/ ultrawide.
> 
> The ibm hard disk is connected to the uw port and is terminated.
> No other uw device is attached.
> 
> The hp streamer is also lonely on the ultra bus. I have
> no documentation for that device, so I don't know
> whether it is terminated nor if it is using parity.
> 
> Btw, can somebody explain what the parity bit does to me ?
> 
> Or does anybody have a hp c1536 streamer and can help me ?

Based upon the lspci output you posted earlier, aic7880 has a single
SCSI bus. So you must mean two internal connectors. Both of your devices
(HD and Tape) do show up on the same bus during scan. Since you have
connected devices to both connectors on the card, you must terminate
both devices. Sounds like you HD might be terminated. You need to
terminate tape drive as well. I do not have a C1536 handy, but if you
look at the back of the drive you should see 10 pins aligned
horizontally. They should all be labelled on the back panel and most
likely are (from left to right) - TP, 2, 1, 0, NC. TP is the pair of
Term Power Enable pins. Place a jumper over the leftmost two pins to
enable termination on the drive and try again.

-- 
Khalid

====================================================================
Khalid Aziz                             Linux Development Laboratory
(970)898-9214                                        Hewlett-Packard
khalid@fc.hp.com                                    Fort Collins, CO

Disclaimer: I do not speak for HP. These are my personal opinions.
