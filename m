Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264849AbRF1X1D>; Thu, 28 Jun 2001 19:27:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264945AbRF1X0x>; Thu, 28 Jun 2001 19:26:53 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:46764 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S264849AbRF1X0j>;
	Thu, 28 Jun 2001 19:26:39 -0400
Message-ID: <3B3BBD4E.BDDF63DA@mandrakesoft.com>
Date: Thu, 28 Jun 2001 19:27:10 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.6-pre5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Khachaturov, Vassilii" <Vassilii.Khachaturov@comverse.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: RFC: Changes for PCI
In-Reply-To: <6B1DF6EEBA51D31182F200902740436802678FB5@mail-in.comverse-in.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Khachaturov, Vassilii" wrote:
> 
> On Wed, 27 Jun 2001, Jeff Garzik wrote:
> 
> > However, I think the driver (only going by your
> description) would be
> > more correct to use a pointer to struct pci_dev.  We have a
> token in the
> > kernel that is guaranteed 100% unique to any given PCI device:  the
> > pointer to its struct pci_dev.
> 
> Is it? With a hotplug device removed and another one added,
> isn't there a slight chance that the pci_dev pointer to the new device
> will get allocated in place of the old one?

If you want to get pedantic, yes ;-)  The pci_dev pointer is unique for
the lifetime of the PCI device, which works just as well in the example
used in the thread.

-- 
Jeff Garzik      | Andre the Giant has a posse.
Building 1024    |
MandrakeSoft     |
