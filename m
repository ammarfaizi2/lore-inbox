Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264501AbTLCFTX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Dec 2003 00:19:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264502AbTLCFTX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Dec 2003 00:19:23 -0500
Received: from fmr05.intel.com ([134.134.136.6]:9912 "EHLO hermes.jf.intel.com")
	by vger.kernel.org with ESMTP id S264501AbTLCFTW convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Dec 2003 00:19:22 -0500
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: RE: memory hotremove prototype, take 3
Date: Tue, 2 Dec 2003 21:19:02 -0800
Message-ID: <A20D5638D741DD4DBAAB80A95012C0AE0125DCB0@orsmsx409.jf.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: memory hotremove prototype, take 3
Thread-Index: AcO5OVp9zk1fsPFaQmak6sj8vKu9eQAI1Gyg
From: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
To: "Yasunori Goto" <ygoto@fsw.fujitsu.com>, "Pavel Machek" <pavel@suse.cz>
Cc: <linux-kernel@vger.kernel.org>, "Luck, Tony" <tony.luck@intel.com>,
       "IWAMOTO Toshihiro" <iwamoto@valinux.co.jp>,
       "Hirokazu Takahashi" <taka@valinux.co.jp>,
       "Linux Hotplug Memory Support" <lhms-devel@lists.sourceforge.net>
X-OriginalArrivalTime: 03 Dec 2003 05:19:03.0443 (UTC) FILETIME=[F758D630:01C3B95C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> From: Yasunori Goto

> IMHO, To hot-remove memory, memory attribute should be divided
> into Hotpluggable and no-Hotpluggable, and each attribute memory
> should be allocated each unit(ex. node).

Why? I still don't get that -- we should be able to use the virtual
addressing mechanism of any CPU to swap under the rug any virtual
address without needing to do anything more than allocate a page frame
for the new physical location (I am ignoring here devices that are 
directly accessing physical memory--a callback in the device model could
be added to require them to reallocate their buffers).

Or am I deadly and naively wrong?

Iñaky Pérez-González -- Not speaking for Intel -- all opinions are my own (and my fault)
