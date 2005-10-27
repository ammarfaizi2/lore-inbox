Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964991AbVJ0IZP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964991AbVJ0IZP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Oct 2005 04:25:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964992AbVJ0IZO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Oct 2005 04:25:14 -0400
Received: from zproxy.gmail.com ([64.233.162.197]:23169 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964991AbVJ0IZN convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Oct 2005 04:25:13 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=GXe6lld7wmOVerQ7VkbFscSTBa+JY/zj2byXijKJUXzSiNbntyeOefMyYcex+OyzjxHPoTvYs0/PAKM14FoXNn57Kfk0ZWU3Gz/n2OPdtj68uoLlMv6fwQPsDRAQhpHbfmrSMnts4NPNiDxXr2ENh2gtb57644gG4+v6KZkhDOs=
Message-ID: <aec7e5c30510270125q1e175daeoeaea99584f305261@mail.gmail.com>
Date: Thu, 27 Oct 2005 17:25:12 +0900
From: Magnus Damm <magnus.damm@gmail.com>
To: Andi Kleen <ak@suse.de>
Subject: Re: [discuss] [rfc] x86_64: Kconfig changes for NUMA
Cc: discuss@x86-64.org, Ravikiran G Thirumalai <kiran@scalex86.org>,
       linux-kernel@vger.kernel.org,
       "Shai Fultheim (Shai@scalex86.org)" <shai@scalex86.org>
In-Reply-To: <200510270950.13268.ak@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051026070956.GA3561@localhost.localdomain>
	 <aec7e5c30510261840xf0d5bfapaf2f62959cb9a462@mail.gmail.com>
	 <aec7e5c30510262325r7bf17bf3ved230fe79156e6ad@mail.gmail.com>
	 <200510270950.13268.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/27/05, Andi Kleen <ak@suse.de> wrote:
> On Thursday 27 October 2005 08:25, Magnus Damm wrote:
>
> > > While at it, could you please consider to remove the SMP dependency
> > > from NUMA_EMU? 2.6.14-rc5-git5 builds and works with !SMP and
>
> No.

That was quick.

> > > NUMA_EMU.
> > >
> > > Why?
> > > 1. No need to force SMP when not needed.
> > > 2. qemu-system-x86_64 does not currently work with SMP kernels.
>
> qemu needs to be fixed then.

Yep. Any day soon now (tm).

> > Update:
> >
> > Both CONFIG_NUMA_EMU and CONFIG_K8_NUMA build and run just fine
> > without CONFIG_SMP. Not sure about CONFIG_ACPI_NUMA though.
>
> I don't want too many weird combinations which no normal person uses like
> this. Undoubtedly there will be compile breakage for such stuff in the future
> (even if it happens to work by chance now) and best is to not open this can
> of worms in the first place. The number of variants has to be kept under
> control.

Yes, I understand that keeping the combinations low is a good thing.

But if the same logic is applied to the NUMA code, why then is there
both k8topology.c and srat.c? Does non-ACPI systems exist in x86_64
land?

Thanks,

/ magnus
