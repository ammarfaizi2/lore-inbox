Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261250AbVEQGe7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261250AbVEQGe7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 May 2005 02:34:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261249AbVEQGe7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 02:34:59 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:47537 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S261250AbVEQGez convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 02:34:55 -0400
From: Denis Vlasenko <vda@ilport.com.ua>
To: Christian Parpart <trapni@gentoo.org>, linux-kernel@vger.kernel.org
Subject: Re: I'm having 4GB RAM, but Linux sees just 3GB???
Date: Tue, 17 May 2005 09:34:26 +0300
User-Agent: KMail/1.5.4
References: <200505161604.10881.trapni@gentoo.org> <4288DCE7.9070508@didntduck.org> <200505161959.04440.trapni@gentoo.org>
In-Reply-To: <200505161959.04440.trapni@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200505170934.26701.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 16 May 2005 20:59, Christian Parpart wrote:
> (oops)
> 
> On Monday 16 May 2005 7:48 pm, Brian Gerst wrote:
> > >  BIOS-e820: 0000000000000000 - 0000000000094800 (usable)
> > >  BIOS-e820: 0000000000094800 - 00000000000a0000 (reserved)
> > >  BIOS-e820: 00000000000c2000 - 0000000000100000 (reserved)
> > >  BIOS-e820: 0000000000100000 - 00000000bff20000 (usable)
> > >  BIOS-e820: 00000000bff20000 - 00000000bff2e000 (ACPI data)
> > >  BIOS-e820: 00000000bff2e000 - 00000000bff80000 (ACPI NVS)
> > >  BIOS-e820: 00000000bff80000 - 00000000c0000000 (reserved)
> > >  BIOS-e820: 00000000e0000000 - 00000000f0000000 (reserved)
> > >  BIOS-e820: 00000000fec00000 - 00000000fec00400 (reserved)
> > >  BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
> > >  BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
> > >
> > > hmm... what does this mean?
> >
> > It means that there is a hole at 00000000c0000000 - 0000000100000000
> > (3GB-4GB) for PCI memory-mapped devices.  The 4th GB of RAM should be
> > remapped by the BIOS to 4GB-5GB, but isn't.  Your BIOS is either buggy
> > or misconfigured.
> 
> Aiiii, that's good news.
> 
> I found a "Memhole" area. But I never used to change these items. 
> Unfortunately, my TYAN board reference guide isn't telling me what to change 
> there for good - so - can you tell me where to find more information about 
> there?
> 
> If I remember correctly, it provided me the options ("Automatic"/"Manual") and 
> a value list with the following items:
>   64MB 128MB, 256MB, 512MB, 1024MB 2048MB, 3G, 3.5G.
> 
> and another list I can't remember by now.
> 
> but *playing* around with these values didn't help much (I just reduced my 
> memory in linux down to 2GB once but didn't find the right values for getting 
> 4GB).
> 
> So, what should I do then?

You should boot with different BIOS options and examine e820 map after
each boot, looking for setup where there is 1 Gig of RAM at 4G mark.

Also google for 'e820' to get some info on this stuff.
--
vda

