Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267483AbUHPHtQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267483AbUHPHtQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 03:49:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267484AbUHPHtP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 03:49:15 -0400
Received: from fep01fe.ttnet.net.tr ([212.156.4.130]:55260 "EHLO
	fep01.ttnet.net.tr") by vger.kernel.org with ESMTP id S267482AbUHPHtE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 03:49:04 -0400
Message-ID: <412066BC.9040503@ttnet.net.tr>
Date: Mon, 16 Aug 2004 10:48:12 +0300
From: "O.Sezer" <sezeroz@ttnet.net.tr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.2) Gecko/20040308
X-Accept-Language: tr, en-us, en
MIME-Version: 1.0
To: Pete Zaitcev <zaitcev@redhat.com>
CC: linux-kernel@vger.kernel.org, marcelo.tosatti@cyclades.com
Subject: Re: [PATCH 2.4] blacklist a device in usb-storage
References: <mailman.1092508141.32379.linux-kernel2news@redhat.com> <20040815235204.0e9ec874@lembas.zaitcev.lan>
In-Reply-To: <20040815235204.0e9ec874@lembas.zaitcev.lan>
Content-Type: text/plain;
	charset=us-ascii;
	format=flowed
Content-Transfer-Encoding: 7bit
X-ESAFE-STATUS: Mail clean
X-ESAFE-DETAILS: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pete Zaitcev wrote:
> On Sat, 14 Aug 2004 21:22:20 +0300
> "O.Sezer" <sezeroz@ttnet.net.tr> wrote:
> 
> 
>>The disk in question is VID/PID=0b86:5110 32mb JMTek/eXputer disk.
>>http://www.qbik.ch/usb/devices/showdev.php?id=1092 says it can
>>never be supported through usb-storage because it claims to be
>>usb storage compliant but is not.
>>[...]
>>If there's any other way of preventing usb-storage to take-
>>over this disk, then tell me and despise my ignorance,
>>Otherwise, Marcelo please apply ;)
> 
> 
> I do not understand what the objective might be. Just do not
> use that thing with Linux kernel 2.4. Why do you wish "to revent
> usb-storage from taking over this disk"?
> 
> -- Pete

As I said above, I cannot prevent accidentals (VID/PIDs aren't
printed on the disk, yo know...) And usb-storage must not deal
with disks that it cannot deal with:
1. This particular disk can lead to panics as I said.
2. If someone ever writes a driver specific to this device (I
    know it's less than highly unlikely), than it would be also
    useful in that case if the disk isn't tried to be owned by
    usb-storage. That, I think applies as a general case, too.

Ozkan Sezer
