Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277003AbRJCVss>; Wed, 3 Oct 2001 17:48:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277004AbRJCVsn>; Wed, 3 Oct 2001 17:48:43 -0400
Received: from web14807.mail.yahoo.com ([216.136.224.223]:30734 "HELO
	web14807.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S277002AbRJCVs3>; Wed, 3 Oct 2001 17:48:29 -0400
Message-ID: <20011003214858.97073.qmail@web14807.mail.yahoo.com>
Date: Wed, 3 Oct 2001 14:48:58 -0700 (PDT)
From: Linux Bigot <linuxopinion@yahoo.com>
Subject: Re: how to get virtual address from dma address
To: Kurt Ferreira <kferreir@esscom.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0110031525370.14852-100000@pogo.esscom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

oops! I am sorry. I did not meant "pci_unmap_single"
pci_unmap_single.

I meant to get a routine which does exactly opposite
of what pci_map_single does, i.e., give me a virtual
address for a dma address.

Some people suggested, bus_to_virt() is not good a
call.

Thanks

--- Kurt Ferreira <kferreir@esscom.com> wrote:
> I have to admit I have not been following this
> thread and I apologize if I
> am stating somethign already stated, but there is a
> call in 2.4 kernels
> called pci_unmap_single.  see
> Documentation/DMA-mapping.txt.  Now on some
> arch's this call does nothing (for example i386) but
> for some arch's
> (for example alpha's, and others) it does stuff.  I
> really would stay
> aways from the virt_to_phys family of calls as has
> been stated.
> 
> Hope this helps,
> Kurt
> 
> 
> On Wed, 3 Oct 2001, Linux Bigot wrote:
> 
> > Then why isn't there a call like
> pci_unmap_single()
> > 
> > 
> > Thanks
> > 
> > 
> > --- Ben Collins <bcollins@debian.org> wrote:
> > > On Wed, Oct 03, 2001 at 09:37:00AM -0700, Linux
> > > Bigot wrote:
> > > > Please tell me why can't I use bus_to_virt().
> > > 
> > > Because bus_to_virt/virt_to_bus is obsolete, and
> > > using it will make your
> > > driver non-portable to some architectures.
> > > 
> > > -- 
> > > 
> > >
> >
>
.----------=======-=-======-=========-----------=====------------=-=-----.
> > > /                   Ben Collins    --    Debian
> > > GNU/Linux                  \
> > > `  bcollins@debian.org  -- 
> bcollins@openldap.org 
> > > --  bcollins@linux.com  '
> > > 
> >
>
`---=========------=======-------------=-=-----=-===-======-------=--=---'
> > 
> > 
> > __________________________________________________
> > Do You Yahoo!?
> > NEW from Yahoo! GeoCities - quick and easy web
> site hosting, just $8.95/month.
> > http://geocities.yahoo.com/ps/info1
> > -
> > To unsubscribe from this list: send the line
> "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at 
> http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> > 
> 
> -- 
> 
> 
> 


__________________________________________________
Do You Yahoo!?
NEW from Yahoo! GeoCities - quick and easy web site hosting, just $8.95/month.
http://geocities.yahoo.com/ps/info1
