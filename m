Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135659AbRD1WMU>; Sat, 28 Apr 2001 18:12:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135660AbRD1WMK>; Sat, 28 Apr 2001 18:12:10 -0400
Received: from cox.ee.ed.ac.uk ([129.215.80.253]:57776 "EHLO
	postbox.ee.ed.ac.uk") by vger.kernel.org with ESMTP
	id <S135659AbRD1WMF>; Sat, 28 Apr 2001 18:12:05 -0400
X-At: Department of Electrical Engineering, The University of Edinburgh
Date: Sat, 28 Apr 2001 23:11:51 +0100
From: Michael F Gordon <Michael.Gordon@ee.ed.ac.uk>
To: David Lang <david.lang@digitalinsight.com>
Cc: Garett Spencley <gspen@home.com>,
        Michael F Gordon <Michael.Gordon@ee.ed.ac.uk>,
        linux-kernel@vger.kernel.org
Subject: Re: 2.4.4 breaks dhcpcd with Realtek 8139
Message-ID: <20010428231151.A11841@ee.ed.ac.uk>
In-Reply-To: <Pine.LNX.4.30.0104281142520.3423-100000@localhost.localdomain> <Pine.LNX.4.33.0104281126570.16046-100000@dlang.diginsite.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.13i
In-Reply-To: <Pine.LNX.4.33.0104281126570.16046-100000@dlang.diginsite.com>; from david.lang@digitalinsight.com on Sat, Apr 28, 2001 at 11:29:15AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 28, 2001 at 11:29:15AM -0700, David Lang wrote:
> what sort of switch are you plugged into? some Cisco switches have a
> 'feature' that ignores all traffic from a port for X seconds after a
> machine is plugged in / powered on on a port (they claim somehting about
> preventing loops) it may be that the new kernel now boots up faster then
> the old one so that the DHCP request is lost in the switch, a few seconds
> later when you do it by hand the swich has enabled your port and
> everything works.

I'm plugged in to a cable modem, with the DHCP server at the ISP.  The
server requires the MAC address to be registered, so sending the DHCP
request with a different MAC address could cause the symptoms.  I doubt
it's a timing problem - replacing the 8139 driver with the 2.4.3 version
but otherwise using the distributed 2.4.4 makes DHCP work as expected.


Michael Gordon
