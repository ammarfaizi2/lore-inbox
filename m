Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261749AbULPQzh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261749AbULPQzh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 11:55:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261744AbULPQyA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 11:54:00 -0500
Received: from zoot.lafn.ORG ([206.117.18.6]:41476 "EHLO zoot.lafn.org")
	by vger.kernel.org with ESMTP id S261749AbULPQx2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 11:53:28 -0500
Date: Thu, 16 Dec 2004 00:58:29 -0800
From: David Lawyer <dave@lafn.org>
To: Pavel Machek <pavel@suse.cz>
Cc: Park Lee <parklee_sel@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: Issue on connect 2 modems with a single phone line
Message-ID: <20041216085828.GG1189@lafn.org>
References: <20041215184206.43601.qmail@web51505.mail.yahoo.com> <20041216010138.GC6285@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041216010138.GC6285@elf.ucw.cz>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 16, 2004 at 02:01:38AM +0100, Pavel Machek wrote:
> Hi!
> 
> >   I want to try serial console in order to see the
> > complete Linux kernel oops. 
> >   I have 2 computers, one is a PC, and the other is a
> > Laptop. Unfortunately,my Laptop doesn't have a serial
> > port on it. But then, the each machine has a internal
> > serial modem respectively.
> >   Then, can I use a telephone line to directly connect
> > the two machines via their internal modems (i.e. One
> > end of the telephone line is plugged into The PC's
> > modem, and the other end is plugged into The Laptop's
> > modem directly), and let them do the same function as
> > two serial ports and a null modem can do? If it is,
> > How to achieve that?
> 
> You'd need phone exchange to do this. Most modems will not talk using
> simple cable. With 12V power supply and resistor phone exchange is
> quite easy to emulate, but...

Here's what I once wrote in Modem-HOWTO:

  Most modems are designed to be connected only to telephone lines and
  will not work over just a pair of wires.  This is because the
  telephone company supplies the telephone line with a 40-50 volt DC
  voltage which powers part of the modem.  Recall that ordinary
  conventional telephones are entirely powered by the voltage from the
  telephone company.  Without such a DC voltage, the modem lacks power
  and can't send out data.  Furthermore, the telephone company has
  special signals indicating a ring, line busy, etc.  Conventional
  modems expect and respond to these signals.

  One way around this is to make a simple power supply to emulate a
  telephone line.  See Connecting two computers using their modems,
  without a telephone line <http://www.jagshouse.com/modem.html>.  In
  most cases there are better way to connect computers together such as
  using network cards or just cables (null-modem) between the serial
  ports.  Using modems has the advantage of increasing the distance as
  compared to a null-modem cable, since it's using a twisted pair.  But
  it isn't nearly as fast as network cards.

			David Lawyer
