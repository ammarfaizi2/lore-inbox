Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131481AbREIUXZ>; Wed, 9 May 2001 16:23:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131497AbREIUXQ>; Wed, 9 May 2001 16:23:16 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:50087 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S131481AbREIUXE>;
	Wed, 9 May 2001 16:23:04 -0400
Message-ID: <3AF9A726.BF819B30@mandrakesoft.com>
Date: Wed, 09 May 2001 16:23:02 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Pavel Roskin <proski@gnu.org>
Cc: Pete Zaitcev <zaitcev@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: Patch to make ymfpci legacy address 16 bits
In-Reply-To: <Pine.LNX.4.33.0105091553530.2104-100000@fonzie.nine.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Roskin wrote:
> If you want to play further with APM and ymfpci, I made a stub for proper
> apm support in the ymfpci driver. It's available here:
> 
> http://www.red-bean.com/~proski/linux/ymfpci_pm.diff

Why not use pci_driver::{suspend,resume} ?


> You may need to save some data in memory when the system goes to suspend
> and restore them afterwards. I believe that the PCI config space should be
> saved by BIOS. Everything else is the responsibility of the driver.

In ACPI land the kernel should save and restore the PCI device config
space and the PCI bus config space.  It is probably that similar is
necessary under APM.

	Jeff


-- 
Jeff Garzik      | Game called on account of naked chick
Building 1024    |
MandrakeSoft     |
