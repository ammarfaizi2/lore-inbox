Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263037AbTCSOCz>; Wed, 19 Mar 2003 09:02:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263038AbTCSOCz>; Wed, 19 Mar 2003 09:02:55 -0500
Received: from meryl.it.uu.se ([130.238.12.42]:23696 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id <S263037AbTCSOCx>;
	Wed, 19 Mar 2003 09:02:53 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15992.31509.592442.463644@gargle.gargle.HOWL>
Date: Wed, 19 Mar 2003 15:13:41 +0100
From: mikpe@csd.uu.se
To: Pavel Machek <pavel@ucw.cz>
Cc: mikpe@csd.uu.se, Andrew Morton <akpm@digeo.com>,
       linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: apic-to-drivermodel conversion
In-Reply-To: <20030319140610.GA1028@elf.ucw.cz>
References: <20030318202858.GA154@elf.ucw.cz>
	<20030318161852.41a703a4.akpm@digeo.com>
	<15992.18243.605716.244572@gargle.gargle.HOWL>
	<20030319140610.GA1028@elf.ucw.cz>
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek writes:
 > > Try this patch instead. This is my merge of my and Pavel's earlier
 > > patches, so it differs from Pavel's in some details.
 > 
 > I tried it... Oops at kobject_add, called from device_add,
 > device_initialize, ..., init. This is on machine that does have
 > lapic. I'll try to do clean build to see if it goes away.
 > 
 > No, it still dies after ds: no socket drivers.

When does it die? At initial boot or at resume?

I don't claim that every driver that's hooked into the driver
model actually handles suspend/resume correctly, but this patch
does migrate APM/apic.c/nmi.c from the old PM system to the
driver model. I've tested it on plain P3 & P4 desktop machines.

Try a minimal .config.

/Mikael
