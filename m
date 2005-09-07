Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751273AbVIGUBV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751273AbVIGUBV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Sep 2005 16:01:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751278AbVIGUBV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Sep 2005 16:01:21 -0400
Received: from anf141.internetdsl.tpnet.pl ([83.17.87.141]:29900 "EHLO
	ogre.sisk.pl") by vger.kernel.org with ESMTP id S1751273AbVIGUBU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Sep 2005 16:01:20 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: rob <rob.rice@fuse.net>
Subject: Re: swsusp
Date: Wed, 7 Sep 2005 22:01:12 +0200
User-Agent: KMail/1.8.2
Cc: linux-kernel@vger.kernel.org
References: <431E97E5.1080506@fuse.net>
In-Reply-To: <431E97E5.1080506@fuse.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509072201.13268.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wednesday, 7 of September 2005 09:33, rob wrote:
> I singed up to this mailing list just to ask this question
> I have built a 2.6.13 kernel for a toshiba  tecra 500cdt
> this computer uses the pci buss for the sound card
> and pcmcia bridge
> I have writen a script to unload all the pci buss modules amd go to sleep
> it works up to this point
> now how do I get the modules put back when ever I add the lines to
> rerun the " /etc/rc.d/rc.hotplug /etc/rc.d/rc.pcmcia and 
> /etc/rc.d/rcmodules "
> I get a kernel crash befor it gose to sleep
> I have been al over the net and the olny info I can find is about 
> software suspend2
> Is there some way to change the sowftware suspend2 scripts to work with the
> unpatched kernel software suspend or where can I get the path to init
> talked about in the menuconfig file

Could you just try

# echo shutdown > /sys/power/disk && echo disk > /sys/power/state

without unloading any modules and see what happens (it should suspend
to disk)?

If it craches, could you boot the kernel with the init=/bin/bash option and try

# mount /sys
# mount /proc
# /sbin/swapon -a
# echo shutdown > /sys/power/disk && echo disk > /sys/power/state

and see what happens?

Rafael
 

-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
