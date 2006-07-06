Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750754AbWGFSnk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750754AbWGFSnk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 14:43:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750749AbWGFSnj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 14:43:39 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:29295 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1750740AbWGFSni (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 14:43:38 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Z+mxrXiIuN+FrFKWJ8M/+bk0PGTngig1qxe9p8FE/n2+WrdWDfoUBHLicXBoVfCEGYgDW4/rK+ppYHl2NsdwT/RLgUhpshhiuUY2T01ZipSLwQ0UtJEZJl7KoBtcdz5qe3Mc/vOfrSH58OGCK2STYnPhdMIHbmJhrwYJWCWFyQg=
Message-ID: <a762e240607061143s6470ad5y310986cba4f0b0bc@mail.gmail.com>
Date: Thu, 6 Jul 2006 11:43:37 -0700
From: "Keith Mannthey" <kmannth@gmail.com>
To: "Chuck Ebbert" <76306.1226@compuserve.com>
Subject: Re: [patch] i386: require ACPI for NUMA with generic architecture
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       "Andrew Morton" <akpm@osdl.org>, "Randy Dunlap" <rdunlap@xenotime.net>
In-Reply-To: <200607061221_MC3-1-C44C-BE6A@compuserve.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <200607061221_MC3-1-C44C-BE6A@compuserve.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/6/06, Chuck Ebbert <76306.1226@compuserve.com> wrote:
> X86 Generic Architecture (X86_GENERICARCH) includes support for
> Summit architecture.  Enabling X86_GENERICARCH, SMP and HIGHMEM64G
> allows NUMA to be selected but that configuration will not build
> because it requires ACPI for the Summit NUMA support.
>
> Fix:
>         require ACPI for NUMA support with X86_GENERICARCH
>
>         update the menu comment noting this
>
>         set default NR_CPUS to 32 for GENERICARCH (since it
>                 includes BIGSMP and SUMMIT which default to 32)

Good catch.    With X86_GENRICARCARCH perhaps NUMA should always be on
or am I missing something with how it is supposed to work?  Shouldn't
X86_GENRICARCARCH buy you the ablility to boot(correctly) on all the
diffrent archs listed?

Thanks,
  Keith
