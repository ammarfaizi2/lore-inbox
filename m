Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261933AbULPOAy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261933AbULPOAy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 09:00:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261932AbULPOAy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 09:00:54 -0500
Received: from h64-5-255-70.gtconnect.net ([64.5.255.70]:58884 "EHLO
	jingo.impsolweb.ca") by vger.kernel.org with ESMTP id S261933AbULPN73
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 08:59:29 -0500
Date: Thu, 16 Dec 2004 09:59:19 -0400 (AST)
From: Steve Bromwich <kernel@fop.ns.ca>
To: Park Lee <parklee_sel@yahoo.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Issue on connect 2 modems with a single phone line 
In-Reply-To: <20041215184206.43601.qmail@web51505.mail.yahoo.com>
Message-ID: <Pine.LNX.4.58.0412160950070.17472@brain.fop.ns.ca>
References: <20041215184206.43601.qmail@web51505.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Dec 2004, Park Lee wrote:

> Hi,
>   I want to try serial console in order to see the
> complete Linux kernel oops.
>   I have 2 computers, one is a PC, and the other is a
> Laptop. Unfortunately,my Laptop doesn't have a serial
> port on it. But then, the each machine has a internal
> serial modem respectively.
>   Then, can I use a telephone line to directly connect
> the two machines via their internal modems (i.e. One
> end of the telephone line is plugged into The PC's
> modem, and the other end is plugged into The Laptop's
> modem directly), and let them do the same function as
> two serial ports and a null modem can do? If it is,
> How to achieve that?

Hi,

This used to come up every now and then on the UK USR HST Fidonet echo.
You can do this back to back with a crossover phone cable with some
modems. Other modems require a circuit with a battery inline and resistors
(see http://www.repairfaq.org/ELE/F_ASCII_Schem_Tel.html#ASCIISCHEMTEL_010
for an example of the sort of thing you'd need, but I'd imagine you'll
need to change it for your local standards). You will need to set up your
modem on your laptop to auto-answer and save to NVRAM (usually ATS0=1&W),
and also disable DTR detection and again save to NVRAM (usually AT&D0&W).
On the other end you'll need to disable dial tone detection (usually ATX3)
and then dial a dummy number (ATDT0).

As was already noted, if the modem in the laptop is a softmodem you won't
be able to do this.

Cheers, Steve
