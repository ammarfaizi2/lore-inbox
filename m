Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266141AbRGGMSQ>; Sat, 7 Jul 2001 08:18:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266138AbRGGMSF>; Sat, 7 Jul 2001 08:18:05 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:45767 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S266141AbRGGMRz>;
	Sat, 7 Jul 2001 08:17:55 -0400
Message-ID: <3B46FDF1.A38E5BB6@mandrakesoft.com>
Date: Sat, 07 Jul 2001 08:17:53 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "David S. Miller" <davem@redhat.com>, Ben LaHaise <bcrl@redhat.com>,
        Jes Sorensen <jes@sunsite.dk>,
        "MEHTA,HIREN (A-SanJose,ex1)" <hiren_mehta@agilent.com>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: (reposting) how to get DMA'able memory within 4GB on 64-bit m
In-Reply-To: <E15Iqqm-0005jr-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> >  > that the expected lifespan for 32 bit systems is now less than 3 years, so
> >  > elaborate planning that delays implementation buys us nothing more than a
> >  > smaller window of usefulness.
> > Maybe by then only 64-bit cpus will matter.  Who knows.
> 
> Reality check.
> 
> Embedded PCI 32bit processors are going to be very common
> People are only now retiring 486's
> 
> So add another seven or eight years to your estimate

Given a little more context, I thought we were talking specifically
about 64bit-PCI-on-32bit-machines?

Assuming that, AFAICS Ben's statement seems more correct.

And IMHO we definitely should not optimize for 64-bit-on-32-bit case. 
Let CONFIG_HIGHMEM grow dma_addr_t to 64-bits, for that case only...

-- 
Jeff Garzik      | A recent study has shown that too much soup
Building 1024    | can cause malaise in laboratory mice.
MandrakeSoft     |
