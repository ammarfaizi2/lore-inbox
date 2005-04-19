Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261172AbVDSQcq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261172AbVDSQcq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Apr 2005 12:32:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261621AbVDSQcq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Apr 2005 12:32:46 -0400
Received: from ext-ch1gw-7.online-age.net ([64.37.194.15]:9671 "EHLO
	ext-ch1gw-7.online-age.net") by vger.kernel.org with ESMTP
	id S261172AbVDSQcn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Apr 2005 12:32:43 -0400
Date: Tue, 19 Apr 2005 18:32:21 +0200
From: Karl Kiniger <karl.kiniger@med.ge.com>
To: Willy Tarreau <willy@w.ods.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.30 Oops when connecting external USB hard drive
Message-ID: <20050419163221.GA23982@wszip-kinigka.euro.med.ge.com>
References: <20050412173911.GA21311@wszip-kinigka.euro.med.ge.com> <20050414050243.GF7858@alpha.home.local> <20050415125048.GA21076@wszip-kinigka.euro.med.ge.com> <20050416055305.GG7858@alpha.home.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050416055305.GG7858@alpha.home.local>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 16, 2005 at 07:53:05AM +0200, Willy Tarreau wrote:
> On Fri, Apr 15, 2005 at 02:50:48PM +0200, Karl Kiniger wrote:
> > On Thu, Apr 14, 2005 at 07:02:44AM +0200, Willy Tarreau wrote:
> > > You may try to unload the ehci-hcd driver and load only uhci and check if
> > > it still happens. I guess from the trace that the problem lies in the ehci
> > > driver itself.
> > 
> > Your guess is right. With only uhci loaded it works (dog slow of course).
> > When I then insmod the ehci-hcd driver: instant Oops.
> > 
> > Today I tried with another USB 2.0 enclosure w/o crash - it seems
> > to dislike especially the Seagate enclosure.
> 
> Fine, it may not be an important bug.

To you :) - it is annoying for me.

> 
> > perhaps the output of cat /proc/bus/usb/devices gives some hint?
> > (BTW: what does the asterisk in the 'C:' lines mean?)
> 
> I don't remember at all...
> 
> > On the two "GE Med. Kretz" USB<>IDE devices there is 
> > a DVD recorder and a Maxtor HD connected, both are working fine
> > as long as nobody tries to plug in this particular Seagate.
> > 
> > What to do next? I have no clue about the innards of ehci-hcd....
> 
> You should CC the ehci-hcd the usb-storage maintainers, they probably

tks for advice.

> will have more clues or ideas about what you encounter. A post to the
> linux-usb-users list would be a good idea too. Also, if you can test
> 2.6 and find that it is broken only on 2.4, it will be easier for them
> to send you some code to try.

I will try to boot something like knoppix or RIP with a 2.6 kernel
and see what happens.

Thanks anyways,

Karl

> 
> Regards,
> Willy

-- 
Karl Kiniger   mailto:karl.kiniger@med.ge.com
GE Medical Systems Kretztechnik GmbH & Co OHG
Tiefenbach 15       Tel: (++43) 7682-3800-710
A-4871 Zipf Austria Fax: (++43) 7682-3800-47
