Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030359AbWHQXXe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030359AbWHQXXe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 19:23:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030312AbWHQXXe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 19:23:34 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:61137
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S965154AbWHQXXd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 19:23:33 -0400
Date: Thu, 17 Aug 2006 16:23:40 -0700 (PDT)
Message-Id: <20060817.162340.74748342.davem@davemloft.net>
To: xavier.bestel@free.fr
Cc: 7eggert@gmx.de, notting@redhat.com, cate@debian.org, 7eggert@elstempel.de,
       shemminger@osdl.org, mitch.a.williams@intel.com, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: bonding: cannot remove certain named devices
From: David Miller <davem@davemloft.net>
In-Reply-To: <1155799783.7566.5.camel@capoeira>
References: <20060816133811.GA26471@nostromo.devel.redhat.com>
	<Pine.LNX.4.58.0608161636250.2044@be1.lrz>
	<1155799783.7566.5.camel@capoeira>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xavier Bestel <xavier.bestel@free.fr>
Date: Thu, 17 Aug 2006 09:29:43 +0200

> Why not simply retricting chars to isalnum() ones ?

As Bill said that would block things like "-" and "_" which are fine.

Bill also mentioned something about "breaking configs going back to
2.4.x" which is bogus because nothing broke when we started blocking
"/" and "." and ".." in networking device names during the addition of
sysfs support for net devices.

Nobody in their right mind puts a space in their network device name.

All you "name purists", go rename the block device name that is used
for your root partition to something with a space in it, and watch how
many startup scripts and command line invocations just explode.

There is absolutely no valid argument for allowing spaces in network
device names.
