Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264754AbUD1LaO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264754AbUD1LaO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 07:30:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264735AbUD1LaN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 07:30:13 -0400
Received: from gizmo03bw.bigpond.com ([144.140.70.13]:9101 "HELO
	gizmo03bw.bigpond.com") by vger.kernel.org with SMTP
	id S264754AbUD1L3c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 07:29:32 -0400
From: Ross Dickson <ross@datscreative.com.au>
Reply-To: ross@datscreative.com.au
Organization: Dat's Creative Pty Ltd
To: Len Brown <len.brown@intel.com>, a.verweij@student.tudelft.nl
Subject: Re: IO-APIC on nforce2 [PATCH] + [PATCH] for nmi_debug=1 + [PATCH] for idle=C1halt, 2.6.5
Date: Wed, 28 Apr 2004 21:33:34 +1000
User-Agent: KMail/1.5.1
Cc: Jesse Allen <the3dfxdude@hotmail.com>,
       "Prakash K. Cheemplavam" <PrakashKC@gmx.de>,
       Craig Bradney <cbradney@zip.com.au>, christian.kroener@tu-harburg.de,
       linux-kernel@vger.kernel.org, "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
       Jamie Lokier <jamie@shareable.org>, Daniel Drake <dan@reactivated.net>,
       Ian Kumlien <pomac@vapor.com>, Allen Martin <AMartin@nvidia.com>
References: <Pine.GHP.4.44.0404271807470.6154-100000@elektron.its.tudelft.nl> <1083088854.2322.38.camel@dhcppc4>
In-Reply-To: <1083088854.2322.38.camel@dhcppc4>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200404282133.34887.ross@datscreative.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 28 April 2004 04:00, Len Brown wrote:
> On Tue, 2004-04-27 at 13:02, Arjen Verweij wrote:
> 
> > After having his box run with cat /dev/hda > /dev/null for a night
> > straight no lockup has occured. The brand of his motherboard is Shuttle.
> 
> My shuttle is a FN41 board in a SN41G2 system.
>

I have had 3 Albatron KM18G pro and one Epox8rga+.
 
> I found "rev 1.0" BIOS (FN41S00X of 12/18/2002) on Shuttle's ftp site
> and downgraded to that, but still no hang.

My Albatrons hang with bios R1.01, R1.01a, R1.04 which is latest, probably also
hang with earlier bios but have not tried. I have emailed Albatron in last couple
of weeks re Allen's comments on Nvidia reference bios and about lockups but
have had no response as yet.

My Epox hangs but does not have latest bios - don't have floppy hooked up in 
that box to flash it to latest bios as yet.

> 
> It may be this board never hangs no matter what,
> or perhaps C1 disconnect was simply disabled in that BIOS
> b/c there was no option for it in Advanced Chipset Features
> like there is for the most recent BIOS.

Maybe other MOBO manufacturers skimp on filter caps and regulator damping
ability and a resonance occurs in the on-board supply rails? Do Shuttle make
any claims to using an improved on board regulator? Or Shuttle may have 
always programmed more time in C1 cycle handshakes if such is 
configurable? 

> 
> Other things about my board.
> I run "optimized defaults", I don't overclock anything.
> Processor is an AMD XP 2200+
> Does anybody else see the hang with this processor model?
> I wonder if the hang is processor model or speed dependent?

I have tried XP2200, XP2400, XP2500, I know I get lockups with both t'bred
and barton cores. Epox mobo has been tried with both Aopen H-500A and 
Elanvital full size case and power supplies. My albatron are all in Aopen m-atx
H-400A cases.

> 
> > Does anyone have some input on how to tackle this problem?
> 
> Unfortunately I don't have tools for debugging nvidia + amd hardware.
> I would expect that those companies do, however.  So encouraging them
> to reproduce the hang internally may be the best way to go.

Ditto I figured out early on it could do with emulator or bond out cpu/chipset
and tried to draw in Nvidia and AMD starting in December last year.
http://linux.derkeiler.com/Mailing-Lists/Kernel/2003-12/2549.html

It was cc'd to Mr Allen Martin of Nvidia as were other emails on topic.
His reply was "\0" so I assumed he was on a long holiday or no longer worked
there. It has been good to hear from him on the topic some 4 months later.
Don't scare him off! -we appear to be making some progress. 

I also spoke to Mr Michael Apthorpe of AMD in Australia in December and 
forwarded the support request email who replied "Thanks Ross I will forwards
it on and see what comes back." But nothing has to date.

In January I spotted Mr Richard Brunner of AMD had previously corresponded
with the LKML so I emailed him and he was interested at the time but said
whilst he could not promise anything he would forward my query to the hardware
certification labs. And guess what - he was right to promise nothing as I have 
received "\0" to date.

I followed up with the AMD guys in February this year but again received "\0".

> 
> > buy Len the cheapest broken nforce2 board I can find at pricewatch.com and
> > have it shipped to his house :)
> 
> I got tangled in this b/c this board (actually, the reference BIOS for
> this chipset) had some unusual ACPI related failures.  If the failures
> turn out to be related to ACPI, I'll do what I can to help.  But I
> expect that hardware debugging tools may be necessary before the
> hang issue is completely explained and solved.

I have had good (100%) success in reproducing the fault with the Albatron 
KM18G pro MOBO. I needed m-atx form factor and distributor was local to me.
Makes very nice - cheap and stable system but only with the lockup workaround.

I also recollect that Windows had lockups with nforce2 for a while depending 
whether you ran the Nvidia or Microsoft driver.
http://lkml.org/lkml/2003/12/13/5
Anybody got the inside running on that one and what was different between the 
two drivers?

Regards
Ross.

> 
> -Len
> 
> 
> 
> 
> 

