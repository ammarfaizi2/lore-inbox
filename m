Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290685AbSBXSuu>; Sun, 24 Feb 2002 13:50:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290689AbSBXSuk>; Sun, 24 Feb 2002 13:50:40 -0500
Received: from cs24344-28.austin.rr.com ([24.243.44.28]:28683 "EHLO
	explorer.dummynet") by vger.kernel.org with ESMTP
	id <S290685AbSBXSua>; Sun, 24 Feb 2002 13:50:30 -0500
Date: Sun, 24 Feb 2002 12:49:43 -0600
From: Dan Hopper <dbhopper@austin.rr.com>
To: Johannes Erdfelt <johannes@erdfelt.com>
Cc: Greg KH <greg@kroah.com>, Patrick Mochel <mochel@osdl.org>,
        Pierre Rousselet <pierre.rousselet@wanadoo.fr>,
        lkml <linux-kernel@vger.kernel.org>,
        linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] Re: 2.5.5-pre1 rmmod usb-uhci hangs
Message-ID: <20020224184943.GA2492@yoda.dummynet>
Mail-Followup-To: Dan Hopper <dbhopper@austin.rr.com>,
	Johannes Erdfelt <johannes@erdfelt.com>, Greg KH <greg@kroah.com>,
	Patrick Mochel <mochel@osdl.org>,
	Pierre Rousselet <pierre.rousselet@wanadoo.fr>,
	lkml <linux-kernel@vger.kernel.org>,
	linux-usb-devel@lists.sourceforge.net
In-Reply-To: <fa.n7cofbv.1him3j@ifi.uio.no> <fa.dsb79pv.on84ii@ifi.uio.no> <20020224025411.GA2418@yoda.dummynet> <20020224062124.GB15060@kroah.com> <20020224063915.GA2799@yoda.dummynet> <20020224064931.GD15060@kroah.com> <20020224173711.GA2355@yoda.dummynet> <20020224125055.A5232@sventech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020224125055.A5232@sventech.com>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Johannes Erdfelt <johannes@erdfelt.com> remarked:
> Hmm, that is interesting. I wonder what is going on with it. Are you
> using the scanner kernel driver?

Yes.  And sane 1.0.5.  FWIW, the command I'm using that stutters
with uhci and not usb-uhci is:

scanimage --mode lineart --resolution 600 -x 203.2 -y 271.0 \
	--contrast 0 --brightness 0  > /tmp/copy.pbm

That results in a 3848837 byte file in about 37 seconds with
usb-uhci.  Not exactly pushing the USB 1.1 bandwidth.  (unless
there's a significant discrepancy between the bits coming from the
scanner and those scanimage dumps to the file, I suppose)

(Incidentally, I still haven't worked out how to get it to properly
autoload the scanner driver at startup.  It loads the USB printer
driver fine, but not the scanner, which I have to manually modprobe
myself.  I've started fiddling with post-install scripts with
sleeps, but haven't worked out the magic yet.)

Dan
