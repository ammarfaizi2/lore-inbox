Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261701AbTAIG7p>; Thu, 9 Jan 2003 01:59:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261721AbTAIG7o>; Thu, 9 Jan 2003 01:59:44 -0500
Received: from adsl-66-112-90-25-rb.spt.centurytel.net ([66.112.90.25]:1664
	"EHLO carthage") by vger.kernel.org with ESMTP id <S261701AbTAIG7o>;
	Thu, 9 Jan 2003 01:59:44 -0500
Date: Thu, 9 Jan 2003 00:56:42 -0600
From: James Curbo <phoenix@sandwich.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andre Hedrick <andre@linux-ide.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: small fix for nforce ide chipset driver in 2.5.54
Message-ID: <20030109065642.GA6251@carthage>
Reply-To: James Curbo <phoenix@sandwich.net>
References: <20030108075539.GA4128@carthage> <1042034033.24099.2.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1042034033.24099.2.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.4i
X-Operating-System: Debian GNU/Linux
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jan 08, Alan Cox wrote:
> On Wed, 2003-01-08 at 07:55, James Curbo wrote:
> > so I added a #define for PCI_DEVICE_ID_NVIDIA_NFORCE_IDE as 0x0065. It
> > compiled fine and I am in fact running that kernel now. I would have
> > just sent a patch but I am new to kernel hacking, this is just a one
> > liner and I'm sure you know where it goes better than I do.
> 
> Someone deleted it about 2.5.50, and though I sent in the fix twice Linus
> still hasn't applied it 8(

Well, I thought this deal was over but apparently not. My 2.5.54 kernel
is still working fine, but when I compiled 2.4.20-ac2, it didn't pick up
my Nforce2 IDE. On a whim I checked include/linux/pci_ids.h and it has a
different PCI ID for PCI_DEVICE_ID_NVIDIA_NFORCE_IDE, namely 0x01bc.
(lspci -v reports 0x0065 here). Perhaps 0x01bc is the nforce1 ide
chipset and 0x0065 is the nforce2 ide chipset?
		
-- 
James Curbo <hannibal@adtrw.org> <phoenix@sandwich.net>
GPG public key available at http://sandwich.net/~phoenix/keys/
