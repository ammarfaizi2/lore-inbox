Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313911AbSDQUko>; Wed, 17 Apr 2002 16:40:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313923AbSDQUkn>; Wed, 17 Apr 2002 16:40:43 -0400
Received: from roc-24-95-199-137.rochester.rr.com ([24.95.199.137]:61171 "EHLO
	www.kroptech.com") by vger.kernel.org with ESMTP id <S313911AbSDQUkn>;
	Wed, 17 Apr 2002 16:40:43 -0400
Date: Wed, 17 Apr 2002 16:40:37 -0400
From: Adam Kropelin <akropel1@rochester.rr.com>
To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Cc: Rick Stevens <rstevens@vitalstream.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.8-dj1 : arch/i386/kernel/smpboot.c error
Message-ID: <20020417204037.GA292@www.kroptech.com>
In-Reply-To: <20020417123044.GA8833@www.kroptech.com> <2673595977.1019032098@[10.10.2.3]> <20020417191718.GA8660@www.kroptech.com> <3CBDCD8D.1090802@vitalstream.com> <1831780000.1019076835@flay>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 17, 2002 at 01:53:55PM -0700, Martin J. Bligh wrote:
> > of C and the "&&" operator say that "if the first is false, the
> > second needn't even be evaluated".  
> 
> That's what I would have thought.
> But I don't think it's the second part that causes the warning,
> it's the thing *inside* the if clause.

Exactly.

> > Could that be what's causing the warning?
> 
> To my mind, that's why we should *not* be getting a warning ?

Indeed. The optimization step that (presumably) removes the body
of the if() must happen after the body has been fully evaluated.
Makes sense, I guess, now that I think about it...

--Adam
