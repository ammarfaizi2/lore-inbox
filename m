Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261445AbRERTNF>; Fri, 18 May 2001 15:13:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261452AbRERTM4>; Fri, 18 May 2001 15:12:56 -0400
Received: from brussel-ns1.xs4all.be ([195.144.67.168]:11531 "EHLO
	brussel-ns1.xs4all.be") by vger.kernel.org with ESMTP
	id <S261445AbRERTMh>; Fri, 18 May 2001 15:12:37 -0400
Date: Fri, 18 May 2001 21:12:07 +0200 (CEST)
From: frank@gevaerts.be
To: "Eric S. Raymond" <esr@thyrsus.com>
cc: Tom Rini <trini@kernel.crashing.org>,
        Michael Meissner <meissner@spectacle-pond.org>,
        Keith Owens <kaos@ocs.com.au>, CML2 <linux-kernel@vger.kernel.org>,
        kbuild-devel@lists.sourceforge.net
Subject: Re: CML2 design philosophy heads-up
In-Reply-To: <20010518034307.A10784@thyrsus.com>
Message-ID: <Pine.LNX.4.21.0105182110290.2711-100000@turing.gevaerts.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 May 2001, Eric S. Raymond wrote:

> Tom Rini <trini@kernel.crashing.org>:
> > > > SCSI emulation over IDE, CONFIG_BLK_DEV_IDESCSI.  You have the SCSI mid
> > > > layer code but no SCSI hardware drivers.  It is a realistic case for an
> > > > embedded CD-RW appliance.
> > > 
> > > Or alternatively, you want to enable SCSI code, with no hardware driver,
> > > because you are going to build pcmcia, which builds the scsi drivers only
> > > if CONFIG_SCSI is defined, and the user might put in an Adaptec 1460B or
> > > 1480 scsi card into your pcmcia slot.
> > 
> > Both of these 'problems' assume that you can have IDE or PCMCIA on these
> > particular boxes.  Does anyone know if that's actually true?
> 
> The answer is: no, you can't.  
> 
> I found a feature list for the MVME147 on the web at
> <http://www.mcg.mot.com/cfm/templates/article.cfm?PageID=1095>.  It
> confirmed what thought I remembered from the Motorola site; no PCMCIA,
> no IDE/ATAPI.  As a matter of fact neither of these technologies
> existed yet when the board was being designed in the mid-1980s.

But it is a VME board. That means you can put a SCSI controller on the VME
bus (and these do exist, I have one right here). 

Frank

> 
> (The article I found is kind of interesting.  It's a dissection of the
> MVME147's design and history...narrated in first person.)
> 
> In any case, if this *had* been a problem, the right fix IMO would have
> been to split the SCSI symbol into SCSI and SCSI_DRIVERS and have
> constraints that would make SCSI and the presence of any SCSI card 
> imply SCSI_DRIVERS.
> -- 
> 		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>
> 
> The prestige of government has undoubtedly been lowered considerably
> by the Prohibition law. For nothing is more destructive of respect for
> the government and the law of the land than passing laws which cannot
> be enforced. It is an open secret that the dangerous increase of crime
> in this country is closely connected with this.
> 	-- Albert Einstein, "My First Impression of the U.S.A.", 1921
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

HI! I'm a .signature virus! cp me into your .signature file to help me spread!

