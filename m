Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261688AbULZQUt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261688AbULZQUt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Dec 2004 11:20:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261693AbULZQUt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Dec 2004 11:20:49 -0500
Received: from cimice4.lam.cz ([212.71.168.94]:12418 "EHLO beton.cybernet.src")
	by vger.kernel.org with ESMTP id S261688AbULZQUo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Dec 2004 11:20:44 -0500
Date: Sun, 26 Dec 2004 16:21:07 +0000
From: Karel Kulhavy <clock@twibright.com>
To: "Dr. David Alan Gilbert" <gilbertd@treblig.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: How to hang 2.6.9 using serial port and FB console
Message-ID: <20041226162107.GB5859@beton.cybernet.src>
References: <20041226143118.GA5169@beton.cybernet.src> <20041226145334.GC1668@gallifrey> <20041226154321.GA5519@beton.cybernet.src> <20041226155350.GD1668@gallifrey>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041226155350.GD1668@gallifrey>
User-Agent: Mutt/1.4.2.1i
X-Orientation: Gay
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 26, 2004 at 03:53:50PM +0000, Dr. David Alan Gilbert wrote:
> * Karel Kulhavy (clock@twibright.com) wrote:
> > On Sun, Dec 26, 2004 at 02:53:35PM +0000, Dr. David Alan Gilbert wrote:
> > > Hi Karel,
> > >   I wonder - is the board sending a 'break' signal to the PC? I just
> > 
> > What board do you mean?
> 
> Your IR interface board.

The IR interface isn't a board. It's a HSDL3612 with 2 capacitors and one
resistor soldered in a box according to the recommended wiring from datasheet,
so technically, it's not a board, but an airwire construction ;-)

However it is not sending breaks, but rather various characters. As the kernel
seems to be set internally for echo cahracters going into the computer on the
transmit line again, and the characters are echoed by the infrared receiver
during transmission too, a character stream cycles infinitely there.

However kernel shouldn't hang even if you wired the serial input to an alien
spacecraft.

CL<
