Return-Path: <linux-kernel-owner+willy=40w.ods.org-S271132AbUJUXvT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271132AbUJUXvT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 19:51:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271020AbUJUXqI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 19:46:08 -0400
Received: from fmr06.intel.com ([134.134.136.7]:53140 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S271099AbUJUXol convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 19:44:41 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [Linux-fbdev-devel] Re: Generic VESA framebuffer driver and Video card BOOT?
Date: Thu, 21 Oct 2004 16:44:26 -0700
Message-ID: <88056F38E9E48644A0F562A38C64FB6003287A2A@scsmsx403.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [Linux-fbdev-devel] Re: Generic VESA framebuffer driver and Video card BOOT?
Thread-Index: AcS3xyxcskQHiQAbTHyvj1oF6g3FLwAAD8+A
From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
To: "Pavel Machek" <pavel@ucw.cz>
Cc: "Kendall Bennett" <KendallB@scitechsoft.com>,
       <linux-kernel@vger.kernel.org>,
       <linux-fbdev-devel@lists.sourceforge.net>, <stefandoesinger@gmx.at>
X-OriginalArrivalTime: 21 Oct 2004 23:44:27.0064 (UTC) FILETIME=[E6BB8380:01C4B7C7]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>-----Original Message-----
>From: linux-kernel-owner@vger.kernel.org 
>[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Pavel Machek
>Sent: Thursday, October 21, 2004 4:23 PM
>To: Pallipadi, Venkatesh
>Cc: Kendall Bennett; linux-kernel@vger.kernel.org; 
>linux-fbdev-devel@lists.sourceforge.net; stefandoesinger@gmx.at
>Subject: Re: [Linux-fbdev-devel] Re: Generic VESA framebuffer 
>driver and Video card BOOT?
>
>Hi!
>
>> >> I have done some experiments with this video post stuff.
>> >> I think this should be done using x86 emulator rather than doing 
>> >> in real mode. The reason being, with an userlevel emulator 
>> >we can call
>> >> it at different times during resume. The current real 
>mode videopost
>> >> does 
>> >
>> >Actually Ole Rohne has patch that allows you to call real mode any
>> >time you want.
>> 
>> Yes. I tried Ole's patch. That helped on one of my laptops. But, on 
>> the other one it doesn't work. It goes into real mode but 
>never returns.
>> Both systems had Radeom 9000M cards, but one with older 
>version of the 
>> firmware (didn't work) and one with newer version.
>> 
>> IIRC, even Stefan had similar problems with Ole's patch.
>
>It did not work for me, either, but I verified that it works as
>expected if I comment out actuall call of BIOS. So the problem is not
>with Ole's patch but with bios, and it may be the same if you emulate
>it...
>
>[Of course, it will not crash whole system when emulated, but system
>without video is not too good, either].

Even I thought so. But, with the emulator it doesn't hang. It brings 
back my video. I double checked this using another vm86 emulator too. 
No hang even there. I couldn't figure out why Ole's patch won't work 
though. Right now I am using call_usermodehelper() to call the 
emulator during resume and the video comes back just fine on this 
system where Ole's patch didn't work.

Thanks,
Venki
