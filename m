Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266220AbTLIKIq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Dec 2003 05:08:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266224AbTLIKIp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Dec 2003 05:08:45 -0500
Received: from main.gmane.org ([80.91.224.249]:48601 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S266220AbTLIKIm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Dec 2003 05:08:42 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Holger Schurig <h.schurig@mn-logistik.de>
Subject: Re: State of devfs in 2.6?
Date: Tue, 09 Dec 2003 11:08:39 +0100
Message-ID: <br46v7$ab$1@sea.gmane.org>
References: <200312081536.26022.andrew@walrond.org> <20031208154256.GV19856@holomorphy.com> <pan.2003.12.08.23.04.07.111640@dungeon.inka.de> <20031208233428.GA31370@kroah.com> <1070953338.7668.6.camel@simulacron> <20031209071303.GB24876@Master.launchmodem.com> <br41h9$mth$1@sea.gmane.org> <buooeuifk5q.fsf@mcspd15.ucom.lsi.nec.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-Complaints-To: usenet@sea.gmane.org
User-Agent: KNode/0.7.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> * space. devfs doesn't eat space like the MAKEDEV approach.
> 
> Um, devfs does actually use a non-zero amount of code...

Yeh, it uses code. But if you look into a MAKEDEV bases file system, you see
hundreds of device files. Which uses inode and directory space on the
medium, may it be e2fs or jffs2.

I did not measure if the code for devfs is smaller as the code+config files
for udev. But I didn't make a statement about this.

> For a typical embedded device with about 5 entries in /dev I wouldn't
> be surprised if devfs used a lot _more_ space...

# find /dev | wc -l
    326

"Embedded" is not automatically a washing maschine with only 5 entries, it
can be a full blown Linux computer with 400 MHz, Framebuffer, USB Host, USB
Client, 7 serial ports for GSM, Barcode Scanner, Whatever, and so on. Like
our device.

However, even on such hardware-rich devices you usually have a constraint on
Flash Memory size. So having things small & simple is nice. That makes room
for the user applications & data.

-- 
Try Linux 2.6 from BitKeeper for PXA2x0 CPUs at
http://www.mn-logistik.de/unsupported/linux-2.6/

