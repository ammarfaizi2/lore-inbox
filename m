Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262059AbVBPSF4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262059AbVBPSF4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Feb 2005 13:05:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262060AbVBPSFz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Feb 2005 13:05:55 -0500
Received: from mail-ash.bigfish.com ([206.16.192.253]:1596 "EHLO
	mail83-ash-R.bigfish.com") by vger.kernel.org with ESMTP
	id S262059AbVBPSF1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Feb 2005 13:05:27 -0500
X-BigFish: VP
From: "Haven Skys" <hskys@frontbridge.com>
To: <linux-kernel@vger.kernel.org>
Subject: Help: kernel option root=/dev/nfs failing 2.6.10
Date: Wed, 16 Feb 2005 10:05:18 -0800
Message-ID: <004201c51452$131a6d60$2401a8c0@internal.bigfish.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.6626
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am attempting to create network bootable system with 2.6.10 and nfs and am
having trouble.

I am using grub and the boot goes without a hitch until the kernel attempts
to use the commands I've sent.

<SNIP from grub.conf>
bootp
root (nd)
kernel (nd)/redhat-2.6.10/kernel root=/dev/nfs ip=bootp
nfsroot=10.0.120.1:/diskless/redhat-2.6.10/
baseos
</SNIP>

Network booting machine X does fine until. It attempts to open the root
device.

<SNIP>
VFS: Cannot open root device "nfs" or unknown-block(0,255) Please append a
correct "root=" boot option Kernel panic - not syncing: VFS: Unable to mount
root fs on unknown-block(0,255) </SNIP>

It looks like the kernel isn't recognizing the virtual device /dev/nfs but
I've enabled all the NFS options and everything is compiled into the kernel.

Any ideas?


Thanks
Haven
 
 




FrontBridge introduces Message Archive and Secure Email. Get leading Enterprise Message Security services from FrontBridge. www.frontbridge.com.



