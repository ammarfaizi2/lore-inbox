Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275671AbTHODD6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Aug 2003 23:03:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275672AbTHODD6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Aug 2003 23:03:58 -0400
Received: from chromatix.demon.co.uk ([80.177.102.173]:60106 "EHLO
	lithium.chromatix.org.uk") by vger.kernel.org with ESMTP
	id S275671AbTHODD5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Aug 2003 23:03:57 -0400
Date: Fri, 15 Aug 2003 02:42:33 +0100
Subject: Re: agpgart failure on KT400
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v552)
Cc: Dave Jones <davej@redhat.com>, linux-kernel@vger.kernel.org
To: Robert Toole <tooler@tooleweb.homelinux.com>
From: Jonathan Morton <chromi@chromatix.demon.co.uk>
In-Reply-To: <3F3C2DA0.1030504@tooleweb.homelinux.com>
Message-Id: <BD8AF95A-CEC1-11D7-A88B-003065664B7C@chromatix.demon.co.uk>
Content-Transfer-Encoding: 7bit
X-Mailer: Apple Mail (2.552)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> But this seems to be a pretty big thing to leave out of the production 
> Kernel. Unless Red Hat and other distros are planning to use 2.6 in 
> their next release, there are a lot of these KT400 MBs out there. My 
> local computer reseller was selling 10 to 20 of these boards for every 
> one of any other AMD chipset right up until VIA released the KT600.

This, I think, is a pretty good point.

Surely it's not too big a job to get basic, generic AGP3 support into 
2.4, even if it's not optimised?  If it's non-trivial to make all AGP3 
features work in 2.4, then it's reasonable to require 2.6 for "better 
performance".

To be honest, I'd at least expect a fallback to AGP2 for hardware that 
can support it, such as KT400.  The Windows drivers for my ATI card can 
tell the hardware to drop to "AGP 4x" (which I believe implies AGP2 - I 
could be wrong), and the card *did* work correctly with the KT266A 
chipset I was using before.

> Yes, I could use 2.6-x and help test that, but like so many people, I 
> need to have something reliable so I can get some work done.

FWIW, I installed 2.6.0-test3 and it seems to work well.  After 
grabbing a later version of the ATI drivers (which are needed for 2.6 
compatibility), the AGP was set up correctly and I'm back in X.  I'm 
not seeing any stability problems so far.

However, I did encounter a compilation problem with one of the USB 
device drivers - not a major problem at present since that particular 
device is attached to a different machine - but it does show that 2.6 
isn't ready for primetime yet.  The major distros aren't going to make 
that switch for a while.

--------------------------------------------------------------
from:     Jonathan "Chromatix" Morton
mail:     chromi@chromatix.demon.co.uk
website:  http://www.chromatix.uklinux.net/
tagline:  The key to knowledge is not to rely on people to teach you it.

