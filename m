Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264364AbTLYU6H (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Dec 2003 15:58:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264365AbTLYU6G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Dec 2003 15:58:06 -0500
Received: from citrine.spiritone.com ([216.99.193.133]:22424 "EHLO
	citrine.spiritone.com") by vger.kernel.org with ESMTP
	id S264364AbTLYU5x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Dec 2003 15:57:53 -0500
Date: Thu, 25 Dec 2003 12:57:21 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: azarah@nosferatu.za.org, Christoph Hellwig <hch@infradead.org>
cc: Andreas Jellinghaus <aj@dungeon.inka.de>,
       Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] add sysfs mem device support  [2/4]
Message-ID: <176520000.1072385840@[10.10.2.4]>
In-Reply-To: <1072381287.7638.52.camel@nosferatu.lan>
References: <20031223002126.GA4805@kroah.com> <20031223002439.GB4805@kroah.com> <20031223002609.GC4805@kroah.com> <20031223131523.B6864@infradead.org> <1072193516.3472.3.camel@fur> <20031223163904.A8589@infradead.org> <pan.2003.12.25.17.47.43.603779@dungeon.inka.de> <20031225184553.A25397@infradead.org> <1072381287.7638.52.camel@nosferatu.lan>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> > On Tue, 23 Dec 2003 16:47:44 +0000, Christoph Hellwig wrote:
>> > > I disagree. For fully static devices like the mem devices the udev
>> > > indirection is completely superflous.
>> > 
>> > If sysfs does not contain data on mem devices, we will need makedev.
>> > 
>> > devfs did replace makedev. until udev can create all devices,
>> > it would need to re-introduce makedev.
>> 
>> So what?
>> 
> 
> So maybe suggest an solution rather than shooting one down all the
> time (which do seem logical, and is only apposed by one person currently
> - namely you =).

Nah, most of us just trust Christoph to fight the good fight for us ;-)

I for one certainly agree with him that for static stuff, we don't need 
(or want) udev. For inherently hotplug stuff like USB cameras, or large 
SCSI raid arrays, it's nice, but not for basic things like mem devices 
and the disk devices I'm booting from - it's just added complexity.

If it works as is, don't screw with it.

M.

