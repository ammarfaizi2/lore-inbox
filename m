Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265366AbTFRQo4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jun 2003 12:44:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265373AbTFRQoz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jun 2003 12:44:55 -0400
Received: from meryl.it.uu.se ([130.238.12.42]:64491 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S265362AbTFRQoh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jun 2003 12:44:37 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16112.39481.630459.605801@gargle.gargle.HOWL>
Date: Wed, 18 Jun 2003 18:58:33 +0200
From: Mikael Pettersson <mikpe@csd.uu.se>
To: linux-kernel@vger.kernel.org
Subject: [SOLVED] Re: Cardbus/3c575 hotplugging dysfunctional in 2.5.72
In-Reply-To: <16112.23126.341995.691398@gargle.gargle.HOWL>
References: <16112.23126.341995.691398@gargle.gargle.HOWL>
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I wrote:
 > With 2.5.72, my laptop with a Cardbus 3c575 NIC and RH9 user-space
 > (hotplug-2002_04_01-17 and kernel-pcmcia-cs-3.1.31-13) no longer
 > brings eth0 up automatically on insertion of the NIC. cardmgr
 > _is_ running. A manual ifup eth0 brings it up however.

Oh crap. It was Stephen Hemminger's patch
http://marc.theaimsgroup.com/?l=linux-kernel&m=105554780621594&w=2
which changes the net device hotplug protocol. The fix -- update
/etc/hotplug/net.agent -- is described in the above page.

Yet another item for the "from 2.4 to 2.5" check list.
