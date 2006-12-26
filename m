Return-Path: <linux-kernel-owner+w=401wt.eu-S932861AbWLZXqt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932861AbWLZXqt (ORCPT <rfc822;w@1wt.eu>);
	Tue, 26 Dec 2006 18:46:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932866AbWLZXqt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Dec 2006 18:46:49 -0500
Received: from smtp101.sbc.mail.mud.yahoo.com ([68.142.198.200]:45251 "HELO
	smtp101.sbc.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S932861AbWLZXqs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Dec 2006 18:46:48 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:X-YMail-OSG:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=cpPaRC76nT8SQPUstnGCOFLNWHFRCqiGlD1D25wbHNtNUPDizT+bQvgYqAwan9kQYecpKeRXusJThvH+P7qHtttoavKiQ0Yz/3vTahqDklmJA66JOfHY0cdciN1kVk4W4VN49v3wac9Ng0EpV27kLvurYN7SdqqdVK9E1Kh4cxs=  ;
X-YMail-OSG: P1L0A7AVM1lMju18hvjquXmP8BKWLkSoKlciMtf5E348mEOmHwn4DKRIuKak_n_3nzM9GCg1TB8p39ZXRYWmOk3kCnjLl0_iD2X2MkY9OBHv0QTHTGVMacZDv7xzJWBqLNT2tPCePWFTmRd_dMulwxkH5ENn9CFwUGemGKPee7yiN0OqR83wCIDMt44n
From: David Brownell <david-b@pacbell.net>
To: linux-pm@lists.osdl.org
Subject: Re: [linux-pm] USB power usage
Date: Tue, 26 Dec 2006 15:46:44 -0800
User-Agent: KMail/1.7.1
Cc: Pavel Machek <pavel@ucw.cz>, Alan Stern <stern@rowland.harvard.edu>,
       kernel list <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44L0.0612252245310.29662-100000@netrider.rowland.org> <20061226144008.GA2062@elf.ucw.cz>
In-Reply-To: <20061226144008.GA2062@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612261546.45800.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > Couple of watts is not that bad, considering usb still eats 4W more
> > > than it should.
> > 
> > The USB autosuspend mechanism has been present for a while in -mm and is
> > included in 2.6.20-rc (although you have to turn on CONFIG_USB_SUSPEND,
> > which is off by default -- it would be nice to change that).

Call me paranoid, but I'd like to leave it this way for for a while yet
to shake out bugs.  There are some complicated interactions here, some
of which are hardware-specific, and we've only just started to really
shake out the associated problems.  (But yes, eventually we do want to
see that option go away, and this behavior be standard with PM enabled.)


> > Has anybody 
> > tried doing some real-world measurements to see if it actually makes a
> > significant improvement in power usage?
> 
> I did measurements while in -mm, and yes it helped. And yes,
> it works in 2.6.20-rc2, too:
> 
> ...
> 
> As you can see, it saves ~3.5W, which is huge deal on machine that
> eats 11W total.

Hey, that's great to know.  Thanks for sharing the figures!

And special thanks to Alan, for reworking (and re-reworking) relevant
parts of usbcore so that these power savings can (mostly) be automated.
ISTR the first patches supporting USB suspend/resume/wakeup landed in
about the 2.6.10 kernel, and things look a LOT better than back then.

- Dave


> (X60 owners, get 2.6.20, and _disable that bluetooth_ while not in use).
> 									Pavel
