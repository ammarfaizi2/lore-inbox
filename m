Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130186AbRCBAgH>; Thu, 1 Mar 2001 19:36:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130191AbRCBAf6>; Thu, 1 Mar 2001 19:35:58 -0500
Received: from saturn.cs.uml.edu ([129.63.8.2]:55563 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S130183AbRCBAfo>;
	Thu, 1 Mar 2001 19:35:44 -0500
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200103020035.f220Z1M336921@saturn.cs.uml.edu>
Subject: Re: [PATCH] reiserfs patch for linux-2.4.2
To: hch@ns.caldera.de (Christoph Hellwig)
Date: Thu, 1 Mar 2001 19:35:01 -0500 (EST)
Cc: acahalan@cs.uml.edu (Albert D. Cahalan),
        hch@ns.caldera.de (Christoph Hellwig),
        zam@namesys.com (Alexander Zarochentcev), linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, reiser@namesys.com (Hans Reiser),
        reiserfs-dev@namesys.com
In-Reply-To: <20010301091803.A31546@caldera.de> from "Christoph Hellwig" at Mar 01, 2001 09:18:03 AM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig writes:
> On Wed, Feb 28, 2001 at 10:16:02PM -0500, Albert D. Cahalan wrote:
>> Christoph Hellwig writes:
>>
>>> Urgg. limits.h is a userlevel header...
>>>
>>> The attached patch will make similar atempts fail (but not this one as
>>> there is also a limits.h in gcc's include dir).
>>
>> There are very few files needed from gcc's include dir. Linux ought to
>> be able to survive without them. Linux is already gcc-specific anyway.
>
> I think we want stdarg.h from gcc...

Yes, just as apps want <linux/*.h> files.

The kernel can have a copy. If the stack frame layout changes enough
to cause trouble with stdarg.h, then most likely there will be huge
trouble in 42 other places.

If you insist on using whatever random stdarg.h might be on the
system, then just copy it into the build area. The compile might
even run a bit faster without the extra directory to search.
