Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293175AbSCWVoZ>; Sat, 23 Mar 2002 16:44:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311277AbSCWVoQ>; Sat, 23 Mar 2002 16:44:16 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:17668
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S293175AbSCWVoC>; Sat, 23 Mar 2002 16:44:02 -0500
Date: Sat, 23 Mar 2002 13:43:23 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Martin Dalecki <dalecki@evision-ventures.com>
cc: John Langford <jcl@cs.cmu.edu>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        linux-kernel@vger.kernel.org, ahaas@neosoft.com, dave@zarzycki.org,
        ben.de.rydt@pandora.be
Subject: Re: BUG: 2.4.18 & ALI15X3 DMA hang on boot
In-Reply-To: <3C9C7EF9.8020307@evision-ventures.com>
Message-ID: <Pine.LNX.4.10.10203231325370.1053-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 23 Mar 2002, Martin Dalecki wrote:

> John Langford wrote:
> > I went nuts with printk statements and managed to isolate the hang to
> > one particular line of code.  The final printk in this code fragment
> > never gets executed.  
> > 
> >                 } else if (m5229_revision >= 0xC3) {
> > 		        /*
> >                          * 1553/1535 (m1533, 0x79, bit 1)
> >                          */
> >                         printk("ata66_ali15x3           } else if (m5229_revisi\on >= 0xC3) {\n");
> >                         pci_write_config_byte(isa_dev, 0x79, tmpbyte | 0x02);
> 
> ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> 
> pci_write_config to isa_dev???? This looks at least suspicious.
> You may very well check whatever isa_dev is trully a PCI device
> handle or just some random IO base for ISA bus!

Martin, recall the WinXP issue on resources.  This is that hook.  I will
try to get more details out of the US base ALI people in a few days.

Just a heads up, 95% of all hosts have hooks in function zero of the
southbridge.  This is why I commented the other day about a perferred
ruleset of device hunting.

> >                 }
> >                 printk("ata66_ali15x3 endif\n");
> > 
> > Art, Dave, and Ben may or may not have the same problem.  It would be
> > interesting to know if they get a hang here.
> > 
> > Any ideas for fixing?
> 
> See above :-)

I have now several reports about Transmeta LifeBooks that are doing things
bad and not conforming to the docs.  This is not good.

Regards,

Andre Hedrick
LAD Storage Consulting Group

