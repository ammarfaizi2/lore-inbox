Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263697AbUBOCca (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Feb 2004 21:32:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263711AbUBOCca
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Feb 2004 21:32:30 -0500
Received: from atari.saturn5.com ([209.237.231.200]:58024 "HELO
	atari.saturn5.com") by vger.kernel.org with SMTP id S263697AbUBOCc2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Feb 2004 21:32:28 -0500
Date: Sat, 14 Feb 2004 18:32:27 -0800
From: Steve Simitzis <steve@saturn5.com>
To: "Feldman, Scott" <scott.feldman@intel.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: e1000 problems in 2.6.x
Message-ID: <20040215023226.GE1040@saturn5.com>
References: <C6F5CF431189FA4CBAEC9E7DD5441E0102229F6F@orsmsx402.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C6F5CF431189FA4CBAEC9E7DD5441E0102229F6F@orsmsx402.jf.intel.com>
User-Agent: Mutt/1.3.28i
X-gestalt: heart, barbed wire
X-Cat: calico
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

i should have mentioned in my email that i tried every combination of
settings: auto-neg on the box and forced on the switch, both forced
(to the same settings, of course), forced on the box with auto-neg on
the switch, and auto-neg on both sides. in all cases, the result was
the same: RX packet errors and the same watchdog messages. what i thought
was particularly strange was that the switch refused to auto-negotiate
full duplex.

(someone on another list suggested to try booting with the noapic
option, which i tried for good measure, even though i don't see
how that could have helped. again, no improvement.)

i was initially tempted to assume they were hardware problems, until
i noticed that the problems only appeared when running a 2.6 kernel.
also, the machines are only a few months old, so i'm assuming that
all the hardware is modern enough to do the right thing.

if there's anything you'd recommend trying out, please let me know.
i considered trying to run the 2.4.22 driver in a 2.6 installation,
but i didn't know if any of the driver code depended on anything else
elsewhere in the kernel source.

On 02/14/04, "Feldman, Scott" <scott.feldman@intel.com> wrote: 

> > another oddity is that even after forcing my interfaces to 
> > 100 Mbps full duplex, my switch is reporting half duplex. 
> > again, this only happens in 2.6.x. when running 2.4.22, full 
> > duplex is properly negotiated between the e1000 and my switch.
> 
> Are you forcing both the e1000 interfaces and the switch ports to the
> same forced settings?  A duplex mismatch would cause problems, but I'm
> not sure why this is happening for 2.6 only.  What happens if you don't
> force settings, and just rely on autoneg?  (Again, on both ends of the
> wire).
> 
> -scott

-- 

steve simitzis : /sim' - i - jees/
          pala : saturn5 productions
 www.steve.org : 415.282.9979
  hath the daemon spawn no fire?

