Return-Path: <linux-kernel-owner+w=401wt.eu-S1161019AbWLTXrG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161019AbWLTXrG (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 18:47:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161021AbWLTXrG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 18:47:06 -0500
Received: from smtp112.sbc.mail.mud.yahoo.com ([68.142.198.211]:22669 "HELO
	smtp112.sbc.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1161019AbWLTXrE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 18:47:04 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:X-YMail-OSG:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=d/kF9jxKNQ6AvbOU07GkeTOVpyy2vXnEi0vhzew9198kBA8QGaWfXvZ+OQTY7ENNLo22jm40mQKWcStBF6zN0eFfMPawxEEsw/iABChnys+uK2oQ3dicS7JBv0zfdpQs59FY0HR486FnJ2oovnhilqOkIbCyAyVJuzgP4GEyJgE=  ;
X-YMail-OSG: OcRXNiYVM1n1nixQY_IKNgOIdxuQJ8AcKIOjrM.3wQ1tP_JChrbGoyMtiZvrMFMOx3VX6Zze7UePk0omWLQiOsU1rvkr4D5jIdsE1HH1YopzqEH3u177UZT_7638IUPNA1wKZ7R1jgyESaWAxYM6SWMMDvBtG68c5ivyoeYTfZG1phE5P3cahNyR0BFz
From: David Brownell <david-b@pacbell.net>
To: "=?iso-8859-1?q?H=E5vard?= Skinnemoen" <hskinnemoen@gmail.com>
Subject: Re: [patch 2.6.20-rc1 0/6] arch-neutral GPIO calls
Date: Wed, 20 Dec 2006 15:46:57 -0800
User-Agent: KMail/1.7.1
Cc: "Linux Kernel list" <linux-kernel@vger.kernel.org>,
       "Andrew Morton" <akpm@osdl.org>, "Andrew Victor" <andrew@sanpeople.com>,
       "Bill Gatliff" <bgat@billgatliff.com>,
       "Haavard Skinnemoen" <hskinnemoen@atmel.com>, jamey.hicks@hp.com,
       "Kevin Hilman" <khilman@mvista.com>, "Nicolas Pitre" <nico@cam.org>,
       "Russell King" <rmk@arm.linux.org.uk>,
       "Tony Lindgren" <tony@atomide.com>,
       "pHilipp Zabel" <philipp.zabel@gmail.com>
References: <200611111541.34699.david-b@pacbell.net> <200612201304.03912.david-b@pacbell.net> <1defaf580612201530x4708cc5cs37801bf7d00a598b@mail.gmail.com>
In-Reply-To: <1defaf580612201530x4708cc5cs37801bf7d00a598b@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200612201546.58718.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 20 December 2006 3:30 pm, Håvard Skinnemoen wrote:
> On 12/20/06, David Brownell <david-b@pacbell.net> wrote:
> > Based on earlier discussion, I'm sending a refresh of the generic GPIO
> > patch, with several (ARM based) implementations in separate patches:
> >
> >  - Core patch, doc + <asm-arm/gpio.h> + <asm-generic/gpio.h>
> >  - OMAP implementation
> >  - AT91 implementation
> >  - PXA implementation
> >  - SA1100 implementation
> >  - S3C2410 implementation
> >
> > I know there's an AVR32 implementation too; and there's been interest
> > in this for some PPC support as well.
> 
> Great, thanks Dave. Unfortunately, I'm going to be more or less
> offline for the rest of the year, but FWIW, the AVR32 implementation
> is already in -mm as part of git-avr32.patch.

That's appropriate; after all, as a programming interface, it's
appropriate that there be multiple implementations!  Presumably
that doc is missing, but the API calls _should_ make sense on
their own.


> I guess I should check 
> and see if it's in sync with the rest.

I'd at most expect you're missing an #include <asm-generic/gpio.h>
for the cansleep variants ... which only got added because folk
agreed such spinlock-unsafe calls were needed, not because anyone
had a pressing near-term need for them.  (Unlike the spinlock-safe
functionality, which is _very_ widely implemented.)


> I'll refresh the atmel_spi patch when I get back to work in january.

Heh, maybe I can even try it out by then.  ;)

- Dave

