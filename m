Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313559AbSDQTR0>; Wed, 17 Apr 2002 15:17:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313558AbSDQTRZ>; Wed, 17 Apr 2002 15:17:25 -0400
Received: from roc-24-95-199-137.rochester.rr.com ([24.95.199.137]:56562 "EHLO
	www.kroptech.com") by vger.kernel.org with ESMTP id <S313540AbSDQTRX>;
	Wed, 17 Apr 2002 15:17:23 -0400
Date: Wed, 17 Apr 2002 15:17:18 -0400
From: Adam Kropelin <akropel1@rochester.rr.com>
To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Cc: Frank Davis <fdavis@si.rr.com>, linux-kernel@vger.kernel.org,
        davej@suse.de, Brian Gerst <bgerst@didntduck.org>
Subject: Re: 2.5.8-dj1 : arch/i386/kernel/smpboot.c error
Message-ID: <20020417191718.GA8660@www.kroptech.com>
In-Reply-To: <20020417123044.GA8833@www.kroptech.com> <2673595977.1019032098@[10.10.2.3]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 17, 2002 at 08:28:19AM -0700, Martin J. Bligh wrote:
> Adam Kropelin wrote:
> > Even though clustered_apic_mode is 0, the compiler still complains
> > about the second one and the first one doesn't depend on
> > clustered_apic_mode at all.
> 
> Hmmm ... not sure why the compiler complains about the second one,
> that's very strange ;-)

I agree. The cpp ouput clealy shows

        if ((0) && (numnodes > 1)) {

so I'm not sure why there's a problem.

> I wonder if we can play the same trick we've played before ....
> haven't tested the appended, but maybe it, or something like it
> will work without the ifdef's?

IMHO, this sort of trickery in the name of improving readability
is misguided. To me, anyway, the #ifdef's are much easer to read than
magic name-changing macros buried in a header somewhere.

--Adam
