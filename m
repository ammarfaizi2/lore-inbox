Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132130AbRDCPOb>; Tue, 3 Apr 2001 11:14:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132147AbRDCPOW>; Tue, 3 Apr 2001 11:14:22 -0400
Received: from smtp1.cern.ch ([137.138.128.38]:57353 "EHLO smtp1.cern.ch")
	by vger.kernel.org with ESMTP id <S132130AbRDCPOL>;
	Tue, 3 Apr 2001 11:14:11 -0400
Date: Tue, 3 Apr 2001 17:12:35 +0200
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: Negative module use count for usb/acm
Message-ID: <20010403171235.A21205@pcep-jamie.cern.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is kernel 2.4.2, as kernel 2.4.3 doesn't seem to work with pppd's
chat program.

Spot the incongruity below!  (It will go to -4 when I disconnect).

This is on a laptop, which is suspended from time to time.  Maybe this
gives a clue as to what's causing the fault.

enjoy,
-- Jamie

[jamie@thefinal jamie]$ /sbin/lsmod                                            
Module                  Size  Used by
ppp_deflate            41440   0 (autoclean)
bsd_comp                4208   0 (autoclean)
ppp_async               6416   1 (autoclean)
acm                     5184  -3 (autoclean)
ppp_generic            12928   2 (autoclean) [ppp_deflate bsd_comp ppp_async]
slhc                    4816   0 (autoclean) [ppp_generic]
uhci                   18832   0 (autoclean) (unused)
usbcore                32208   0 (autoclean) [acm uhci]
autofs                 11008   1 (autoclean)
maestro                26976   0 (unused)
soundcore               3888   2 [maestro]
