Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261682AbUHDIcQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261682AbUHDIcQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 04:32:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261451AbUHDIcP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 04:32:15 -0400
Received: from adsl-233-225.38-151.net24.it ([151.38.225.233]:11783 "EHLO
	gateway.milesteg.arr") by vger.kernel.org with ESMTP
	id S261300AbUHDIcK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 04:32:10 -0400
Date: Wed, 4 Aug 2004 10:32:08 +0200
From: Daniele Venzano <webvenza@libero.it>
To: Jean Francois Martinez <jfm512@free.fr>
Cc: Daniele Venzano <webvenza@libero.it>, linux-kernel@vger.kernel.org
Subject: Re: Integrated ethernet on SiS chipset doesn't work
Message-ID: <20040804083208.GE18272@gateway.milesteg.arr>
Mail-Followup-To: Jean Francois Martinez <jfm512@free.fr>,
	Daniele Venzano <webvenza@libero.it>, linux-kernel@vger.kernel.org
References: <1089480939.2779.22.camel@agnes> <Pine.LNX.4.53.0407102141560.5590@chaos> <1089538014.4690.32.camel@agnes> <20040711101608.GB10738@picchio.gall.it> <1091130156.2912.17.camel@agnes>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1091130156.2912.17.camel@agnes>
X-Operating-System: Debian GNU/Linux on kernel Linux 2.4.26-grsec
X-Copyright: Forwarding or publishing without permission is prohibited.
X-Truth: La vita e' una questione di culo, o ce l'hai o te lo fanno.
X-GPG-Fingerprint: 642A A345 1CEF B6E3 925C  23CE DAB9 8764 25B3 57ED
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 29, 2004 at 09:42:36PM +0200, Jean Francois Martinez wrote:
> Here is the interesting part of his dmesg, after reloading the
> sis900 driver.  We can see that the card
> indentifies a VIA transceiver at address 1 but instead uses the 
> (inexistent) one at address 31.

> eth0: VIA 6103 PHY transceiver found at address 1.
...
> eth0: Unknown PHY transceiver found at address 31.
> eth0: Using transceiver found at address 31 as default
> eth0: SiS 900 PCI Fast Ethernet at 0xe800, IRQ 11, 00:0c:76:68:a9:89.

This behaviuor should be corrected in tha latest kernels (mm or bk) by
the patches available here:
http://teg.homeunix.org/sis900.html

If all fails this patch should work just fine:
http://teg.homeunix.org/download/kpatches/sis900-list-phy-ids.diff
But is just for that particular case.


-- 
-----------------------------
Daniele Venzano
Web: http://teg.homeunix.org

