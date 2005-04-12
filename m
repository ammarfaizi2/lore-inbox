Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262383AbVDLMXQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262383AbVDLMXQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 08:23:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262382AbVDLMT1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 08:19:27 -0400
Received: from wproxy.gmail.com ([64.233.184.207]:3971 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262365AbVDLMRr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 08:17:47 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding;
        b=RmmW9Ei/1sqLxbXQfaZplTJrIKJoRpuuFQv3qnGW+TnsJ87bG5wXjwJ0NBM978eydxPC7trOeyIM91dHAwQGWx1NOiuNEkMa2xrWottTxBVtxavJuR3zydHzeYv7rumlFLXKY8mPkI9R52BwBgcOp8pyHKQivdcEvPwQDMzXavU=
Message-ID: <e3da09a705041205176403fe27@mail.gmail.com>
Date: Tue, 12 Apr 2005 08:17:46 -0400
From: Dan Berger <danberger@gmail.com>
Reply-To: Dan Berger <danberger@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Error When Booting: Resize Inode Not Valid
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello. I have recently switched to Linux to prevent any big errors...
but I guess I just have bad luck :)

Distro: Fedora Core 3
Kernel: 2.6.10-1.FC3_770
File system: ext3
Mobo: Gigabyte GA7VAXP+

This morning I went to reboot my machine normally after an 8 day
uptime. At boot, when it checked the root partition's integrity, I got
the error "Resize inode not valid" and I was dropped to the repair fs
console.

I ran fsck.ext3 numerous times, always answering yes to recreating the
resize inode... but to no avail. I even tried doing this from FC3's
rescue CD.

Interestingly enough, I can mount and unmount root and the rest of the
partitions when in the rescue CD.

I should mention that the last 2 bytes of the 512 byte MBR is aa 55
and the PBR of my root partition is entirely null. There is no aa 55
at the end.

I also checked out /var/log/dmesg and /var/log/messages and they both
ave nothing out of the ordinary.

Here is the Grub conf:
default=0
timeout=5
hiddenmenu
title Fedora Core (2.6.10-1.770_FC3)
root (hd0,0)
kernel /vmlinuz-2.6.10-1.770_FC3 ro root=LABEL=/1
initrd /initrd-2.6.10-1.770_FC3.img

Any light that you can shed on this troubling subject would be highly
appreciated,

Respectfully yours,

Dan J. Berger
