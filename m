Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312862AbSCVVzM>; Fri, 22 Mar 2002 16:55:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312864AbSCVVyx>; Fri, 22 Mar 2002 16:54:53 -0500
Received: from twilight.ucw.cz ([195.39.74.230]:17119 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S312862AbSCVVyH>;
	Fri, 22 Mar 2002 16:54:07 -0500
Date: Fri, 22 Mar 2002 22:53:29 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: John Langford <jcl@cs.cmu.edu>
Cc: Martin Dalecki <dalecki@evision-ventures.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
        ahaas@neosoft.com, dave@zarzycki.org, ben.de.rydt@pandora.be
Subject: Re: BUG: 2.4.18 & ALI15X3 DMA hang on boot
Message-ID: <20020322225329.B3252@ucw.cz>
In-Reply-To: <3C9B0D9F.5030102@evision-ventures.com> <200203221956.g2MJuhK32671@gs176.sp.cs.cmu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 22, 2002 at 02:56:43PM -0500, John Langford wrote:

> I went nuts with printk statements and managed to isolate the hang to
> one particular line of code.  The final printk in this code fragment
> never gets executed.  
> 
>                 } else if (m5229_revision >= 0xC3) {
> 		        /*
>                          * 1553/1535 (m1533, 0x79, bit 1)
>                          */
>                         printk("ata66_ali15x3           } else if (m5229_revisi\on >= 0xC3) {\n");
>                         pci_write_config_byte(isa_dev, 0x79, tmpbyte | 0x02);
>                 }
>                 printk("ata66_ali15x3 endif\n");
> 
> Art, Dave, and Ben may or may not have the same problem.  It would be
> interesting to know if they get a hang here.
> 
> Any ideas for fixing?

What happens if you just remove the pci_write_config_byte() call?
It should be pretty harmless to remove it (on normal systems).

-- 
Vojtech Pavlik
SuSE Labs
