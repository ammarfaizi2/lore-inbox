Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263370AbTLDUGZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Dec 2003 15:06:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263518AbTLDUGY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Dec 2003 15:06:24 -0500
Received: from fmr99.intel.com ([192.55.52.32]:37771 "EHLO
	hermes-pilot.fm.intel.com") by vger.kernel.org with ESMTP
	id S263370AbTLDUGW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Dec 2003 15:06:22 -0500
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: RE: [Lhms-devel] RE: memory hotremove prototype, take 3
Date: Thu, 4 Dec 2003 12:06:02 -0800
Message-ID: <B8E391BBE9FE384DAA4C5C003888BE6F4FAF0B@scsmsx401.sc.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [Lhms-devel] RE: memory hotremove prototype, take 3
Thread-Index: AcO6Ve5sHyEV2NXySx6YAMVV/JX6mgASxOAA
From: "Luck, Tony" <tony.luck@intel.com>
To: "Pavel Machek" <pavel@suse.cz>,
       "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
Cc: "Yasunori Goto" <ygoto@fsw.fujitsu.com>, <linux-kernel@vger.kernel.org>,
       "IWAMOTO Toshihiro" <iwamoto@valinux.co.jp>,
       "Hirokazu Takahashi" <taka@valinux.co.jp>,
       "Linux Hotplug Memory Support" <lhms-devel@lists.sourceforge.net>
X-OriginalArrivalTime: 04 Dec 2003 20:06:03.0983 (UTC) FILETIME=[0BAC85F0:01C3BAA2]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Bingo...just the perfect excuse I need to give to my manager to keep
> > a low profile while tinkering around for a long time :)
> > 
> > Okay, so I will play a wee bit more the devil's advocate as an 
> > exercise of futility, if you don't mind. Just trying to compile a 
> > (possibly incomplete) quick list of what would be needed, can you 
> > guys help me? you know way more than I do:
> > 
> > 1) the core kernel needs to be independent of physical 
> memory position
> > 1.1) same with drivers/subsystems
> > 1.2) filesystems
> > [it cannot be really incomplete because I have added all the code
> > :/]
> 
> ...and you have bad problem at any place where physical address is
> passed to the hardware. UHCI is going to be "interesting".

Which is why this hot remove project is side-stepping all
those hard problems, and just dealling with the "easy" cases
of only allocating user memory to removeable physical memory.
This is useful for large systems made up of removeable nodes
(either to physically remove a node, or to logically re-assign
a node to a different "partition" in the machine).

Anyone who wants more than this is welcome to virtualize the
base kernel, filesystems, driver code etc. to allow hot remove
of the remainder of memory not dealt with by this patch :-)

-Tony
