Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265331AbUITCQZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265331AbUITCQZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Sep 2004 22:16:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265487AbUITCQZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Sep 2004 22:16:25 -0400
Received: from main.gmane.org ([80.91.229.2]:1261 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S265331AbUITCQY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Sep 2004 22:16:24 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: "Alexander E. Patrakov" <patrakov@ums.usu.ru>
Subject: Re: udev is too slow creating devices
Date: Mon, 20 Sep 2004 08:16:40 +0600
Message-ID: <cilehj$9g4$1@sea.gmane.org>
References: <20040914213506.GA22637@kroah.com> <20040914214552.GA13879@wonderland.linux.it> <20040914215122.GA22782@kroah.com> <20040914224731.GF3365@dualathlon.random> <20040914230409.GA23474@kroah.com> <414849CE.8080708@debian.org> <1095258966.18800.34.camel@icampbell-debian> <20040915152019.GD24818@thundrix.ch> <4148637F.9060706@debian.org> <20040915185116.24fca912.Ballarin.Marc@gmx.de> <20040915180056.GA23257@kroah.com> <pan.2004.09.19.18.53.14.171322@dungeon.inka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: dsa.physics.usu.ru
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040121
X-Accept-Language: en-us, en
In-Reply-To: <pan.2004.09.19.18.53.14.171322@dungeon.inka.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Jellinghaus wrote:
> Also I wonder how dm works: will dmsetup create the /dev inode
> itself, or use udev to do that? would I need the sleep/loop 
> in a script creating device mappings to wait for the inode?

You can safely tell udev to ignore dm devices, if you use LVM or EVMS. 
It almost always creates them under the wrong directory and with wrong 
name anyway. Correcting this means just duplicating LVM/EVMS 
configuration in udev rules. Better leave this task of dm node creation 
to dmsetup and related tools.

-- 
Alexander E. Patrakov

