Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269346AbUI3RBE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269346AbUI3RBE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Sep 2004 13:01:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269358AbUI3RBD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Sep 2004 13:01:03 -0400
Received: from scrye.com ([216.17.180.1]:12940 "EHLO mail.scrye.com")
	by vger.kernel.org with ESMTP id S269346AbUI3RA4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Sep 2004 13:00:56 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date: Thu, 30 Sep 2004 11:00:48 -0600
From: Kevin Fenzi <kevin-linux-kernel@scrye.com>
To: linux-kernel@vger.kernel.org
X-Mailer: VM 7.17 under 21.4 (patch 15) "Security Through Obscurity" XEmacs Lucid
Subject: Re: 2.6.9-rc3 software suspend (pmdisk) stopped working
X-Draft-From: ("scrye.linux.kernel" 72155)
References: <415C322A.6070405@0Bits.COM>
Message-Id: <20040930170053.51171A3414@voldemort.scrye.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

>>>>> "Mitch" == Mitch  <Mitch@0Bits.COM> writes:

Mitch> Kevin Fenzi <kevin-linux-kernel () scrye ! com> wrote:
>> What do you get from:
>> 
>> cat /sys/power/disk ?

Mitch> Do you mean /sys/power/state ? /sys/power/disk is for powering
Mitch> off the disk ? Anyhow here are both of them

/sys/power/disk is for deciding how to do suspend to disk. 
shutdown = do it with the in kernel code
platform = do it with the BIOS code

Mitch> 	~% cat /sys/power/disk shutdown ~% cat /sys/power/state
Mitch> standby mem disk

Mitch> Remember this worked fine in -rc2.

Yes, but in rc3 the merge between pmdisk and swsusp1 happened. 
It basically has totally changed between rc2 and rc3. 

So, looks like that setting is right. 

So if you wait until it's done writing out pages and hard power it
off, does it resume? 

Does it work if you boot with: 
acpi=off

>> If it says "platform" you might try:
>> 
>> echo "shutdown" > /sys/power/disk
>> 
>> I wonder how many of Pavel's speed improvment patches went in with
>> the pmdisk/swsusp merge in rc3? I guess I can try it and see. :)

Mitch> The speed improvement that made it stop working surely went in
Mitch> ;-)

Well, thats not one we want. ;) 

kevin
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Processed by Mailcrypt 3.5.8 <http://mailcrypt.sourceforge.net/>

iD8DBQFBXDvF3imCezTjY0ERAggZAJ45K56uCqeVpuq73m6T2KZsupiDqQCfbArn
vXqp6Gr+G63iTzxhNY7CzTo=
=S6ow
-----END PGP SIGNATURE-----
