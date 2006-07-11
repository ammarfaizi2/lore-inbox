Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932472AbWGKGAc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932472AbWGKGAc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 02:00:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932482AbWGKGAc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 02:00:32 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:20710 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932472AbWGKGAc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 02:00:32 -0400
Message-ID: <44B33E7B.3040504@fr.ibm.com>
Date: Tue, 11 Jul 2006 08:00:27 +0200
From: Cedric Le Goater <clg@fr.ibm.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: "Randy.Dunlap" <rdunlap@xenotime.net>
CC: Chuck Ebbert <76306.1226@compuserve.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, hpa@zytor.com
Subject: Re: 2.6.18-rc1-mm1
References: <200607102302_MC3-1-C4A4-1385@compuserve.com> <20060710201506.7abbca37.rdunlap@xenotime.net>
In-Reply-To: <20060710201506.7abbca37.rdunlap@xenotime.net>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Randy.Dunlap wrote:
> On Mon, 10 Jul 2006 22:58:50 -0400 Chuck Ebbert wrote:
> 
>> On Sun, 9 Jul 2006 02:11:06 -0700, Andrew morton wrote:
>>
>>> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc1/2.6.18-rc1-mm1/
>> Warnings(?) during build:
>>
>> /home/me/linux/2.6.18-rc1-mm1-64/scripts/Kbuild.klibc:315: target `usr/kinit/ipconfig' given more than once in the same rule.
>> /home/me/linux/2.6.18-rc1-mm1-64/scripts/Kbuild.klibc:315: target `usr/kinit/nfsmount' given more than once in the same rule.
>> /home/me/linux/2.6.18-rc1-mm1-64/scripts/Kbuild.klibc:315: target `usr/kinit/run-init' given more than once in the same rule.
>> /home/me/linux/2.6.18-rc1-mm1-64/scripts/Kbuild.klibc:315: target `usr/kinit/fstype' given more than once in the same rule.
> 
> Yes, and these:
> 
> fs/ecryptfs/main.c:327: warning: format ‘%d’ expects type ‘int’, but argument 3 has type ‘size_t’
> fs/ecryptfs/crypto.c:1599: warning: format ‘%d’ expects type ‘int’, but argument 2 has type ‘size_t’
> fs/ecryptfs/crypto.c:1621: warning: format ‘%d’ expects type ‘int’, but argument 2 has type ‘size_t’
> fs/ecryptfs/crypto.c:1628: warning: format ‘%d’ expects type ‘int’, but argument 2 has type ‘size_t’
> fs/ecryptfs/crypto.c:1635: warning: format ‘%d’ expects type ‘int’, but argument 2 has type ‘size_t’
> fs/ecryptfs/crypto.c:1642: warning: format ‘%d’ expects type ‘int’, but argument 2 has type ‘size_t’
> fs/ecryptfs/crypto.c:1649: warning: format ‘%d’ expects type ‘int’, but argument 2 has type ‘size_t’
> fs/ecryptfs/crypto.c:1656: warning: format ‘%d’ expects type ‘int’, but argument 2 has type ‘size_t’
> drivers/acpi/executer/exmutex.c:268: warning: format ‘%X’ expects type ‘unsigned int’, but argument 4 has type ‘struct task_struct *’
> drivers/acpi/executer/exmutex.c:268: warning: format ‘%X’ expects type ‘unsigned int’, but argument 6 has type ‘struct task_struct *’

and these :

arch/i386/kernel/io_apic.c:2431: warning: 'vector' might be used
uninitialized in this function
drivers/scsi/libata-core.c:3055: warning: unused variable `i'
drivers/acpi/utilities/utmutex.c:260: warning: cast from pointer to integer
of different size
arch/s390/hypfs/inode.c:432: warning: initialization from incompatible
pointer type
arch/s390/hypfs/inode.c:433: warning: initialization from incompatible
pointer type

C.

---
 drivers/scsi/libata-core.c |    1 -
 1 file changed, 1 deletion(-)

Index: 2.6.18-rc1-mm1/drivers/scsi/libata-core.c
===================================================================
--- 2.6.18-rc1-mm1.orig/drivers/scsi/libata-core.c
+++ 2.6.18-rc1-mm1/drivers/scsi/libata-core.c
@@ -3052,7 +3052,6 @@ static void ata_dev_xfermask(struct ata_
        struct ata_port *ap = dev->ap;
        struct ata_host_set *hs = ap->host_set;
        unsigned long xfer_mask;
-       int i;

        /* Controller modes available */
        xfer_mask = ata_pack_xfermask(ap->pio_mask,
