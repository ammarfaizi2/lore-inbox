Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263777AbTJCQGn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Oct 2003 12:06:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263780AbTJCQGn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Oct 2003 12:06:43 -0400
Received: from tench.street-vision.com ([212.18.235.100]:18615 "EHLO
	tench.street-vision.com") by vger.kernel.org with ESMTP
	id S263777AbTJCQGi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Oct 2003 12:06:38 -0400
Subject: Re: i7505 locks up too (Was: iTyan i7501 Pro (S2721-533) lock-up
	(e1000?))
From: Justin Cormack <justin@street-vision.com>
To: Frank Horowitz <frank.horowitz@csiro.au>
Cc: Kernel mailing list <linux-kernel@vger.kernel.org>, jfbeam@bluetronic.net
In-Reply-To: <1064991240.2271.70.camel@bonzo.ned.dem.csiro.au>
References: <1064991240.2271.70.camel@bonzo.ned.dem.csiro.au>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-11) 
Date: 03 Oct 2003 17:05:55 +0100
Message-Id: <1065197156.10829.7.camel@lotte.street-vision.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-10-01 at 07:54, Frank Horowitz wrote:

> I'm seeing a similar problem with a (bunch of) Supermicro i7505 boards
> (X5DAL-G's if it matters). All with e1000 onboard (but running at
> 100Mbps full-duplex through Cisco 2900-series and 4000-series switches).
> All locking up under heavy load (openMosix process migrations). 
> 
> All are running 2.4.x series kernels, patched with matching openMosix
> versions.
> 
> The problem persists with vanilla kernel e1000 drivers, or the latest
> from the intel site.
> 
> All boxes have had their physical cat5e cabling tested and are showing
> within spec. 
> 
> Moshe Bar (lead developer on openMosix) claims that the instability
> behaviors I am seeing are "almost always" networking related.
> 
> AFAIK, the two chipsets share the 82870P2 PCI/PCI-X Controller Hub2 (AKA
> P64H2). In my Supermicro boards, the e1000 (82545EM) hangs directly off
> of the P64H2 (according to the boards' block diagram). After downloading
> your board's manual from Tyan, I see that you have a dual e1000 chip
> (82546) hanging directly off of the P64H2 also. 
> 
> Obviously, the MCH's differ (one being the E7501 and the other being the
> E7505).
> 
> All boxes have had memtest86 run on them with repeated passes and are
> showing fine.
>  
> The i7505s have 82801DB's onboard (AKA ICH4) while the i7501s have
> 82801CA's onboard (AKA ICH3).  Question: You aren't by any chance seeing
> funkiness showing up as IDE problems, are you? This would point towards
> ICH* problems (too?)...
> 
> I'm obviously delighted to help anyone with better kernel debugging
> skills than I have to try and track this problem down. It's making life
> pretty unbearable with instability in our openMosix cluster.

I have quite a few i7505 (Supermicro X5DAL-RG2 - same as yours but with
dual e1000 and SATA), and have not had any problems that could be
attributed to ethernet, including a machine running with constant
traffic over 500Mb/s on gigabit. Mostly inbound traffic though, but have
not had any problems with any others either. Using 2.4.22. Do you get
anything in the logs/serial console?

Justin


