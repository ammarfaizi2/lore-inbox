Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262849AbULRHrO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262849AbULRHrO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Dec 2004 02:47:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262847AbULRHrO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Dec 2004 02:47:14 -0500
Received: from penta.pentaserver.com ([216.74.97.66]:54410 "EHLO
	penta.pentaserver.com") by vger.kernel.org with ESMTP
	id S262852AbULRHqn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Dec 2004 02:46:43 -0500
From: Manu Abraham <manu@kromtek.com>
Reply-To: manu@kromtek.com
Organization: Kromtek Systems
To: Brad Campbell <brad@wasp.net.au>
Subject: Re: Issue on connect 2 modems with a single phone line
Date: Sat, 18 Dec 2004 11:45:59 +0400
User-Agent: KMail/1.6.2
Cc: David Lawyer <dave@lafn.org>, Pavel Machek <pavel@suse.cz>,
       Park Lee <parklee_sel@yahoo.com>, linux-kernel@vger.kernel.org
References: <20041215184206.43601.qmail@web51505.mail.yahoo.com> <20041216085828.GG1189@lafn.org> <41C3D5AD.7090507@wasp.net.au>
In-Reply-To: <41C3D5AD.7090507@wasp.net.au>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200412181145.59211.manu@kromtek.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - penta.pentaserver.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - kromtek.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat December 18 2004 11:01 am, Brad Campbell wrote:
> David Lawyer wrote:
> > On Thu, Dec 16, 2004 at 02:01:38AM +0100, Pavel Machek wrote:
> >>Hi!
> >>
> >>>  I want to try serial console in order to see the
> >>>complete Linux kernel oops.
> >>>  I have 2 computers, one is a PC, and the other is a
> >>>Laptop. Unfortunately,my Laptop doesn't have a serial
> >>>port on it. But then, the each machine has a internal
> >>>serial modem respectively.
> >>>  Then, can I use a telephone line to directly connect
> >>>the two machines via their internal modems (i.e. One
> >>>end of the telephone line is plugged into The PC's
> >>>modem, and the other end is plugged into The Laptop's
> >>>modem directly), and let them do the same function as
> >>>two serial ports and a null modem can do? If it is,
> >>>How to achieve that?
> >>
> >>You'd need phone exchange to do this. Most modems will not talk using
> >>simple cable. With 12V power supply and resistor phone exchange is
> >>quite easy to emulate, but...
> >
> > Here's what I once wrote in Modem-HOWTO:
> >
> >   Most modems are designed to be connected only to telephone lines and
> >   will not work over just a pair of wires.  This is because the
> >   telephone company supplies the telephone line with a 40-50 volt DC
> >   voltage which powers part of the modem.  Recall that ordinary
> >   conventional telephones are entirely powered by the voltage from the
> >   telephone company.  Without such a DC voltage, the modem lacks power
> >   and can't send out data.  Furthermore, the telephone company has
> >   special signals indicating a ring, line busy, etc.  Conventional
> >   modems expect and respond to these signals.
>
> I have used analogue modems back to back for years and have *never* come
> across a modem that sourced anything other than it's ringing signal (via an
> opto) from the phone line. Every single modem I have here will talk to the
> others over a straight telephone cable.
What about power ? The opto-coupler will not work without power.

>
> Analogue modems use a line transformer to couple to the phone network
> usually with a decoupling capacitor on the phone end of the network to
> prevent large current flows through the transformer. They use a standard AC
The capacitor is used to prevent DC saturation of the transformer core rather 
than doing current limiting, A capacitor cannot do current limiting. When the 
lag changes by changing the capacitance value,  general concept is that a 
capacitor can limit current which is very much wrong.

Manu

> analogue signal. Nothing more than an audio transformer linkage.
>
> Now, sometimes a modem needs coaxing to ignore the lack of dial/call
> progress tones, but they should always talk to each other regardless of
> line voltage.
>
> ATA on one end and ATD on the other will normally get them talking.
> As a test I just looped my internal AMR winmodem to my Xircom Realport V90
> modem and got a solid 28.8k link. No problem.
>
> If the fluid is salty enough you could probably get analogue modems to talk
> over wet string (I have certainly passed RS485 over wet string before).
