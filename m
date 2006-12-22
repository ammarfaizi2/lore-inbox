Return-Path: <linux-kernel-owner+w=401wt.eu-S1423004AbWLVOQ6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423004AbWLVOQ6 (ORCPT <rfc822;w@1wt.eu>);
	Fri, 22 Dec 2006 09:16:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423032AbWLVOQ6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Dec 2006 09:16:58 -0500
Received: from smtp1.telegraaf.nl ([217.196.45.193]:58128 "EHLO
	smtp1.telegraaf.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423004AbWLVOQ5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Dec 2006 09:16:57 -0500
Date: Fri, 22 Dec 2006 15:16:55 +0100
From: Ard -kwaak- van Breemen <ard@telegraafnet.nl>
To: Andrew Morton <akpm@osdl.org>
Cc: "Zhang, Yanmin" <yanmin.zhang@intel.com>,
       Chuck Ebbert <76306.1226@compuserve.com>,
       Yinghai Lu <yinghai.lu@amd.com>, take@libero.it, agalanin@mera.ru,
       linux-kernel@vger.kernel.org, bugme-daemon@bugzilla.kernel.org,
       "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [Bug 7505] Linux-2.6.18 fails to boot on AMD64 machine
Message-ID: <20061222141655.GE31882@telegraafnet.nl>
References: <117E3EB5059E4E48ADFF2822933287A401F2EB70@pdsmsx404.ccr.corp.intel.com> <20061222082248.GY31882@telegraafnet.nl> <20061222003029.4394bd9a.akpm@osdl.org> <20061222103005.GC31882@telegraafnet.nl> <20061222140059.GD31882@telegraafnet.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061222140059.GD31882@telegraafnet.nl>
User-Agent: Mutt/1.5.9i
X-telegraaf-MailScanner-From: ard@telegraafnet.nl
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 22, 2006 at 03:00:59PM +0100, Ard -kwaak- van Breemen wrote:
>     262         if (!irqs_disabled()) printk(__FILE__ "%s(): blaat: interrupts were enabled early@%d\n",__FUNCTION__,__LINE__);
>     263 
>     264         ide_init_hwif_ports(&hw, ide_default_io_base(index), 0, &hwif->irq);
------------------------------------------^^^^^^^^^^^^^^^^^^^^^^^^^^^
which does a         if (pci_find_device(PCI_ANY_ID, PCI_ANY_ID,
in include/asm-i386/ide.h

which should be really the part that does the irq enabling.

-- 
program signature;
begin  { telegraaf.com
} writeln("<ard@telegraafnet.nl> TEM2");
end
.
