Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312638AbSCVT4E>; Fri, 22 Mar 2002 14:56:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312816AbSCVTzy>; Fri, 22 Mar 2002 14:55:54 -0500
Received: from GS176.SP.CS.CMU.EDU ([128.2.198.136]:33432 "EHLO
	gs176.sp.cs.cmu.edu") by vger.kernel.org with ESMTP
	id <S312821AbSCVTzp>; Fri, 22 Mar 2002 14:55:45 -0500
Message-Id: <200203221956.g2MJuhK32671@gs176.sp.cs.cmu.edu>
To: Martin Dalecki <dalecki@evision-ventures.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
        ahaas@neosoft.com, dave@zarzycki.org, ben.de.rydt@pandora.be
Subject: Re: BUG: 2.4.18 & ALI15X3 DMA hang on boot 
In-Reply-To: Your message of "Fri, 22 Mar 2002 11:55:27 +0100."
             <3C9B0D9F.5030102@evision-ventures.com> 
Date: Fri, 22 Mar 2002 14:56:43 -0500
From: John Langford <jcl@cs.cmu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I went nuts with printk statements and managed to isolate the hang to
one particular line of code.  The final printk in this code fragment
never gets executed.  

                } else if (m5229_revision >= 0xC3) {
		        /*
                         * 1553/1535 (m1533, 0x79, bit 1)
                         */
                        printk("ata66_ali15x3           } else if (m5229_revisi\on >= 0xC3) {\n");
                        pci_write_config_byte(isa_dev, 0x79, tmpbyte | 0x02);
                }
                printk("ata66_ali15x3 endif\n");

Art, Dave, and Ben may or may not have the same problem.  It would be
interesting to know if they get a hang here.

Any ideas for fixing?

-John
