Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751066AbVHXPaP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751066AbVHXPaP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 11:30:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751071AbVHXPaP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 11:30:15 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:12037 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751066AbVHXPaO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 11:30:14 -0400
Date: Wed, 24 Aug 2005 17:30:13 +0200
From: Adrian Bunk <bunk@stusta.de>
To: "Brown, Len" <len.brown@intel.com>
Cc: "Li, Shaohua" <shaohua.li@intel.com>, acpi-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-rc: ACPI_INTERPRETER=y, PCI=n compile error
Message-ID: <20050824153012.GC4851@stusta.de>
References: <F7DC2337C7631D4386A2DF6E8FB22B30046956FE@hdsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <F7DC2337C7631D4386A2DF6E8FB22B30046956FE@hdsmsx401.amr.corp.intel.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 24, 2005 at 11:13:05AM -0400, Brown, Len wrote:
> 
> >Subject: 2.6.13-rc: ACPI_INTERPRETER=y, PCI=n compile error
> >
> >I got the following compile error in 2.6.13-rc6-mm2, but it 
> >seems to be 
> >a problem coming from Linus' tree introduced by the
> >  [ACPI] S3 resume: avoid kmalloc() might_sleep oops symptom
> >patch:
> >
> ><--  snip  -->
> >
> >...
> >  LD      .tmp_vmlinux1
> >drivers/built-in.o: In function `acpi_os_allocate':
> >: undefined reference to `acpi_in_resume'
> >make: *** [.tmp_vmlinux1] Error 1
> >
> ><--  snip  -->
> 
> Do you have an ACPI-enabled machine that has no PCI?
> I'm not aware of any, and would be interested to know
> if one exists.

No, I don't have one.

> We've had problems with this theoretical build config
> for some time:
> http://bugzilla.kernel.org/show_bug.cgi?id=1364
> because nobody, including me, tests it.
> 
> Indeed, one possible fix would be to make CONFIG_ACPI
> depend on CONFIG_PCI -- which brings me back to
> my origianl question.

Making ACPI dependent on PCI is a possible solution for this problem.

> -Len

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

