Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267507AbTA3ODs>; Thu, 30 Jan 2003 09:03:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267509AbTA3ODs>; Thu, 30 Jan 2003 09:03:48 -0500
Received: from ns.suse.de ([213.95.15.193]:63250 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S267507AbTA3ODr>;
	Thu, 30 Jan 2003 09:03:47 -0500
Date: Thu, 30 Jan 2003 15:13:08 +0100
From: Stefan Reinauer <stepan@suse.de>
To: John Bradford <john@grabjohn.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Bootscreen suggestions that don't involve kernel modifications
Message-ID: <20030130141308.GD6066@suse.de>
References: <398E93A81CC5D311901600A0C9F2928946939B@cubuss2> <200301291348.h0TDmHfu001672@darkstar.example.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200301291348.h0TDmHfu001672@darkstar.example.net>
User-Agent: Mutt/1.4i
X-Message-Flag: Life is too short to use a crappy OS.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* John Bradford <john@grabjohn.com> [030129 14:48]:
> I don't think it is appropriate to include graphical boot screen
> capabilities in the kernel.  There are better ways to achieve what you
> want to do:
> 
> * Verbose start-up messages on the console
> Leave things how they are

agreed 

> * No start up messages on the console
> Either use the quiet option, or re-direct the output to serial console
> or another virtual terminal.

> * Graphical boot screen
> Do not have the VGA card configured as a console device at all.  Set
> the console output to a serial port for debugging, if necessary.  Have
> the bootloader configure the VGA card, and display the graphic.  Boot
> in to X, and let X re-configure the VGA card at startup.

Some method to switch between verbose and non-verbose mode on the screen
interactively would be useful and it should not loose old messages. Not
have vga configured as console device kind of gives you a hard time
here. My bootsplash patch takes care of this by only "hiding" the text
instead of not redirect it to vga, so the text buffers are valid all the
time and visible as soon as you switch them on

Stefan
  
-- 
The use of COBOL cripples the mind; its teaching should, therefore, be
regarded as a criminal offense.                      -- E. W. Dijkstra
