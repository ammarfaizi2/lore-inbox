Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316567AbSFULV6>; Fri, 21 Jun 2002 07:21:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316569AbSFULV5>; Fri, 21 Jun 2002 07:21:57 -0400
Received: from linux.kappa.ro ([194.102.255.131]:18878 "EHLO linux.kappa.ro")
	by vger.kernel.org with ESMTP id <S316567AbSFULV4>;
	Fri, 21 Jun 2002 07:21:56 -0400
Date: Fri, 21 Jun 2002 14:24:05 +0300
From: Teodor Iacob <Teodor.Iacob@astral.kappa.ro>
To: Jamie Bennett <jamie_bennett@pcpmicro.co.uk>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: VIA Southbridges in 2.4.18-rc3
Message-ID: <20020621112405.GA20693@linux.kappa.ro>
References: <2130109F889CD5119FAD0050BA6F2D6B064A10@SERVER>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2130109F889CD5119FAD0050BA6F2D6B064A10@SERVER>
User-Agent: Mutt/1.3.25i
X-RAVMilter-Version: 8.3.0(snapshot 20011220) (linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.4.19-pre10 for example includes support for this southbridge
and it works fine for me..

On Fri, Jun 21, 2002 at 12:04:56PM +0100, Jamie Bennett wrote:
> I know this is from a while ago but are their any plans to include
> the via 8233a southbridge support in 2.4.19/20?
> 
> If not can somebody point me in the right direction on how I would
> modify timing.h and via82xxx.c from 2.5.* to enable it to work in 
> the 2.4.* kernels.
> 
> Yours
> 
> Jamie Bennett
> Software Engineer
> PCP Micro Product Ltd, Bath, England, BA2 3BT
> 
> Marcelo Tosatti wrote: 
> > On Fri, 22 Feb 2002, Florian Hars wrote: 
> >> Any reason why this: 
> >> <http://www.uwsg.indiana.edu/hypermail/linux/kernel/0202.1/0970.html> 
> >> isn't in rc3? My machine still works as it should.
> >> Do you mean adding the necessary PCI ID's ? 
> 
> That, and adding some code in drivers/ide/via82xxx.c, 
>   { "vt8233c", PCI_DEVICE_ID_VIA_8233C, 0x00, 0x2f, VIA_UDMA_100 }, 
> is right now ifdef'ed out, and the entry for the vt8233a, which is 
>   { "vt8233a", PCI_DEVICE_ID_VIA_8233A, 0x00, 0x2f, VIA_UDMA_133 },
> in 2.5.2, is missing (and there is no UDMA_133 in 2.4). 
> 
> Right now I am running a 2.4.18-pre9 with a slightly modified 
> drivers/ide/(timing.h|via82xxx.c) from 2.5.2, and it works with my 
> vt8233a and an UDMA-100 disk, but this is of course not a 
> conservative change. Maybe the patch by Vojtech Pavlik mentioned 
> in the message I referred to above is less radical. 
> 
> Yours, Florian. 
> 
> - To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org More majordomo info at
> <http://vger.kernel.org/majordomo-info.html> Please read the FAQ at
> <http://www.tux.org/lkml/> [
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
      Teodor Iacob,
Astral TELECOM Internet
