Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932373AbWDDIwp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932373AbWDDIwp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Apr 2006 04:52:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932376AbWDDIwp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Apr 2006 04:52:45 -0400
Received: from rhlx01.fht-esslingen.de ([129.143.116.10]:56522 "EHLO
	rhlx01.fht-esslingen.de") by vger.kernel.org with ESMTP
	id S932373AbWDDIwp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Apr 2006 04:52:45 -0400
Date: Tue, 4 Apr 2006 10:52:38 +0200
From: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
To: Pete Clements <clem@clem.clem-digital.net>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.16-git12 killed networking -- 3c509 card
Message-ID: <20060404085238.GA24015@rhlx01.fht-esslingen.de>
References: <200603262143.k2QLhrDU002007@clem.clem-digital.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200603262143.k2QLhrDU002007@clem.clem-digital.net>
User-Agent: Mutt/1.4.2.1i
X-Priority: none
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, Mar 26, 2006 at 04:43:53PM -0500, Pete Clements wrote:
> FYI:
>   Single 3c509 card, UP i386
>   Lost networking with .16-git12, message
>   ADDRCONF(NETDEV_UP): eth0: link is not ready
> 
>   Had several of these with git11
>   NETDEV WATCHDOG: eth0: transmit timed out
> 
>   No problems observed git1-git10

Another "me too", in case it's still helpful.
3c905B (PCI) on a BNC(!) network, AMD Duron 1200, 3c59x.o.

2.6.15-ck7 (based on 2.6.15.6) works, 2.6.16-ck3 (based on 2.6.16.1)
produces the following errors:

Apr  3 19:10:41 birgit kernel: nfs: server gate not responding, still trying
Apr  3 19:10:52 birgit last message repeated 5 times
Apr  3 19:10:52 birgit kernel: NETDEV WATCHDOG: eth0: transmit timed out
Apr  3 19:10:52 birgit kernel: eth0: transmit timed out, tx_status 00 status e000.
Apr  3 19:10:52 birgit kernel:   diagnostics: net 04c0 media 4800 dma 000000a0 fif
o 0000
Apr  3 19:10:52 birgit kernel:   Flags; bus-master 1, dirty 19952(0) current 19968
(0)
Apr  3 19:10:52 birgit kernel:   Transmit list 1f53f2a0 vs. df53f200.
Apr  3 19:10:52 birgit kernel:   0: @df53f200  length 8000009e status 0c01009e
Apr  3 19:10:52 birgit kernel:   1: @df53f2a0  length 8000009e status 0c00009e
Apr  3 19:10:52 birgit kernel:   2: @df53f340  length 8000009e status 0c00009e
Apr  3 19:10:52 birgit kernel:   3: @df53f3e0  length 8000009e status 0c00009e
Apr  3 19:10:52 birgit kernel:   4: @df53f480  length 8000009e status 0c00009e
Apr  3 19:10:52 birgit kernel:   5: @df53f520  length 8000009e status 0c00009e
Apr  3 19:10:52 birgit kernel:   6: @df53f5c0  length 80000042 status 00000042
Apr  3 19:10:52 birgit kernel:   7: @df53f660  length 80000042 status 00000042
Apr  3 19:10:52 birgit kernel:   8: @df53f700  length 80000072 status 0c000072
Apr  3 19:10:52 birgit kernel:   9: @df53f7a0  length 8000009e status 0c00009e
Apr  3 19:10:52 birgit kernel:   10: @df53f840  length 8000004e status 0000004e
Apr  3 19:10:52 birgit kernel:   11: @df53f8e0  length 8000009e status 0c00009e
Apr  3 19:10:52 birgit kernel:   12: @df53f980  length 8000004e status 0000004e
Apr  3 19:10:52 birgit kernel:   13: @df53fa20  length 8000004e status 0000004e
Apr  3 19:10:52 birgit kernel:   14: @df53fac0  length 8000009e status 8c00009e
Apr  3 19:10:52 birgit kernel:   15: @df53fb60  length 80000072 status 8c000072
Apr  3 19:10:52 birgit kernel: eth0: Resetting the Tx ring pointer.
Apr  3 19:10:52 birgit kernel: nfs: server gate OK

Would be very nice (~= important) to see a fix somewhere in 2.6.16.y.

Andreas Mohr
