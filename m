Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161330AbWKEQiR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161330AbWKEQiR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Nov 2006 11:38:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161337AbWKEQiR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Nov 2006 11:38:17 -0500
Received: from hobbit.corpit.ru ([81.13.94.6]:13149 "EHLO hobbit.corpit.ru")
	by vger.kernel.org with ESMTP id S1161330AbWKEQiQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Nov 2006 11:38:16 -0500
Message-ID: <454E1370.5020403@tls.msk.ru>
Date: Sun, 05 Nov 2006 19:38:08 +0300
From: Michael Tokarev <mjt@tls.msk.ru>
Organization: Telecom Service, JSC
User-Agent: Thunderbird 1.5.0.7 (X11/20060915)
MIME-Version: 1.0
To: Oliver Neukum <oliver@neukum.org>
CC: Arjan van de Ven <arjan@infradead.org>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>, andrew@walrond.org,
       linux-kernel@vger.kernel.org
Subject: Re: Scsi cdrom naming confusion; sr or scd?
References: <20061105100926.GA2883@pelagius.h-e-r-e-s-y.com> <Pine.LNX.4.61.0611051232580.12727@yvahk01.tjqt.qr> <1162735599.3160.91.camel@laptopd505.fenrus.org> <200611051541.37283.oliver@neukum.org>
In-Reply-To: <200611051541.37283.oliver@neukum.org>
X-Enigmail-Version: 0.94.0.0
OpenPGP: id=4F9CF57E
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oliver Neukum wrote:
> Am Sonntag, 5. November 2006 15:06 schrieb Arjan van de Ven:
>> and this is why it's wrong to make naming policy a kernel thing!
>> Userspace is the right place to do this (and there I suspect the name
>> will end up being /dev/cdrom)...... the kernel really shouldn't care at
>> all what the name is.
> 
> I have to disagree. This precisely shows that the reverse is true.
> This way the chance of having a default name guaranteed to work
> is lost. If you want an alternate name, use a symlink.

Yes, YES.  That's what I always tried to say during similar discussions.

In additional to the "default name" (which is, strictly speaking, is NOT
"default" in many cases, such as when you have USB drives connected or
not and all the sdX and srY renumbering, but that's different story, and
many devices are still has "default name"), there's another reason: kernel
should name the devices *somehow*, and it'd better the name exists in /dev.
Think /proc/partitions for example -- I don't damn want to see device numbers
(major+minor) in there, and all the tools searching the whole /dev to find
the device node for it.  By the way, lilo breaks if it can't find device
nodes in /dev listed in /proc/partitions, and I can't blame it.

/mjt
