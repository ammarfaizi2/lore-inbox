Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273507AbRIUNIK>; Fri, 21 Sep 2001 09:08:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273509AbRIUNIA>; Fri, 21 Sep 2001 09:08:00 -0400
Received: from [195.66.192.167] ([195.66.192.167]:6406 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S273507AbRIUNHs>; Fri, 21 Sep 2001 09:07:48 -0400
Date: Fri, 21 Sep 2001 16:06:49 +0300
From: VDA <VDA@port.imtp.ilyichevsk.odessa.ua>
X-Mailer: The Bat! (v1.44)
Reply-To: VDA <VDA@port.imtp.ilyichevsk.odessa.ua>
Organization: IMTP
X-Priority: 3 (Normal)
Message-ID: <12927198559.20010921160649@port.imtp.ilyichevsk.odessa.ua>
To: linux-kernel@vger.kernel.org
Subject: smbmount is unfriendly to RO root fs
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Samba folks,

I keep my root fs RO.
My /etc/mtab is symlinked to /proc/mounts.

When i try
# mount -t smbfs //host/share /mnt
mount fails trying to modify /etc/mtab.

# mount -n -t smbfs //host/share /mnt
fails too ( -n is unsupported for smbmount)

Moreover, since I use automount, even fixing smbmount
to support -n would not work: automount will not
pass -n to smbmount.

The most sensible way to make smbmount work is to
print some diagnostic ("can't update /etc/mtab")
and continue.

And yes, I verified that with RW root fs it works.
Given amount of troubles I have with RO root,
I think not many people actually trying this
(which is excellent security measure),
and lots of tools break (ldconfig, /dev/log etc etc etc).
-- 
Best regards, VDA
mailto:VDA@port.imtp.ilyichevsk.odessa.ua


