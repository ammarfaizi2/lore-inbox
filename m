Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291774AbSBTLaO>; Wed, 20 Feb 2002 06:30:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291775AbSBTLaF>; Wed, 20 Feb 2002 06:30:05 -0500
Received: from dial249.pm3abing3.abingdonpm.naxs.com ([216.98.75.249]:32974
	"EHLO ani.animx.eu.org") by vger.kernel.org with ESMTP
	id <S291774AbSBTL36>; Wed, 20 Feb 2002 06:29:58 -0500
Date: Wed, 20 Feb 2002 06:38:41 -0500
From: Wakko Warner <wakko@animx.eu.org>
To: Chris Chabot <chabotc@reviewboard.com>
Cc: nimeesh <nimeesh24@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: network booting
Message-ID: <20020220063841.A9861@animx.eu.org>
In-Reply-To: <20020220084310.95958.qmail@web12304.mail.yahoo.com> <3C73865F.5060909@reviewboard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3i
In-Reply-To: <3C73865F.5060909@reviewboard.com>; from Chris Chabot on Wed, Feb 20, 2002 at 12:19:59PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Yes, a NFS root is (as far as i know!) the only networked drive type 
> linux can boot of.
> (ofcource any variation of local storage can be used, but then PXE is 
> not realy needed ;-)
> 
> For PXE documentation, check out /usr/share/doc/pxe-.... (atleast thats 
> on a redhat box), and for NFS-ROOT documentation check out 
> /usr/src/linux/Documentation/nfsroot.txt ;-)
> 
> What i found to work well for testing is to build a nfs-root kernel, 
> which i booted from HD for testing, with the nfsroot/dhcp command's 
> appended on the lilo line.. when that works, try to move it to PXE 
> boot-strapping.
> 
> Also, be carefull with pxe / dhcpd.. the order in which you start up 
> those servers will determine if it works or not (start dhcpd first, else 
> pxe will try to take the dhcp port).
> 
> Last, get your self a good boot-strapper. The one provided by intel in 
> the pxe package gave me more headaches then confort, so i switched to 
> BPBatch.
> 
> For more info on config files etc, check out this piece JMZ wrote:
> http://www.dnalounge.com/backstage/src/kiosk/

I've been wanting to know about this.  I'm running a machine right now with
an intel 10/100 management adapter.  My server is running a very old copy of
debian.  It has a modded tftp server from HPA.  It downloads the pxelinux
(same as syslinux, but for network).

I found out this method doesn't work on 3com adapters.  the tftpserver and
pxelinux are the newest things on that machine (which is about 2 years old
now)

Where can I find the pxe thing you mentioned above?

> >hello sir,
> >
> >I'm new to linux.I'm trying network booting of linux
> >system.System Conf.(intel 815 chipset ,PXE
> >bios,3com905c-ethernet card)
> >
> >In that i'm facing problem with kernel image and it's
> >file system.
> >
> >It gives me error as
> >kernel panic : unable to mount root fs on 01:00
> >
> >Is it necessary to use NFS or is it possible without
> >that? Any special specification while creating kernel
> >image and filesystem?
> >If any body can tell me any doc available on net,i'll
> >be very thankful.
> >
> >Thanks in Advance..
> >nimeesh patel
> >
> >
> >
> >=====
> >nimeesh patel
> >Development Engg.
> >DiviNet Access Tech Ltd.
> >Pune.
> >Ph.No. 91(20)5284696
> >
> >________________________________________________________________________
> >Looking for a job?  Visit Yahoo! India Careers
> >      Visit http://in.careers.yahoo.com
> >-
> >To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> >the body of a message to majordomo@vger.kernel.org
> >More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >Please read the FAQ at  http://www.tux.org/lkml/
> >
> 
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
-- 
 Lab tests show that use of micro$oft causes cancer in lab animals
