Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267805AbTBVAB2>; Fri, 21 Feb 2003 19:01:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267806AbTBVAB2>; Fri, 21 Feb 2003 19:01:28 -0500
Received: from amdext2.amd.com ([163.181.251.1]:55964 "EHLO amdext2.amd.com")
	by vger.kernel.org with ESMTP id <S267805AbTBVABZ>;
	Fri, 21 Feb 2003 19:01:25 -0500
From: richard.brunner@amd.com
X-Server-Uuid: BB5E7757-34FD-4146-B9CC-0950D472AE87
Message-ID: <99F2150714F93F448942F9A9F112634C013857BF@txexmtae.amd.com>
To: prandal@herefordshire.gov.uk, sowadski@umr.edu
cc: linux-kernel@vger.kernel.org
Subject: RE: 2.4.20 amd speculative caching
Date: Fri, 21 Feb 2003 18:11:19 -0600
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
X-WSS-ID: 12481FA2886414-01-01
Content-Type: text/plain;
 charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The best and reliable way to go is by the output of CPUID
(or cat /proc/cpuinfo)

if (((family == 6)  && (model >= 6)) || (family == 15)) {
    printk(KERN_INFO "Advanced speculative caching feature present\n");
    return 1;
}

If your AMD processor meets the above CPUID family and model, then
you need the patch. The decoder ring from any random
Product name to CPUID family and model number is not yet available ;-)

-Rich ...
[richard brunner amd.com -- AMD]
[Senior Member, Technical Staff] 

> -----Original Message-----
> From: Randal, Phil [mailto:prandal@herefordshire.gov.uk] 
> Sent: Thursday, February 20, 2003 8:50 AM
> To: Sowadski, Craig Harold (UMR-Student)
> Cc: linux-kernel@vger.kernel.org
> Subject: RE: 2.4.20 amd speculative caching
> 
> 
> According to Richard Brunner of AMD's email to the list dated 
> June 11, 2002,
> the cache attribute bug only affected Athlon XPs and MPs, so 
> that can't be
> the problem here, can it?
> 
> Cheers,
> 
> Phil
> 
> ---------------------------------------------
> Phil Randal
> Network Engineer
> Herefordshire Council
> Hereford, UK 
> 
> > -----Original Message-----
> > From: Dave Jones [mailto:davej@codemonkey.org.uk]
> > Sent: 20 February 2003 16:53
> > To: Sowadski, Craig Harold (UMR-Student)
> > Cc: Andi Kleen; linux-kernel@vger.kernel.org
> > Subject: Re: 2.4.20 amd speculative caching
> > 
> > 
> > On Wed, Feb 19, 2003 at 01:13:28PM -0600, Sowadski, Craig 
> > Harold (UMR-Student) wrote:
> > 
> >  > If it helps, here is my hardware config:
> >  > 
> >  > 	AMD Duron 1300MHZ
> >  > 	MSI K7T Turbo-2
> >  > 	ATI Radeon 7500 w/64mb
> >  > 	Redhat 8.0
> > 
> > Are you using the ATi firegl drivers ? If so, thats likely the
> > problem. (They ship an agpgart based upon 2.4.16 which lacks
> > the fixes needed).
> > 
> > 		Dave
> > 
> > -- 
> > | Dave Jones.        http://www.codemonkey.org.uk
> > | SuSE Labs
> > -
> > To unsubscribe from this list: send the line "unsubscribe 
> > linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> > 
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

