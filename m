Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270011AbRHEU1z>; Sun, 5 Aug 2001 16:27:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270005AbRHEU1p>; Sun, 5 Aug 2001 16:27:45 -0400
Received: from sdsl-66-80-62-153.dsl.sca.megapath.net ([66.80.62.153]:17673
	"EHLO ripple.fruitbat.org") by vger.kernel.org with ESMTP
	id <S270006AbRHEU11>; Sun, 5 Aug 2001 16:27:27 -0400
Date: Sun, 5 Aug 2001 13:26:21 -0700 (PDT)
From: "Peter A. Castro" <doctor@fruitbat.org>
To: Keith Owens <kaos@ocs.com.au>
cc: Kai Henningsen <kaih@khms.westfalen.de>, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: PPC? (Was: Re: [RFC] /proc/ksyms change for IA64) 
In-Reply-To: <29464.997040507@ocs3.ocs-net>
Message-ID: <Pine.LNX.4.21.0108051320320.6238-100000@gremlin.fruitbat.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Aug 2001, Keith Owens wrote:

> On 05 Aug 2001 11:29:00 +0200, 
> kaih@khms.westfalen.de (Kai Henningsen) wrote:
> >kaos@ocs.com.au (Keith Owens)  wrote on 02.08.01 in <22165.996722560@kao2.melbourne.sgi.com>:
> >
> >> The IA64 use of descriptors for function pointers has bitten ksymoops.
> >> For those not familiar with IA64, &func points to a descriptor
> >> containing { &code, &data_context }.
> >
> >That sounds suspiciously like what I remember from PPC. How is this solved  
> >on the PPC side?
> 
> Best guess, without access to a PPC box, is that it is not solved.  Any
> arch where function pointers go via a descriptor will have this
> problem.
> 
> PPC users, does /proc/ksyms contain the address of the function code or
> the address of a descriptor which points to the code?  It is easy to
> tell, if function entries in /proc/ksyms are close together (8-128
> bytes apart) and do not match the addresses in System.map then PPC has
> the same problem as IA64.  If this is true, what is the layout of a PPC
> function descriptor so I can handle that case as well?

It's an address of a function.  Verified by matching with the system map.
I'm not sure where to look for what you need, however.  I've checked the
ppc arch specific code, but it's not apparent to me what I'm looking for
(sorry, I'm still learning about the kernel's structure).  If you can
suggest what/where to look I'll dig it up for you. 

-- 
Peter A. Castro <doctor@fruitbat.org> or <Peter.Castro@oracle.com>
	"Cats are just autistic Dogs" -- Dr. Tony Attwood

