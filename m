Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261483AbULTHyY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261483AbULTHyY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Dec 2004 02:54:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261474AbULTHuu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Dec 2004 02:50:50 -0500
Received: from ylpvm15-ext.prodigy.net ([207.115.57.46]:60547 "EHLO
	ylpvm15.prodigy.net") by vger.kernel.org with ESMTP id S261435AbULTGoP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Dec 2004 01:44:15 -0500
From: David Brownell <david-b@pacbell.net>
To: linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] Re: RFC: [2.6 patch] let BLK_DEV_UB depend on EMBEDDED
Date: Sun, 19 Dec 2004 22:43:05 -0800
User-Agent: KMail/1.7.1
Cc: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>,
       "Randy.Dunlap" <rddunlap@osdl.org>, Pete Zaitcev <zaitcev@redhat.com>,
       Adrian Bunk <bunk@stusta.de>, Greg KH <greg@kroah.com>,
       linux-kernel@vger.kernel.org
References: <20041220001644.GI21288@stusta.de> <41C65EA0.7020805@osdl.org> <20041220062055.GA22120@one-eyed-alien.net>
In-Reply-To: <20041220062055.GA22120@one-eyed-alien.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200412192243.06324.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 19 December 2004 10:20 pm, Matthew Dharm wrote:
> 
> Enabling CONFIG_BLK_DEV_UB actually disables usb-storage from attaching to
> certain devices, regardless of what's loaded or not.

It also seems to mean significantly slower access (at high speed)
for the most standard devices.  That doesn't seem like a win,
though I suspect fixing it should be as simple as switching over
to use the USB scatterlist calls (which usb-storage uses) ...

- Davve


> I can tell you that this has turned into the single largest source of bug
> reports/complaints about usb-storage.  Something has to be done.  I just
> don't know what.

 
