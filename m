Return-Path: <linux-kernel-owner+w=401wt.eu-S1753302AbWL2N2e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753302AbWL2N2e (ORCPT <rfc822;w@1wt.eu>);
	Fri, 29 Dec 2006 08:28:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753348AbWL2N2e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Dec 2006 08:28:34 -0500
Received: from smtp0.telegraaf.nl ([217.196.45.192]:40743 "EHLO
	smtp0.telegraaf.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753302AbWL2N2c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Dec 2006 08:28:32 -0500
Date: Fri, 29 Dec 2006 14:27:59 +0100
From: Ard -kwaak- van Breemen <ard@telegraafnet.nl>
To: Andrew Morton <akpm@osdl.org>
Cc: Greg KH <greg@kroah.com>, "Zhang, Yanmin" <yanmin.zhang@intel.com>,
       Chuck Ebbert <76306.1226@compuserve.com>,
       Yinghai Lu <yinghai.lu@amd.com>, take@libero.it, agalanin@mera.ru,
       linux-kernel@vger.kernel.org, bugme-daemon@bugzilla.kernel.org,
       "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [Bug 7505] Linux-2.6.18 fails to boot on AMD64 machine
Message-ID: <20061229132759.GL912@telegraafnet.nl>
References: <117E3EB5059E4E48ADFF2822933287A401F2EB70@pdsmsx404.ccr.corp.intel.com> <20061222082248.GY31882@telegraafnet.nl> <20061222003029.4394bd9a.akpm@osdl.org> <20061222144134.GH31882@telegraafnet.nl> <20061222154234.GI31882@telegraafnet.nl> <20061228155148.f5469729.akpm@osdl.org> <20061229125108.GK912@telegraafnet.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061229125108.GK912@telegraafnet.nl>
User-Agent: Mutt/1.5.9i
X-telegraaf-MailScanner-From: ard@telegraafnet.nl
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 29, 2006 at 01:51:08PM +0100, Ard -kwaak- van Breemen wrote:
> I will try it on the right function, and see what we get.

In function: 186 static struct pci_dev * pci_find_subsys(unsigned
int vendor,

203        if (unlikely(list_empty(&pci_devices))) {
204                 printk("Pci device list empty, preventing down_read\n");
205                return NULL;
206         }

delivers:
ard@supergirl:~$ sudo grep -C1 'Pci device list empty' /var/log/kern.log
Dec 29 14:17:47 localhost kernel: include/asm-i386/ide.h ide_default_io_base(): blaat: interrupts were disabled@49
Dec 29 14:17:47 localhost kernel: Pci device list empty, preventing down_read
Dec 29 14:17:47 localhost kernel: include/asm-i386/ide.h ide_default_io_base(): blaat: interrupts were disabled@51
--
Dec 29 14:17:47 localhost kernel: include/asm-i386/ide.h ide_default_io_base(): blaat: interrupts were disabled@49
Dec 29 14:17:47 localhost kernel: Pci device list empty, preventing down_read
Dec 29 14:17:47 localhost kernel: include/asm-i386/ide.h ide_default_io_base(): blaat: interrupts were disabled@51
--
Dec 29 14:17:47 localhost kernel: include/asm-i386/ide.h ide_default_io_base(): blaat: interrupts were disabled@49
Dec 29 14:17:47 localhost kernel: Pci device list empty, preventing down_read
Dec 29 14:17:47 localhost kernel: include/asm-i386/ide.h ide_default_io_base(): blaat: interrupts were disabled@51
--
Dec 29 14:17:47 localhost kernel: include/asm-i386/ide.h ide_default_io_base(): blaat: interrupts were disabled@49
Dec 29 14:17:47 localhost kernel: Pci device list empty, preventing down_read
Dec 29 14:17:47 localhost kernel: include/asm-i386/ide.h ide_default_io_base(): blaat: interrupts were disabled@51
--
Dec 29 14:17:47 localhost kernel: include/asm-i386/ide.h ide_default_io_base(): blaat: interrupts were disabled@49
Dec 29 14:17:47 localhost kernel: Pci device list empty, preventing down_read
Dec 29 14:17:47 localhost kernel: include/asm-i386/ide.h ide_default_io_base(): blaat: interrupts were disabled@51
--
Dec 29 14:17:47 localhost kernel: include/asm-i386/ide.h ide_default_io_base(): blaat: interrupts were disabled@49
Dec 29 14:17:47 localhost kernel: Pci device list empty, preventing down_read
Dec 29 14:17:47 localhost kernel: include/asm-i386/ide.h ide_default_io_base(): blaat: interrupts were disabled@51
--
Dec 29 14:17:47 localhost kernel: include/asm-i386/ide.h ide_default_io_base(): blaat: interrupts were disabled@49
Dec 29 14:17:47 localhost kernel: Pci device list empty, preventing down_read
Dec 29 14:17:47 localhost kernel: include/asm-i386/ide.h ide_default_io_base(): blaat: interrupts were disabled@51
--
Dec 29 14:17:47 localhost kernel: include/asm-i386/ide.h ide_default_io_base(): blaat: interrupts were disabled@49
Dec 29 14:17:47 localhost kernel: Pci device list empty, preventing down_read
Dec 29 14:17:47 localhost kernel: include/asm-i386/ide.h ide_default_io_base(): blaat: interrupts were disabled@51
--
Dec 29 14:17:47 localhost kernel: include/asm-i386/ide.h ide_default_io_base(): blaat: interrupts were disabled@49
Dec 29 14:17:47 localhost kernel: Pci device list empty, preventing down_read
Dec 29 14:17:47 localhost kernel: include/asm-i386/ide.h ide_default_io_base(): blaat: interrupts were disabled@51
--
Dec 29 14:17:47 localhost kernel: include/asm-i386/ide.h ide_default_io_base(): blaat: interrupts were disabled@49
Dec 29 14:17:47 localhost kernel: Pci device list empty, preventing down_read
Dec 29 14:17:47 localhost kernel: include/asm-i386/ide.h ide_default_io_base(): blaat: interrupts were disabled@51

I don't see any other warnings, so I guess the patch is working now :-).


I will clean up the patches found on this list to fix and detect this.

program signature;
begin  { telegraaf.com
} writeln("<ard@telegraafnet.nl> TEM2");
end
.
