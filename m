Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422875AbWKPKEr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422875AbWKPKEr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Nov 2006 05:04:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422910AbWKPKEq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Nov 2006 05:04:46 -0500
Received: from iona.labri.fr ([147.210.8.143]:3763 "EHLO iona.labri.fr")
	by vger.kernel.org with ESMTP id S1422875AbWKPKEp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Nov 2006 05:04:45 -0500
Message-ID: <455C37B9.4020000@ens-lyon.org>
Date: Thu, 16 Nov 2006 11:04:41 +0100
From: Brice Goglin <Brice.Goglin@ens-lyon.org>
User-Agent: Icedove 1.5.0.7 (X11/20061013)
MIME-Version: 1.0
To: Roland Dreier <rdreier@cisco.com>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] ALSA: hda-intel - Disable MSI support by default]
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(forgot to cc: LKML)

Roland Dreier wrote:
>  > A whitelist is an awkward solution, the problem is the number of
>  > chipsets available with MSI will continue to grow. And the assumption
>  > is that after Microsoft OS supports MSI, that newer chipsets will work.
>
> Maybe a whitelist for older systems and then enable everything after a
> DMI cutoff date by default?  Doesn't work on non-PC stuff though...  


When I started sending patches about all this, I proposed a whitelist
for PCI bridges and a blacklist for PCIe bridges, but Greg was against
whitelisting.

Now, reading this thread, I am very disturbed with the idea of disabling
MSI on all non-Intel bridges. Blacklisting correctly shouldn't be that
hard. From my point of view, there are several non-Intel bridges that
seem to support MSI very well (especially some HT<->PCIe bridges). And
apart from being required for ipath, MSI improves the performance of
network drivers a bit, so I'd rather keep it enabled on trusted bridges...

Brice



