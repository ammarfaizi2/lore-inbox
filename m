Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263270AbTE3Ed7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 May 2003 00:33:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263271AbTE3Ed7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 May 2003 00:33:59 -0400
Received: from george.he.net ([216.218.157.2]:17678 "EHLO george.he.net")
	by vger.kernel.org with ESMTP id S263270AbTE3Ed6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 May 2003 00:33:58 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: "Lincoln D. Durey" <durey@EmperorLinux.com>
Reply-To: emperor@EmperorLinux.com
Organization: EmperorLinux
To: LKML <linux-kernel@vger.kernel.org>
Subject: IBM T40 _refusing_ to boot with "unauthorized" mini-PCI wifi card
Date: Fri, 30 May 2003 00:47:00 -0400
User-Agent: KMail/1.4.1
Cc: EmperorLinux Research <research@EmperorLinux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200305300047.00519.durey@EmperorLinux.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


We have an IBM T40 ThinkPad (2373-91U), that is _refusing_ to accept an 
"unauthorized" mini-PCI WiFi card (from IBM!) in its mini-PCI slot.

Since the T40 usually comes with 802.11a/b cards (no Linux support), we are 
getting these systems without wifi cards and were hoping to put prism2 based 
cards in them.  ("IBM High Rate Wireless" IBM:22P7701, stock card in T30's)

The bios locks the system with this nasty notice:

	ERROR
	1802: Unauthorized network card is plugged in - 
	Power off and remove the miniPCI network card.

if you boot with either:
	a) an "IBM High Rate Wireless" (22P7701) (T30 wifi prism2)
	b) an "Broadcom BCM4301" (802.11b/g unsupported)

It's clearly just an artificial BIOS limitation since we can swap the
card in while waiting at a GRUB prompt (!) and it works perfectly.

This implies that IBM has decided which cards to _allow_ users to put in their 
laptops, and in the process is rendering these T40's unable to have working 
wifi under Linux.  ( preview TPCA ? ! ).

We have of course updated the v1.03 bios (1RET32WW) to v1.04 (1RET33WW)
to no avail, and searched IBM's site which revealed only the same "Error 1802" 
translation that the bios gives.

What the Linux community needs from IBM is a BIOS update that does not cripple 
these systems.  Does anyone know of a BIOS fix or other workaround for this 
problem?

It seems uncharacteristic of IBM to simultaneously ship the machine with an 
unsupported card, and retard the system's ability to boot with a working 
card.

Feel free to call or email me directly if need any more tech details.

	-- Lincoln

*------------------------------------------------------------------*
|  Lincoln D. Durey, Ph.D.  |  Phone:    1-888-651-6686            |
|   Electrical Engineer     |  in GA:    (770)-612-1205            |
|     EmperorLinux          |  Fax:      (770)-612-1210            |
|     900 Circle 75 Pkwy.   |  web:      www.EmperorLinux.com      |
|     Suite 1380            |  support:  support@EmperorLinux.com  |
|     Atlanta, GA 30339     |  email:    lincoln@EmperorLinux.com  |
*------------------------------------------------------------------*

