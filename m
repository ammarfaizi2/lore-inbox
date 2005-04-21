Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261345AbVDUMyu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261345AbVDUMyu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Apr 2005 08:54:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261342AbVDUMyu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Apr 2005 08:54:50 -0400
Received: from rproxy.gmail.com ([64.233.170.201]:13115 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261349AbVDUMyl convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Apr 2005 08:54:41 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=for4qcSKfStfEd/VjNYrOiHl2DETJ+0FzNLCRo++6MGGwFNHaGiFgWRttxqX0xhd1bQCHmdv5diC8kqRHrr04xJMlyIJYANguqFRvfDbCH8zu5BW/fV9LQQXlR6zSvrmA+Y8rc4UCk0xDyUrSowsF7xs2NfR9hv86mNd7M7cRdQ=
Message-ID: <21d7e99705042105542127cce0@mail.gmail.com>
Date: Thu, 21 Apr 2005 22:54:41 +1000
From: Dave Airlie <airlied@gmail.com>
Reply-To: Dave Airlie <airlied@gmail.com>
To: Doug Ledford <dledford@redhat.com>
Subject: Re: nVidia stuff again
Cc: Helge Hafting <helge.hafting@aitel.hist.no>,
       Chris Friesen <cfriesen@nortel.com>, linux-kernel@vger.kernel.org
In-Reply-To: <1114085702.26866.137.camel@compaq-rhel4.xsintricity.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1113298455.16274.72.camel@caveman.xisl.com>
	 <425CEAC2.1050306@aitel.hist.no>
	 <20050413125921.GN17865@csclub.uwaterloo.ca>
	 <20050413130646.GF32354@marowsky-bree.de>
	 <20050413132308.GP17865@csclub.uwaterloo.ca>
	 <425D3924.1070809@nortel.com> <425E77BB.5010902@aitel.hist.no>
	 <1114021024.26866.63.camel@compaq-rhel4.xsintricity.com>
	 <21d7e997050420161234141e23@mail.gmail.com>
	 <1114085702.26866.137.camel@compaq-rhel4.xsintricity.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> Ha!  That's the whole damn point Dave.  Use your head.  Just because ATI
> is getting more complex with their GPU does *not* mean nVidia is.  Go

No I rely on things I read from hardware review websites and from the
GPU manufacturers to wonder what they are doing, unless putting more
transistors onto their chips is making them less complex, both ATI and
Nvidia are implementing chips primarily to implement DirectX features
(the biggest market), this means they are both heading toward the same
thing, with 3D graphics doing things on the GPU vs doing them in the
driver is going to be quite noticable you end up doing as much as
possible in the hardware,  also things like SLI are certainly more
complex not less..

ATI are making their chips less "complex" from a programming point of
view, the R300 for example has no fixed-function pipelines, for modern
apps, the shader language is translated to the GPU by the driver, for
older apps using the fixed-function pipeline the driver emulates it on
top of the programmable interface..

what this comes down to in the end is that the register interfaces are
probably converging, there are only so many ways you can send
instructions to a GPU via DMA..

> specs and they haven't.  Therefore, you can reliably discern absolutely
> *zero* information about the nVidia cards from a reference to ATI specs.

But we have some lowlevel knowledge for the Nvidia cards as well.. not
detailed but you can pick directions from the presentations they make
and marketing literature they release....
 
> "It's what you know, not what you think you know, that matters."  I
> don't know why nVidia keeps their specs secret.  All I know is what they
> tell the world.  But what I do know is that it's *possible* they could
> be telling the truth, and I have no proof otherwise, regardless of any
> suspicions.

Well when previously asked for the specs by other developers the
answer before has been IP issues, it may not be totally true now, I
think now they just don't want to support open source because they
don't believe there is any money in it...

ATI didn't release full specs for r200 because they were being nice,
the Weather Channel said we won't use your chips unless we have an
open source driver and one can only persume proceeded to purchase a
lot of chips i.e. it made monetary sense to ATI at the time.. since
then it hasn't ...

The IP reasons come from the fact that the specs they did release
didn't contain any information on how to program a lot of ATI
proprietary features..

Also it is peculiar that ATI release 2D programming specs for their
newer cards and give support to the 2D ATI driver in X, Nvidia support
the 2D NV driver in X, why not the 3D?,
Intel won't give out specs for their latest chipsets but they do
provide an open source 2D and 3D driver via Tungsten Graphics...

I'm thinking of doing up a bit of a presentation for KS on 3D drivers
and the technical issues they bring to the kernel (without even
mentioning licensing and derived works..)

Dave.
