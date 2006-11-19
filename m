Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933202AbWKSUep@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933202AbWKSUep (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Nov 2006 15:34:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933213AbWKSUeo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Nov 2006 15:34:44 -0500
Received: from smtp.osdl.org ([65.172.181.25]:2774 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S933202AbWKSUen (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Nov 2006 15:34:43 -0500
Date: Sun, 19 Nov 2006 12:33:48 -0800
From: Andrew Morton <akpm@osdl.org>
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc: Mattia Dongili <malattia@linux.it>, Greg KH <greg@kroah.com>,
       linux-kernel@vger.kernel.org, linux1394-devel@lists.sourceforge.net,
       bcollins@debian.org
Subject: Re: ohci1394 oops bisected [was Re: 2.6.19-rc5-mm2 (Oops in
 class_device_remove_attrs during nodemgr_remove_host)]
Message-Id: <20061119123348.4c961515.akpm@osdl.org>
In-Reply-To: <456090C9.1040900@s5r6.in-berlin.de>
References: <455CAE0F.1080502@s5r6.in-berlin.de>
	<20061116203926.GA3314@inferi.kami.home>
	<455CEB48.5000906@s5r6.in-berlin.de>
	<20061117071650.GA4974@inferi.kami.home>
	<455DCEF7.3060906@s5r6.in-berlin.de>
	<455DD42B.1020004@s5r6.in-berlin.de>
	<20061118094706.GA17879@kroah.com>
	<455EEE17.4020605@s5r6.in-berlin.de>
	<455F3DED.3070603@s5r6.in-berlin.de>
	<455F7EDD.6060007@s5r6.in-berlin.de>
	<20061119162220.GA2536@inferi.kami.home>
	<456090C9.1040900@s5r6.in-berlin.de>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 19 Nov 2006 18:13:45 +0100
Stefan Richter <stefanr@s5r6.in-berlin.de> wrote:

> Mattia Dongili wrote:
> > the winner is... gregkh-driver-network-device.patch

That was a fair bet - that patch has caused a mountain of grief.

> Interesting. Looks very much like eth1394's sysfs interface is getting
> in the way. And since it is entirely handled by the ieee1394 core, it
> means ieee1394 needs the class_dev to dev treatment. I think it's OK if
> we just wait for Greg to finish his preliminary patch. Until then,
> CONFIG_IEEE1394_ETH1394=n should avoid the oops. (Or Andrew marks
> eth1394 broken or removes gregkh-driver-network-device.patch...)

Do we know what's actually wrong, and what needs to be done about it?
