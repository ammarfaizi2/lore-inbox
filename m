Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262071AbUISSss@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262071AbUISSss (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Sep 2004 14:48:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262138AbUISSss
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Sep 2004 14:48:48 -0400
Received: from quechua.inka.de ([193.197.184.2]:38823 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S262071AbUISSsr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Sep 2004 14:48:47 -0400
From: Andreas Jellinghaus <aj@dungeon.inka.de>
Subject: Re: udev is too slow creating devices
Date: Sun, 19 Sep 2004 20:53:15 +0200
User-Agent: Pan/0.14.2.91 (As She Crawled Across the Table (Debian GNU/Linux))
Message-Id: <pan.2004.09.19.18.53.14.171322@dungeon.inka.de>
References: <20040914213506.GA22637@kroah.com> <20040914214552.GA13879@wonderland.linux.it> <20040914215122.GA22782@kroah.com> <20040914224731.GF3365@dualathlon.random> <20040914230409.GA23474@kroah.com> <414849CE.8080708@debian.org> <1095258966.18800.34.camel@icampbell-debian> <20040915152019.GD24818@thundrix.ch> <4148637F.9060706@debian.org> <20040915185116.24fca912.Ballarin.Marc@gmx.de> <20040915180056.GA23257@kroah.com>
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Sep 2004 18:17:02 +0000, Greg KH wrote:
> There is, just run your stuff off of /etc/dev.d/ and stop relying on a
> device node to be present after modprobe returns.

But installation scripts will need to sleep/loop after fdisk,
till the devices are created, right?

And I'm currently mknod'ing /dev/md* devices before creating
the kernel structures with mkraid (which needs the device inode).
Is there any other way to do this? 

sure, in the long run designs like dm with a special control
device are a better than this hack for md. 
Also I wonder how dm works: will dmsetup create the /dev inode
itself, or use udev to do that? would I need the sleep/loop 
in a script creating device mappings to wait for the inode?

Regards, Andreas

