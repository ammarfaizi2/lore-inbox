Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965021AbWIKUE4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965021AbWIKUE4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 16:04:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965025AbWIKUE4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 16:04:56 -0400
Received: from mout2.freenet.de ([194.97.50.155]:37765 "EHLO mout2.freenet.de")
	by vger.kernel.org with ESMTP id S965021AbWIKUEz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 16:04:55 -0400
Date: Mon, 11 Sep 2006 22:11:52 +0200
To: "Greg KH" <greg@kroah.com>
Subject: Re: [PATCH] pktcdvd: added sysfs interface + bio write queue handling fix
Reply-To: balagi@justmail.de
From: "Thomas Maier" <balagi@justmail.de>
Cc: linux-kernel@vger.kernel.org, "petero2@telia.com" <petero2@telia.com>
Content-Type: text/plain; charset=iso-8859-15
MIME-Version: 1.0
References: <op.tfkmp60biudtyh@master> <20060908210042.GA6877@kroah.com> <4501E33B.50204@cfl.rr.com> <20060908220129.GB20018@kroah.com> <op.tfmh56j9iudtyh@master> <20060909213054.GC19188@kroah.com> <op.tfogcsaaiudtyh@master>
Content-Transfer-Encoding: 7bit
Message-ID: <op.tfqc12x5iudtyh@master>
In-Reply-To: <op.tfogcsaaiudtyh@master>
User-Agent: Opera Mail/9.00 (Win32)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

> The file layout is now as follows:
>
> /sys/block/pktcdvd[0-7]/      # device dir created by gendisk
>                    packet/     # pktcdvd subdir
>                      <files>   # pktcdvd per device files
>                      mapped_to # symlink to mapped device in /sys/block
>
> /sys/class/pktcdvd/		# class dir for control files
>                   add          # add new device mapping, creates new pktcdvd device
>                   remove       # ...
>                   device_map
>                   packet_buffers
>
> /debugfs/pktcdvd[0-7]/		# per device debugfs dir entry
>                   info         # lot of human readable device infos, previous
>                                # found in /proc/driver/pktcdvd[0-7]
>
>

Also added class_device's below of /sys/class/pktcdvd , so that
the file layout is now:

/sys/class/pktcdvd/pktcdvd[0-7]/
                         dev
                         uevent


> Use /sys/class/pktcdvd/ and use struct device instead of struct
> class_device, so I don't have to convert the code later

Hmm, sorry. Don't know how to do this. The only thing i found
is the code in class.c, where struct class_device is used to create
these "dev" and "uevent" files...


Any comments?

-Thomas Maier
