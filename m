Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261558AbULTQF6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261558AbULTQF6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Dec 2004 11:05:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261559AbULTQF6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Dec 2004 11:05:58 -0500
Received: from ylpvm29-ext.prodigy.net ([207.115.57.60]:14497 "EHLO
	ylpvm29.prodigy.net") by vger.kernel.org with ESMTP id S261558AbULTQFw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Dec 2004 11:05:52 -0500
From: David Brownell <david-b@pacbell.net>
To: linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] Re: RFC: [2.6 patch] let BLK_DEV_UB depend on EMBEDDED
Date: Mon, 20 Dec 2004 08:03:44 -0800
User-Agent: KMail/1.7.1
Cc: Pete Zaitcev <zaitcev@redhat.com>,
       Matthew Dharm <mdharm-kernel@one-eyed-alien.net>,
       "Randy.Dunlap" <rddunlap@osdl.org>, Adrian Bunk <bunk@stusta.de>,
       Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
References: <20041220001644.GI21288@stusta.de> <200412192243.06324.david-b@pacbell.net> <20041219230603.7956d309@lembas.zaitcev.lan>
In-Reply-To: <20041219230603.7956d309@lembas.zaitcev.lan>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200412200803.45190.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 19 December 2004 11:06 pm, Pete Zaitcev wrote:
> On Sun, 19 Dec 2004 22:43:05 -0800, David Brownell <david-b@pacbell.net> wrote:
> 
> > It also seems to mean significantly slower access (at high speed)
> > for the most standard devices.  That doesn't seem like a win,
> > though I suspect fixing it should be as simple as switching over
> > to use the USB scatterlist calls (which usb-storage uses) ...
> 
> They do not allow asynchronous operation, last time I checked.

You could add an async mode ... heck, even the hack of dedicating
a kernel thread to that task ("psuedo-async" within "ub") would
give much more reasonable throughput. 

- Dave
