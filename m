Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135984AbRDTUAh>; Fri, 20 Apr 2001 16:00:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135985AbRDTUA2>; Fri, 20 Apr 2001 16:00:28 -0400
Received: from atlrel1.hp.com ([156.153.255.210]:44792 "HELO atlrel1.hp.com")
	by vger.kernel.org with SMTP id <S135984AbRDTUAS>;
	Fri, 20 Apr 2001 16:00:18 -0400
Date: Fri, 20 Apr 2001 14:00:03 -0600
To: "Eric S. Raymond" <esr@thyrsus.com>, Matthew Wilcox <willy@ldl.fc.hp.com>,
        linux-kernel@vger.kernel.org, parisc-linux@parisc-linux.org
Subject: Re: OK, let's try cleaning up another nit. Is anyone paying attention?
Message-ID: <20010420140003.M4217@zumpano.fc.hp.com>
In-Reply-To: <20010419203639.H4217@zumpano.fc.hp.com> <20010419230009.A32500@thyrsus.com> <20010419211749.I4217@zumpano.fc.hp.com> <20010420154743.A19618@thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010420154743.A19618@thyrsus.com>; from esr@thyrsus.com on Fri, Apr 20, 2001 at 03:47:43PM -0400
From: willy@ldl.fc.hp.com (Matthew Wilcox)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 20, 2001 at 03:47:43PM -0400, Eric S. Raymond wrote:
> CONFIG_BINFMT_SOM: arch/parisc/config.in arch/parisc/defconfig
> 
> Not used in code anywhere.  Can you get rid of this one?

Code not merged yet.

> CONFIG_DMB_TRAP: arch/parisc/kernel/sba_iommu.c
> CONFIG_FUNC_SIZE: arch/parisc/kernel/sba_iommu.c
> 
> Would you please take these out of the CONFIG_ namespace?  Changing the 
> prefix to CONFIGURE would do nicely.

Grant?  This is your code.

> CONFIG_GENRTC: arch/parisc/defconfig
> 
> This is a typo for GEN_RTC.  Please fix it or get rid of it.

in our tree it's in drivers/char/Makefile:

obj-$(CONFIG_GENRTC) += genrtc.o

this code was written by Sam Creasey as part of the sun3 port, and he
schlepped it into our tree too.  we have no GEN_RTC in our tree.

> CONFIG_HIL: arch/parisc/defconfig
> 
> Looks like an orphan.  Can you get rid of it?

code not yet merged.

> CONFIG_SERIAL_GSC: drivers/char/serial.c arch/parisc/defconfig
> 
> That reference pattern looks kind of weird.  Is this a bug?

it's old and needs to die properly.  i haven't had time to fix that yet.
