Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755259AbWKRWJN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755259AbWKRWJN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Nov 2006 17:09:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755260AbWKRWJN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Nov 2006 17:09:13 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:1208 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S1755259AbWKRWJM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Nov 2006 17:09:12 -0500
X-Envelope-From: stefanr@s5r6.in-berlin.de
Message-ID: <455F8475.3010407@s5r6.in-berlin.de>
Date: Sat, 18 Nov 2006 23:08:53 +0100
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.6) Gecko/20060730 SeaMonkey/1.0.4
MIME-Version: 1.0
To: Mattia Dongili <malattia@linux.it>
CC: Greg KH <greg@kroah.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux1394-devel@lists.sourceforge.net,
       bcollins@debian.org
Subject: Re: 2.6.19-rc5-mm2 (Oops in class_device_remove_attrs during nodemgr_remove_host)
References: <20061114014125.dd315fff.akpm@osdl.org> <20061116171715.GA3645@inferi.kami.home> <455CAE0F.1080502@s5r6.in-berlin.de> <20061116203926.GA3314@inferi.kami.home> <455CEB48.5000906@s5r6.in-berlin.de> <20061117071650.GA4974@inferi.kami.home> <455DCEF7.3060906@s5r6.in-berlin.de> <455DD42B.1020004@s5r6.in-berlin.de> <20061118094706.GA17879@kroah.com> <455EEE17.4020605@s5r6.in-berlin.de> <455F3DED.3070603@s5r6.in-berlin.de> <455F7EDD.6060007@s5r6.in-berlin.de>
In-Reply-To: <455F7EDD.6060007@s5r6.in-berlin.de>
X-Enigmail-Version: 0.94.1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I wrote:
> It seems like one of the patches in -mm overwrites a device's list of
> children with junk.

And this happens only if eth1394 wasn't unloaded (therefore unbound
from FireWire "ud" devices beneath FireWire "ne" devices beneath the
FireWire host devices) before the host devices's children are to be
removed.

> Mattia, *if* your machine is able to compile and reboot into new
> kernels  really quickly, it would be nice if you could biject between
> the -mm patches.
...
> But hold on, I will do one other thing after I sent this message; I'll
> test -mm with CONFIG_SYSFS_DEPRECATED=y.

CONFIG_SYSFS_DEPRECATED=y does not change anything.
-- 
Stefan Richter
-=====-=-==- =-== =--=-
http://arcgraph.de/sr/
