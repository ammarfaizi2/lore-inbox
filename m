Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262575AbTKJAA3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Nov 2003 19:00:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262609AbTKJAA3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Nov 2003 19:00:29 -0500
Received: from mailhost.tue.nl ([131.155.2.7]:48142 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id S262575AbTKJAA2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Nov 2003 19:00:28 -0500
Date: Mon, 10 Nov 2003 01:00:26 +0100
From: Andries Brouwer <aebr@win.tue.nl>
To: linux-kernel@vger.kernel.org, konsti@ludenkalle.de
Subject: Re: Weird partititon recocnising problem in 2.6.0-testX
Message-ID: <20031110000026.GA15712@win.tue.nl>
References: <20031109011205.GA21914%konsti@ludenkalle.de> <20031109023625.GA15392@win.tue.nl> <20031109034940.GA8532@zappa.doom> <20031109115857.GA15484@win.tue.nl> <3FAE2EC1.6080307@stesmi.com> <20031109221546.GA11520%konsti@ludenkalle.de> <20031109230940.GA14063%konsti@ludenkalle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031109230940.GA14063%konsti@ludenkalle.de>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 10, 2003 at 12:09:40AM +0100, Konstantin Kletschke wrote:

> The suggested printk code is added no but I see no difference:

  hda: 9766MB, CHS=1245/255/63
  hdb: 130551MB, CHS=16643/255/63
  devfs_mk_dir: invalid argument.
   hda: hda1 hda2
  devfs_mk_dir: invalid argument.
  devfs_mk_bdev: could not append to parent for /disc
   hdb: hdb1
  devfs_mk_bdev: could not append to parent for /part1
  
Aha, this "hda: 9766MB, CHS=1245/255/63" looks ancient.
You are using the old hd.c instead of the new ide stuff.

Nobody else does so, so there might easily be something wrong.
So, try to set CONFIG_BLK_DEV_IDEDISK=y but unset CONFIG_BLK_DEV_HD_IDE.

Andries

