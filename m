Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751262AbWCZRSs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751262AbWCZRSs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Mar 2006 12:18:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751270AbWCZRSs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Mar 2006 12:18:48 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:60364 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751262AbWCZRSr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Mar 2006 12:18:47 -0500
Subject: Re: Schedule for adding pata to kernel?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Harald Dunkel <harald.dunkel@t-online.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <44266499.3070809@t-online.de>
References: <1142869095.20050.32.camel@localhost.localdomain>
	 <4422F10B.9080608@bootc.net>  <44266499.3070809@t-online.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sun, 26 Mar 2006 18:26:08 +0100
Message-Id: <1143393969.2540.5.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2006-03-26 at 11:53 +0200, Harald Dunkel wrote:
> Hi Alan,
> 
> Works for me, too. Is there a plan to add this to the source tree?

Yes

There are several chunks of work needed. Firstly was to resync with the
libata development tree which is now done. The second to push changes to
the core code neccessary to support the PATA drivers. This is about
2/3rd done (Tejun Ho has been doing lots of work on mode changes which
also meant chunks of it were not needed).

Of the other bits that need merging some need resubmits/tidying and
oddments noted/requested by Jeff fixing. At that point it should be
possible just to drop in drivers during 2.6.17 development.

The final hard bit will be the PIIX/ICH driver as this is a major update
to a critical driver used by very many SATA people rather than a new
driver, so has the highest risk of breaking stuff.

Alan

