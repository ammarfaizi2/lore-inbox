Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262367AbTFBOls (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jun 2003 10:41:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262371AbTFBOls
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jun 2003 10:41:48 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:30182
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S262367AbTFBOlq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jun 2003 10:41:46 -0400
Subject: Re: [BK PATCHES] add ata scsi driver
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andre Hedrick <andre@linux-ide.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.10.10306020238050.23914-100000@master.linux-ide.org>
References: <Pine.LNX.4.10.10306020238050.23914-100000@master.linux-ide.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1054562206.7494.11.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 02 Jun 2003 14:56:47 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2003-06-02 at 10:46, Andre Hedrick wrote:
> Linus, my professional opinion is to follow Jeff's direction for 2.5/2.6.
> This will allow Linux to push open source to the hardware vendors.
> There are several bastardized scsi-ide drivers in ./scsi.
> 
> pci2000.c,h :: pci2220i.c,h :: psi240i.c,h + psi_*.h :: eata*

megaraid, i2o, 3ware, aacraid all also drive IDE devices too now
Promise new driver is using the scsi layer as well (because they do
command queuing as well as drive tagged queue stuff). I've been 
hacking on the SI stuff a bit and its also apparent our IDE PATA
layer won't support that well in a hurry either since it also
has command buffering.

