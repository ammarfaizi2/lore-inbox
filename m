Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751147AbWIGIfU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751147AbWIGIfU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Sep 2006 04:35:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751150AbWIGIfU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Sep 2006 04:35:20 -0400
Received: from wx-out-0506.google.com ([66.249.82.229]:32347 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751147AbWIGIfS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Sep 2006 04:35:18 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=cVuKFlUwWj4CVXY7C00MY5EXrS8M/LaRxB/ReaEgLvmzQByT7MS+fd4Hyp5GOGyyaNbMYYazAePnWk6ct8MmW4vRo17R8JNRRStdkFfv5H0LHvYcyBiYADvxm2yzKeL43KtkrY4JFI8M1SSRGd3bPcSvB52hZd+TTKmogYejYWg=
Message-ID: <6bffcb0e0609070135i314f2740if067eeab342f29a2@mail.gmail.com>
Date: Thu, 7 Sep 2006 10:35:17 +0200
From: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
To: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [PATCH 2.6.18-rc6 00/10] Kernel memory leak detector 0.10
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <b0943d9e0609070104v1b747f79v3b10238954f389cd@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060906223536.21550.55411.stgit@localhost.localdomain>
	 <6bffcb0e0609061710t3519e42dl6138cadd5ff0d3fb@mail.gmail.com>
	 <b0943d9e0609070104v1b747f79v3b10238954f389cd@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/09/06, Catalin Marinas <catalin.marinas@gmail.com> wrote:
> On 07/09/06, Michal Piotrowski <michal.k.k.piotrowski@gmail.com> wrote:
> > I get a kernel panic
> > http://www.stardust.webpages.pl/files/o_bugs/kmemleak-0.10/panic.jpg
> >
> > http://www.stardust.webpages.pl/files/o_bugs/kmemleak-0.10/kml-config
>
> Well, you set CONFIG_DEBUG_MEMLEAK_HASH_BITS to 32, this means that
> kmemleak needs to allocate (sizeof(void*) * 2^32) which is 16GB of
> RAM. I think a maximum of 20 should be enough (I got acceptable
> results with 16 hash bits, the default value, and it seemed to do
> better with 18).

CONFIG_DEBUG_MEMLEAK=y
CONFIG_DEBUG_MEMLEAK_HASH_BITS=8
CONFIG_DEBUG_MEMLEAK_TRACE_LENGTH=12
CONFIG_DEBUG_MEMLEAK_PREINIT_OBJECTS=512
# CONFIG_DEBUG_MEMLEAK_SECONDARY_ALIASES is not set
# CONFIG_DEBUG_MEMLEAK_TASK_STACKS is not set
# CONFIG_DEBUG_MEMLEAK_ORPHAN_FREEING is not set
CONFIG_DEBUG_MEMLEAK_REPORTS_NR=100
# CONFIG_DEBUG_KEEP_INIT is not set
# CONFIG_DEBUG_MEMLEAK_TEST is not set

I still get a panic

>
> --
> Catalin
>

Regards,
Michal

-- 
Michal K. K. Piotrowski
LTG - Linux Testers Group
(http://www.stardust.webpages.pl/ltg/)
