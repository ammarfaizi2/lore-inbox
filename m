Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271372AbTHMFRg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 01:17:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271388AbTHMFRg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 01:17:36 -0400
Received: from f12.mail.ru ([194.67.57.42]:29444 "EHLO f12.mail.ru")
	by vger.kernel.org with ESMTP id S271372AbTHMFRf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 01:17:35 -0400
From: =?koi8-r?Q?=22?=Andrey Borzenkov=?koi8-r?Q?=22=20?= 
	<arvidjaar@mail.ru>
To: =?koi8-r?Q?=22?=Norbert Preining=?koi8-r?Q?=22=20?= 
	<preining@logic.at>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test3 cannot mount root fs
Mime-Version: 1.0
X-Mailer: mPOP Web-Mail 2.19
X-Originating-IP: [212.248.25.26]
Date: Wed, 13 Aug 2003 09:17:34 +0400
In-Reply-To: <20030812204337.GA7893@gamma.logic.tuwien.ac.at>
Reply-To: =?koi8-r?Q?=22?=Andrey Borzenkov=?koi8-r?Q?=22=20?= 
	  <arvidjaar@mail.ru>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <E19mo0s-0003Mb-00.arvidjaar-mail-ru@f12.mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



-----Original Message-----

> 
> On Die, 12 Aug 2003, "Andrey Borzenkov"  wrote:
> > > 	cannot mount rootfs "NULL" or hdb1
> > > I have compile in (of course) the filesystems of my root fs (ext3)
> > 
> > and you have tried to add rootfstype=ext3?
> 
> Yes. No change. Also in combination with all root= options and also with
> ext2.
> 

would you mind adding printk to mount_block_root to show
on which filesystem it fails and with which error? Something like

printk("VFS: Cannot open root device \"%s\" or %s for fs %s error=%d\n",
                               root_device_name, b, p, err);

-andrey
