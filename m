Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268220AbUHKURi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268220AbUHKURi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 16:17:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268216AbUHKURi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 16:17:38 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:7900 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S268215AbUHKURd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 16:17:33 -0400
Date: Wed, 11 Aug 2004 22:17:25 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Arnd Bergmann <arnd@arndb.de>, zippel@linux-m68k.org
Cc: Christoph Hellwig <hch@infradead.org>, wli@holomorphy.com,
       davem@redhat.com, geert@linux-m68k.org, schwidefsky@de.ibm.com,
       linux390@de.ibm.com, sparclinux@vger.kernel.org,
       linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
       kbuild-devel@lists.sourceforge.net
Subject: Re: architectures with their own "config PCMCIA"
Message-ID: <20040811201725.GJ26174@fs.tum.de>
References: <20040807170122.GM17708@fs.tum.de> <20040807181051.A19250@infradead.org> <20040807172518.GA25169@fs.tum.de> <200408072013.01168.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200408072013.01168.arnd@arndb.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 07, 2004 at 08:12:56PM +0200, Arnd Bergmann wrote:
>...
> On Samstag, 7. August 2004 19:25, Adrian Bunk wrote:
> > Is there eny reason for such options that are never visible nor enabled,  
> > or could they be removed?
> 
> Yes, the reason is that some other options depend on them. We added the
> PCMCIA option to arch/s390/Kconfig to stop kbuild from asking about
> some drivers that won't work anyway.
> 
> E.g. drivers/scsi/pcmcia starts with
> 
> menu "PCMCIA SCSI adapter support"
> 	depends on SCSI!=n && PCMCIA!=n && MODULES
> 
> which evaluate to true if the PCMCIA option is not known. Changing
> that to
> 
> menu "PCMCIA SCSI adapter support"
> 	depends on SCSI && PCMCIA && MODULES
> 
> solves this in a different way, but I'm not 100% sure if it still has
> the same meaning.

Roman, is it intentional that PCMCIA!=n is true if there's no PCMCIA 
option, or is it simply a bug?

> 	Arnd <><

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

