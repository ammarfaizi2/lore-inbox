Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263571AbRFAP3G>; Fri, 1 Jun 2001 11:29:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263573AbRFAP24>; Fri, 1 Jun 2001 11:28:56 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:927 "HELO havoc.gtf.org")
	by vger.kernel.org with SMTP id <S263571AbRFAP2w>;
	Fri, 1 Jun 2001 11:28:52 -0400
Message-ID: <3B17B4B0.9A805766@mandrakesoft.com>
Date: Fri, 01 Jun 2001 11:28:48 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Marc Lehmann <pcg@goof.com>
Cc: Axel Thimm <Axel.Thimm@physik.fu-berlin.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Au-Ja <doelf@au-ja.de>, Yiping Chen <YipingChen@via.com.tw>,
        support@msi.com.tw, info@msi-computer.de, support@via-cyrix.de,
        John R Lenton <john@grulic.org.ar>
Subject: Re: VIA's Southbridge bug: Latest (pseudo-)patch
In-Reply-To: <20010519110721.A1415@pua.nirvana> <20010601171848.F467@cerebro.laendle>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marc Lehmann wrote:
> one thing I found out using triel and error is that setting "PCI Delay
> Transaction" to enabled causes data corruption on WRITE to my ide drives
> connected to an Promise Ultra 100 PCI controlelr (I didn't get any
> corruption on the devices connected to the via ide interface, presumably
> because my bios already had the right fix).
> 
> So, while the every pci master grant setting apperently fixes the internal
> via ide interface corruption the PCI Delay Transaction option also must be
> buggy (or my promise controller is) and causes data corruption at least
> with an additional promise ultra 100.

I do not mean to point fingers, but don't assume Via is at fault here. 
Once you get into the area of flushing data (or not flushing, which is
what delayed txn would imply), it is entirely possible that the driver
simply does not support what occurs when the PCI Delay Txn option is
set.

-- 
Jeff Garzik      | Disbelief, that's why you fail.
Building 1024    |
MandrakeSoft     |
