Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315222AbSEIXLh>; Thu, 9 May 2002 19:11:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315223AbSEIXLg>; Thu, 9 May 2002 19:11:36 -0400
Received: from mailout02.sul.t-online.com ([194.25.134.17]:744 "EHLO
	mailout02.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S315222AbSEIXLf>; Thu, 9 May 2002 19:11:35 -0400
Date: Fri, 10 May 2002 01:11:16 +0200
From: Andi Kleen <ak@muc.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andi Kleen <ak@muc.de>, linux-kernel@vger.kernel.org
Subject: Re: PATCH & call for help: Marking ISA only drivers
Message-ID: <20020510011116.A1476@averell>
In-Reply-To: <20020510005007.B1327@averell> <E175xAz-0004kH-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 10, 2002 at 01:18:21AM +0200, Alan Cox wrote:
> > > > +if [ "$CONFIG_ISA" = "y" ]; then
> > > > +   dep_tristate 'Adaptec AHA152X/2825 support' CONFIG_SCSI_AHA152X $CONFIG_SCSI
> > > 
> > > 2825 is not ISA bus
> > 
> > What then ?
> 
> Vesa local bus

Ok, I'm assuming that there are no boxes with no ISA slots but VLB slots.
I guess that's safe. If someone really has a weird box were that is not true
I guess they'll have to live with defining CONFIG_ISA. 

In theory one could introduce an CONFIG_VLB, but I don't think it is 
worth it.

> > > > +if [ "$CONFIG_ISA" = "y" ]; then
> > > > +  dep_tristate 'Generic NCR5380/53c400 SCSI support' CONFIG_SCSI_GENERIC_NCR5380 $CONFIG_SCSI
> > > > +  if [ "$CONFIG_SCSI_GENERIC_NCR5380" != "n" ]; then
> > > 
> > > This is used in multiple non ISA situations.
> > 
> > Only on ancient motherboards (I remember having it on some really old EISA
> > machine) and non PC devices, no ? 
> 
> On just about anything. If you have some old (or new) random weird box
> then so long as you know the address this works. NCR5380 macrocells are
> still being used I'm afraid to say, and attached to pretty much any bus
> people can find.

Ok thanks, will change it.

-Andi
