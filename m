Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262725AbTLDQNB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Dec 2003 11:13:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262694AbTLDQNB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Dec 2003 11:13:01 -0500
Received: from fmr05.intel.com ([134.134.136.6]:54985 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP id S262725AbTLDQM6 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Dec 2003 11:12:58 -0500
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: RE: [Lhms-devel] RE: memory hotremove prototype, take 3
Date: Thu, 4 Dec 2003 08:12:54 -0800
Message-ID: <A20D5638D741DD4DBAAB80A95012C0AE0125DD79@orsmsx409.jf.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [Lhms-devel] RE: memory hotremove prototype, take 3
Thread-Index: AcO6Ve4cV0Gw3mXkRZmdmZ8GRidMQAAKub+Q
From: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
To: "Pavel Machek" <pavel@suse.cz>
Cc: "Yasunori Goto" <ygoto@fsw.fujitsu.com>, <linux-kernel@vger.kernel.org>,
       "Luck, Tony" <tony.luck@intel.com>,
       "IWAMOTO Toshihiro" <iwamoto@valinux.co.jp>,
       "Hirokazu Takahashi" <taka@valinux.co.jp>,
       "Linux Hotplug Memory Support" <lhms-devel@lists.sourceforge.net>
X-OriginalArrivalTime: 04 Dec 2003 16:12:54.0761 (UTC) FILETIME=[7972A590:01C3BA81]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Pavel Machek [mailto:pavel@suse.cz]


> > 1) the core kernel needs to be independent of physical memory position
> > 1.1) same with drivers/subsystems
> > 1.2) filesystems
> > [it cannot be really incomplete because I have added all the code
> > :/]
> 
> ...and you have bad problem at any place where physical address is
> passed to the hardware. UHCI is going to be "interesting".

That one falls under the category of "every device driver that talks
in physical with its device" needs a callback to reallocate buffers
or cancel and reissue transactions.

Still, when I started to hate UHCI's guts in 1997 I had a reason...it
still holds true.

Iñaky Pérez-González -- Not speaking for Intel -- all opinions are my own (and my fault)


