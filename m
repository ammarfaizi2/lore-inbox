Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262206AbVBQEWf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262206AbVBQEWf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Feb 2005 23:22:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262207AbVBQEWd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Feb 2005 23:22:33 -0500
Received: from hornet.berlios.de ([195.37.77.140]:47079 "EHLO
	hornet.berlios.de") by vger.kernel.org with ESMTP id S262206AbVBQEWb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Feb 2005 23:22:31 -0500
Date: Thu, 17 Feb 2005 05:22:16 +0100
From: mhf@berlios.de
To: linux-kernel@vger.kernel.org, softwaresuspend-devel@lists.berlios.de
Cc: ncunningham@cyclades.com, sziwan@hell.org.pl
Subject: i810 resume fix. was: [SoftwareSuspend-devel] [Announce] 2.1.7 
 for 2.6.11-rc4
Message-ID: <42141BF8.nail59A1FL85I@berlios.de>
User-Agent: nail 10.5 4/27/03
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 15 February 2005 15:26, Karol Kozimor wrote:
> Thus wrote mhf@berlios.de:
> > Checked on modules:
> > - Removing i810 and drm prior to suspend (after exiting
> > X) has no effect.
> >
> > - Removing intel-agp as well fixes the problem and X
> > can be started alright after resume.
> >
> > - When agpgart remains no issues seen.
>
> Plain i810 has no resume support currently. Could you
> apply this and see if it works?
>
>
> --- drivers/char/agp/intel-agp.c~       2005-02-15
> 15:17:44.157029954 +0100 +++ drivers/char/agp/intel-agp.c
>        2005-02-15 15:24:45.011870338 +0100 @@ -1758,6
> +1758,8 @@
>                 intel_i915_configure();
>         else if (bridge->driver == &intel_830_driver)
>                 intel_i830_configure();
> +       else if (bridge->driver == &intel_810_driver)
> +               intel_i810_configure();
>
>         return 0;
>  }

Hi Karol!

Thank you for the patch. I tested it it resumes fine with 
swsusp2 and S3. Would you please submit the patch to lkml.

Regards
Michael
