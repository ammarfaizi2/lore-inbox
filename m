Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267317AbSLRSiB>; Wed, 18 Dec 2002 13:38:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267318AbSLRSiB>; Wed, 18 Dec 2002 13:38:01 -0500
Received: from mrelay1.cc.umr.edu ([131.151.1.120]:41930 "EHLO smtp.umr.edu")
	by vger.kernel.org with ESMTP id <S267317AbSLRShy> convert rfc822-to-8bit;
	Wed, 18 Dec 2002 13:37:54 -0500
X-MIMEOLE: Produced By Microsoft Exchange V6.0.6249.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Subject: RE: 3ware driver in 2.4.x and 2.5.x not compatible with 6x00 series cards
Date: Wed, 18 Dec 2002 12:45:51 -0600
Message-ID: <B578DAA4FD40684793C953B491D4879110D6E5@umr-mail7.umr.edu>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 3ware driver in 2.4.x and 2.5.x not compatible with 6x00 series cards
Thread-Index: AcKmxMkiqCnsIAbrQCScD/dq3TxElwAAAzZw
From: "Neulinger, Nathan" <nneul@umr.edu>
To: "Adam Radford" <aradford@3WARE.com>,
       "Dave Jones" <davej@codemonkey.org.uk>
Cc: <linux-kernel@vger.kernel.org>, "Uetrecht, Daniel J." <uetrecht@umr.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Your statement makes a hell of a lot more sense to me, but I'm just
going on what I was told, and observed behavior.

As soon as I followed his instructions, the symptom went away. Basically
on this one machine, I'm getting tons of command timed out, resetting
card messages. Along with unknown ioctl messages. Snippet from dmesg
follows:

3w-xxxx: scsi0: Unit #0: Command (0xdfeb4400) timed out, resetting card.
3w-xxxx: Unknown ioctl 0x46.
3w-xxxx: Unknown ioctl 0x46.
3w-xxxx: Unknown ioctl 0x46.
3w-xxxx: scsi0: Unit #0: Command (0xdfeb4400) timed out, resetting card.
3w-xxxx: Unknown ioctl 0x46.
3w-xxxx: Unknown ioctl 0x46.
3w-xxxx: Unknown ioctl 0x46.
3w-xxxx: Unknown ioctl 0x46.
3w-xxxx: Unknown ioctl 0x46.
3w-xxxx: scsi0: Unit #0: Command (0xdfeb4800) timed out, resetting card.
3w-xxxx: Unknown ioctl 0x46.
3w-xxxx: Unknown ioctl 0x46.
3w-xxxx: Unknown ioctl 0x46.
3w-xxxx: scsi0: Unit #0: Command (0xdfeb4800) timed out, resetting card.

Have not seen any of those with the .016 driver.

I'm more than happy to test any changes/etc. to make this go away with
current drivers, but it'll need to be code for 2.4.x as I haven't
started doing anything with 2.5/2.6 yet. 

-- Nathan

------------------------------------------------------------
Nathan Neulinger                       EMail:  nneul@umr.edu
University of Missouri - Rolla         Phone: (573) 341-4841
Computing Services                       Fax: (573) 341-4216


> -----Original Message-----
> From: Adam Radford [mailto:aradford@3WARE.com] 
> Sent: Wednesday, December 18, 2002 12:42 PM
> To: 'Dave Jones'; Neulinger, Nathan
> Cc: linux-kernel@vger.kernel.org; Uetrecht, Daniel J.
> Subject: RE: 3ware driver in 2.4.x and 2.5.x not compatible 
> with 6x00 series cards
> 
> 
> Who from 3ware told you it isn't compatible?  That's totally bogus.  
> It's completely compatible.
> 
> 3ware supports 6, 7, and 8000 series cards with a single driver in 
> 2.2, 2.4, and 2.5 trees.
> 
> If it isn't working for you, let me know.
> 
> -Adam
> 
> -----Original Message-----
> From: Dave Jones [mailto:davej@codemonkey.org.uk]
> Sent: Wednesday, December 18, 2002 10:26 AM
> To: Nathan Neulinger
> Cc: linux-kernel@vger.kernel.org; uetrecht@umr.edu
> Subject: Re: 3ware driver in 2.4.x and 2.5.x not compatible with 6x00
> series cards
> 
> 
> On Wed, Dec 18, 2002 at 12:10:54PM -0600, Nathan Neulinger wrote:
>  > According to 3Ware, the driver in the 2.4.x and (I assume) 
> 2.5.x is no
>  > longer compatible with the 6xxx series cards. 
>  > I don't know what we'll do with this situation when we 
> move to 2.6, cause
>  > right now, it looks like we are completely screwed. The old driver 
>  > obviously will not compile on 2.6 since the API's have changed. 
> 
> Any idea at which point the 2.5 driver stopped working ?
> It may not be that much work to bring that version up to date as
> a 3ware-old.c driver in a worse-case scenario.
> 
> This would be huge code duplication however, and would be much
> better fixed by having the driver detect which card its running
> on, and 'do the right thing' wrt which firmware it needs.
> 
> 		Dave
> 
> -- 
> | Dave Jones.        http://www.codemonkey.org.uk
> | SuSE Labs
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
