Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932214AbWGGSQT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932214AbWGGSQT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 14:16:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932239AbWGGSQT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 14:16:19 -0400
Received: from nf-out-0910.google.com ([64.233.182.191]:45015 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932214AbWGGSQS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 14:16:18 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ut5VsNaIrm1/AcQp6J/LTf/+w03i3jcQGAVbTOuaLjnrwDeYJ2EkA1FV9ygXZhBVat3j2r5vYKVIZxzEu4nyl/tAdqHN/d8lTFyF8tGpF9HPaFJE9FFgqUIhsmwyoteluoXr6N9MyFfGKZIZ+HUalJlS+UssSW+dZidKBTJAKHc=
Message-ID: <a762e240607071116t5b0734b5k79b6ce1877410c9d@mail.gmail.com>
Date: Fri, 7 Jul 2006 11:16:17 -0700
From: "Keith Mannthey" <kmannth@gmail.com>
To: "Chuck Ebbert" <76306.1226@compuserve.com>
Subject: Re: [patch] i386: require ACPI for NUMA with generic architecture
Cc: "Randy Dunlap" <rdunlap@xenotime.net>, "Andrew Morton" <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <200607070623_MC3-1-C45A-2428@compuserve.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <200607070623_MC3-1-C45A-2428@compuserve.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/7/06, Chuck Ebbert <76306.1226@compuserve.com> wrote:
> In-Reply-To: <a762e240607061143s6470ad5y310986cba4f0b0bc@mail.gmail.com>
>
> On Thu, 6 Jul 2006 11:43:37 -0700, Keith Mannthey wrote:
>
> > On 7/6/06, Chuck Ebbert <76306.1226@compuserve.com> wrote:
> > > X86 Generic Architecture (X86_GENERICARCH) includes support for
> > > Summit architecture.  Enabling X86_GENERICARCH, SMP and HIGHMEM64G
> > > allows NUMA to be selected but that configuration will not build
> > > because it requires ACPI for the Summit NUMA support.
> >
> > Good catch.    With X86_GENRICARCARCH perhaps NUMA should always be on
> > or am I missing something with how it is supposed to work?  Shouldn't
> > X86_GENRICARCARCH buy you the ablility to boot(correctly) on all the
> > diffrent archs listed?
>
> AFAIK not all Summit machines are NUMA, so maybe the flexibility is
> needed.  e.g. some might want GENERICARCH without HIGHMEM64G.
  I see you point. Flexability is good.

  A non numa Summit box is just regular SMP.  The Summit hw platform
is a multi node hardware layout and single nodes are valid and common.
 All Summit HW (numa and non) can boot regular smp kernels (numa boxes
pay the performance hit).  The Summit sub-arch is needed to setup i386
NUMA for the box in multi-node situations not to perform basic bootup.
  Booting Summit without NUMA is sort of missing the point...

Thanks
  Keith
