Return-Path: <linux-kernel-owner+willy=40w.ods.org-S271101AbUJUXWW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271101AbUJUXWW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 19:22:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271103AbUJUXRu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 19:17:50 -0400
Received: from fmr06.intel.com ([134.134.136.7]:22662 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S271093AbUJUXMD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 19:12:03 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [Linux-fbdev-devel] Re: Generic VESA framebuffer driver and Video card BOOT?
Date: Thu, 21 Oct 2004 16:10:30 -0700
Message-ID: <88056F38E9E48644A0F562A38C64FB60032879CA@scsmsx403.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [Linux-fbdev-devel] Re: Generic VESA framebuffer driver and Video card BOOT?
Thread-Index: AcS3wd6cIiKOehCnQneFXB0KzEcAfAAAJBSA
From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
To: "Pavel Machek" <pavel@ucw.cz>
Cc: "Kendall Bennett" <KendallB@scitechsoft.com>,
       <linux-kernel@vger.kernel.org>,
       <linux-fbdev-devel@lists.sourceforge.net>, <stefandoesinger@gmx.at>
X-OriginalArrivalTime: 21 Oct 2004 23:10:31.0039 (UTC) FILETIME=[292AC0F0:01C4B7C3]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>-----Original Message-----
>From: Pavel Machek [mailto:pavel@ucw.cz] 
>Sent: Thursday, October 21, 2004 4:00 PM
>To: Pallipadi, Venkatesh
>Cc: Kendall Bennett; linux-kernel@vger.kernel.org; 
>linux-fbdev-devel@lists.sourceforge.net
>Subject: Re: [Linux-fbdev-devel] Re: Generic VESA framebuffer 
>driver and Video card BOOT?
>
>Hi!
>
>> >The rest of the code you have above seems superfluous to me 
>as we have 
>> >never needed to do that. Then again we boot the card using the BIOS 
>> >emulator, which is different because it runs within a 
>> >protected machine 
>> >state.
>> >
>> >Have you taken a look at the X.org code? They have code in 
>> >there to POST 
>> >the video card also (either using vm86() or the BIOS emulator).
>> >
>> 
>> I have done some experiments with this video post stuff.
>> I think this should be done using x86 emulator rather than doing 
>> in real mode. The reason being, with an userlevel emulator 
>we can call
>> it at different times during resume. The current real mode videopost
>> does 
>
>Actually Ole Rohne has patch that allows you to call real mode any
>time you want.
>								Pavel

Yes. I tried Ole's patch. That helped on one of my laptops. But, on 
the other one it doesn't work. It goes into real mode but never returns.
Both systems had Radeom 9000M cards, but one with older version of the 
firmware (didn't work) and one with newer version.

IIRC, even Stefan had similar problems with Ole's patch.

Thanks,
Venki
