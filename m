Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264940AbTLKNDS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Dec 2003 08:03:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264941AbTLKNDS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Dec 2003 08:03:18 -0500
Received: from secure.comcen.com.au ([203.23.236.73]:24850 "EHLO
	xavier.etalk.net.au") by vger.kernel.org with ESMTP id S264940AbTLKNDD convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Dec 2003 08:03:03 -0500
From: Ross Dickson <ross@datscreative.com.au>
Reply-To: ross@datscreative.com.au
Organization: Dat's Creative Pty Ltd
To: Ian Kumlien <pomac@vapor.com>
Subject: Re: Fixes for nforce2 hard lockup, apic, io-apic, udma133 covered
Date: Thu, 11 Dec 2003 19:12:27 +1000
User-Agent: KMail/1.5.1
Cc: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>, linux-kernel@vger.kernel.org,
       AMartin@nvidia.com, kernel@kolivas.org
References: <200312072312.01013.ross@datscreative.com.au> <200312111655.25456.ross@datscreative.com.au> <1071143274.2272.4.camel@big.pomac.com>
In-Reply-To: <1071143274.2272.4.camel@big.pomac.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200312111912.27811.ross@datscreative.com.au>
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 11 December 2003 21:47, Ian Kumlien wrote:
> On Thu, 2003-12-11 at 07:55, Ross Dickson wrote:
> > albatron:/usr/src/mptable-2.0.15a # ./mptable -verbose
> > 
> > ===============================================================================
> > 
> > MPTable, version 2.0.15 Linux
> > 
> >  looking for EBDA pointer @ 0x040e, found, searching EBDA @ 0x0009fc00
> >  searching CMOS 'top of mem' @ 0x0009f800 (638K)
> >  searching default 'top of mem' @ 0x0009fc00 (639K)
> >  searching BIOS @ 0x000f0000
> > 
> >  MP FPS found in BIOS @ physical addr: 0x000f50b0
> > 
> > -------------------------------------------------------------------------------
> > 
> > MP Floating Pointer Structure:
> > 
> >   location:                     BIOS
> >   physical address:             0x000f50b0
> >   signature:                    '_MP_'
> >   length:                       16 bytes
> >   version:                      1.1
> >   checksum:                     0x00
> >   mode:                         Virtual Wire
> > 
> > -------------------------------------------------------------------------------
> > 
> > MP Config Table Header:
> > 
> >   physical address:             0x0xf0c00
> >   signature:                    '$ml$'
> >   base table length:            0
> >   version:                      1.6
> >   checksum:                     0x00
> >   OEM ID:                       'Ä
> >                                   ¸§'
> > °öProduct ID:                   '(
> > m'P
> >   OEM table pointer:            0x12d90e22
> >   OEM table size:               7964
> >   entry count:                  7964
> >   local APIC address:           0x1f1c1f1c
> >   extended table length:        65284
> >   extended table checksum:      255
> > 
> > -------------------------------------------------------------------------------
> > 
> > MP Config Base Table Entries:
> > 
> > --
> > MPTABLE HOSED! record type = 55
> > albatron:/usr/src/mptable-2.0.15a #
> > 
> 
> > Perhaps someone else could get mptable to run on their machine and send you
> > the result.
> 
> mptable dosn't seem to accept it's own options, anyways, heres the
> output.
> 
> mptable -extra -verbose -pirq
>  
> ===============================================================================
>  
> MPTable, version 2.0.15 Linux
>  
>  looking for EBDA pointer @ 0x040e, found, searching EBDA @ 0x0009fc00
>  searching CMOS 'top of mem' @ 0x0009f800 (638K)
>  searching default 'top of mem' @ 0x0009fc00 (639K)
>  searching BIOS @ 0x000f0000
>  
>  MP FPS found in BIOS @ physical addr: 0x000f5ce0
>  
> -------------------------------------------------------------------------------
>  
> MP Floating Pointer Structure:
>  
>   location:                     BIOS
>   physical address:             0x000f5ce0
>   signature:                    '_MP_'
>   length:                       16 bytes
>   version:                      1.1
>   checksum:                     0x00
>   mode:                         Virtual Wire
>  
> -------------------------------------------------------------------------------
>  
> MP Config Table Header:
>  
>   physical address:             0x0xf0c00
>   signature:                    ''
>   base table length:            1280
>   version:                      1.7
>   checksum:                     0x00
>   OEM ID:                       ''
>   Product ID:                   ''
>   OEM table pointer:            0x0000ffff
>   OEM table size:               0
>   entry count:                  65535
>   local APIC address:           0x000000c4
>   extended table length:        1
>   extended table checksum:      0
>  
> -------------------------------------------------------------------------------
>  
> MP Config Base Table Entries:
>  
> --
> Processors:     APIC ID Version State           Family  Model   Step    Flags
>                  0       0x 7    BSP, usable     15      15      15      0x1a00c035
>                  0       0x 0    AP, unusable    0       0       10      0x78ffff0a
> --
> MPTABLE HOSED! record type = 15
> 
> I couldn't find the source so i used a old RedHat rpm...
> (Asus A7N8X-X bios 1007)
>  
> -- 
> Ian Kumlien <pomac () vapor ! com> -- http://pomac.netswarm.net
> 

Thanks Ian

Also many thanks for pointing out the relevant section to look in with the AMD
cpu link that you sent - Credit where credit is due (assuming we are both on the
right track).

I had a read and refined your surmisings. I think the 
problem appears synchronous with the apic timer because of two reasons.
1) any apic irq can cause re-connection of the system bus after disconnect.
2) the apic timer irq in my examinations has the shortest path to an ack.

I also had a look back through the athlon cooler and power management 
postings and web site articles. I was blissfully ignorant of these issues when I
started and now I wonder what I have stepped into... Yuk

I submitted a support request to AMD, apologies for not cc'ing you, I kept
the cc's down to just nvidia and the mailing list. If you have not seen it yet
then it is here

http://lkml.org/lkml/2003/12/11/17

We hope....

Regards
Ross

