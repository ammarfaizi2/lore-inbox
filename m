Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424279AbWLBV5v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424279AbWLBV5v (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Dec 2006 16:57:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424324AbWLBV5v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Dec 2006 16:57:51 -0500
Received: from mailer-b2.gwdg.de ([134.76.10.29]:62147 "EHLO mailer-b2.gwdg.de")
	by vger.kernel.org with ESMTP id S1424279AbWLBV5u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Dec 2006 16:57:50 -0500
Date: Sat, 2 Dec 2006 22:56:38 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Willy Tarreau <w@1wt.eu>
cc: William Estrada <MrUmunhum@popdial.com>, linux-kernel@vger.kernel.org
Subject: Re: Mounting NFS root FS
In-Reply-To: <20061202211522.GB24090@1wt.eu>
Message-ID: <Pine.LNX.4.61.0612022253280.25553@yvahk01.tjqt.qr>
References: <4571CE06.4040800@popdial.com> <Pine.LNX.4.61.0612022006170.25553@yvahk01.tjqt.qr>
 <20061202211522.GB24090@1wt.eu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>> > I have been trying to make FC5's kernel do a boot with an NFS root file
>> > system.  I see
>> > the support is in the kernel(?).  I have tried this:
>> >
>> >> root=/dev/nfs nfsroot=10.1.1.12:/tftpboot/NFS/Root_FS
>> 
>> This feature is almost deprecated. One is supposed to use initramfs,
>> /sbin/ip or some DHCP client, and a mount program nowadays.
>
>But I think that there are plenty of light terminals still booting like
>this which will not be able to upgrade anymore then. Even right here,
>my web server (parisc) boot from the network that way. At least an
>initramfs would need to be able to cope with the same syntax,

No problem:

<<</init<<<
#!/bin/bash

for o in `cat /proc/cmdline`; do
    case "$o" in
        nfsroot=*)
            arg="${o##nfsroot=}";
            ;;
    esac;
done;

### further parse $arg
>>>

simplified example of how this can be accomplished. This is why
initrds/initramfs are so much more powerful than in-kernel software.


	-`J'
-- 
