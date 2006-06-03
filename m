Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751637AbWFCWAr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751637AbWFCWAr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jun 2006 18:00:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751633AbWFCWAr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jun 2006 18:00:47 -0400
Received: from perninha.conectiva.com.br ([200.140.247.100]:43650 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S1751401AbWFCWAq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jun 2006 18:00:46 -0400
Date: Sat, 3 Jun 2006 19:03:52 -0300
From: "Luiz Fernando N. Capitulino" <lcapitulino@mandriva.com.br>
To: Greg KH <gregkh@suse.de>
Cc: rmk@arm.linux.org.uk, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: [PATCH RFC 0/11] usbserial: Serial Core port.
Message-ID: <20060603190352.5249c934@home.brethil>
In-Reply-To: <20060602204839.GA31251@suse.de>
References: <1149217397133-git-send-email-lcapitulino@mandriva.com.br>
	<20060602204839.GA31251@suse.de>
Organization: Mandriva
X-Mailer: Sylpheed-Claws 1.0.4 (GTK+ 1.2.10; x86_64-mandriva-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Jun 2006 13:48:39 -0700
Greg KH <gregkh@suse.de> wrote:

| On Fri, Jun 02, 2006 at 12:03:06AM -0300, Luiz Fernando N.Capitulino wrote:
| > 
| >  Hi folks.
| > 
| >  This patch series is my first attempt to port the USB-Serial layer to the
| > Serial Core API. Currently USB-Serial uses the TTY layer directly, duplicating
| > code and solutions from the Serial Core implementation.
| > 
| >  The final (ported) USB-Serial code is simpler and cleaner. Now I'd like to know
| > whether I'm doing it right or not.
| > 
| >  Note that this is a work in progress though. I've only ported the USB-Serial
| > core and one of its drivers, the pl2303 one.
| > 
| >  Most of my questions and design decisions are adressed in the patches, please
| > refer to them for details.
| 
| Nice first cut at this.  But please try to also convert 2 other drivers
| at the same time to make sure that the model is right.  I'd suggest the
| io_edgeport and the funsoft drivers.  io_edgeport because it is very
| complex in that it doesn't share a single bulk in/out pair for every
| port, but multiplexes them all through one pipe.  And funsoft because we
| want to still be able to write usb-serial drivers that are this simple.

 I'd love to do that but, unfortunatally, USB-Serial cables are too
expensive in Brazil (and I have no sure if I can find these ones in
Curitiba).

 The Prolific 2303 cables I have were lent by Mandriva.

 Couldn't someone send these cables for me in Brazil? I can send they
back when the port is finished.

| I agree with most of Pete's comments and like the general idea of moving
| the usb-serial core to be more like libata (provider of helper
| functions, not getting in the middle of everything).  I'll wait for your
| next cut to provide specific code comments.

 Hope to have something to show in the next days.

-- 
Luiz Fernando N. Capitulino
