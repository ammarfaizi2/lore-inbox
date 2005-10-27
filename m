Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932564AbVJ0GZm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932564AbVJ0GZm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Oct 2005 02:25:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932567AbVJ0GZl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Oct 2005 02:25:41 -0400
Received: from zproxy.gmail.com ([64.233.162.201]:53881 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932564AbVJ0GZl convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Oct 2005 02:25:41 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=TYdlBlfv/SB8v1W9JdaCabYjrayhHThOJfgSE2hmV6M6mJqBgasZCXZ25XUdooqT0Sz9gIDbMf77u9zyitvtBd+LRtEt/SLd6JVuuK5tlPt5CYmLxn7T+VXIv0HoxclGtoWwlhtuf1ItHuazpXGQs8MTL5aYJY6YWRzcqBc5hFs=
Message-ID: <aec7e5c30510262325r7bf17bf3ved230fe79156e6ad@mail.gmail.com>
Date: Thu, 27 Oct 2005 15:25:40 +0900
From: Magnus Damm <magnus.damm@gmail.com>
To: Andi Kleen <ak@suse.de>
Subject: Re: [discuss] [rfc] x86_64: Kconfig changes for NUMA
Cc: discuss@x86-64.org, Ravikiran G Thirumalai <kiran@scalex86.org>,
       linux-kernel@vger.kernel.org,
       "Shai Fultheim (Shai@scalex86.org)" <shai@scalex86.org>
In-Reply-To: <aec7e5c30510261840xf0d5bfapaf2f62959cb9a462@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051026070956.GA3561@localhost.localdomain>
	 <200510261646.26331.ak@suse.de>
	 <aec7e5c30510261840xf0d5bfapaf2f62959cb9a462@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/27/05, Magnus Damm <magnus.damm@gmail.com> wrote:
> On 10/26/05, Andi Kleen <ak@suse.de> wrote:
> > On Wednesday 26 October 2005 09:09, Ravikiran G Thirumalai wrote:
> >
> > >
> > > 1. Makes NUMA a config option like other arches
> > > 2. Makes topology detection options like K8_NUMA dependent on NUMA
> > > 3. Choosing ACPI NUMA detection can be done from the standard
> > >    "Processor type and features" menu
> > > Comments?
> >
> > It's in principle ok except that I don't like the dependencies and
> > defaults. K8_NUMA shouldn't be dependent on !M_PSC. And the defaults
> > should be just dropped.
>
> While at it, could you please consider to remove the SMP dependency
> from NUMA_EMU? 2.6.14-rc5-git5 builds and works with !SMP and
> NUMA_EMU.
>
> Why?
> 1. No need to force SMP when not needed.
> 2. qemu-system-x86_64 does not currently work with SMP kernels.

Update:

Both CONFIG_NUMA_EMU and CONFIG_K8_NUMA build and run just fine
without CONFIG_SMP. Not sure about CONFIG_ACPI_NUMA though.

/ magnus
