Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276434AbRJCQJb>; Wed, 3 Oct 2001 12:09:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276447AbRJCQJW>; Wed, 3 Oct 2001 12:09:22 -0400
Received: from cx97923-a.phnx3.az.home.com ([24.9.112.194]:53686 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S276434AbRJCQJP>;
	Wed, 3 Oct 2001 12:09:15 -0400
Message-ID: <3BBB3845.DAE47D27@candelatech.com>
Date: Wed, 03 Oct 2001 09:09:41 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3-12 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: jamal <hadi@cyberus.ca>
CC: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Robert Olsson <Robert.Olsson@data.slu.se>,
        Benjamin LaHaise <bcrl@redhat.com>, netdev@oss.sgi.com,
        Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [announce] [patch] limiting IRQ load, irq-rewrite-2.4.11-B5
In-Reply-To: <Pine.GSO.4.30.0110031157140.4833-100000@shell.cyberus.ca>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jamal wrote:
> 
> On Wed, 3 Oct 2001, Ben Greear wrote:
> 
> > jamal wrote:
> >
> > > No. NAPI is for any type of network activities not just for routers or
> > > sniffers. It works just fine with servers. What do you see in there that
> > > will make it not work with servers?
> >
> > Will NAPI patch, as it sits today, fix all IRQ lockup problems for
> > all drivers (as Ingo's patch claims to do), or will it just fix
> > drivers (eepro, tulip) that have been integrated with it?
> 
> Unfortunately amongst the three of us tulip seemed to be the most common.
> Robert has a gige intel. So patches appear only for those two drivers. I
> could write up a document on how to change drivers.
> 

So, couldn't your NAPI patch be used by drivers that are updated, and
let Ingo's patch be a catch-all for un-fixed drivers?  As we move foward,
more and more drivers support your version, and Ingo's patch becomes less
utilized.  So long as the patches are tuned such that yours keeps Ingo's
from being triggered on devices you support, there should be no real
conflict, eh?

Ben

> cheers,
> jamal

-- 
Ben Greear <greearb@candelatech.com>          <Ben_Greear@excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear
