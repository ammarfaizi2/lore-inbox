Return-Path: <linux-kernel-owner+w=401wt.eu-S932295AbXAGA5u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932295AbXAGA5u (ORCPT <rfc822;w@1wt.eu>);
	Sat, 6 Jan 2007 19:57:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932296AbXAGA5u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Jan 2007 19:57:50 -0500
Received: from smtp.bulldogdsl.com ([212.158.248.7]:3060 "EHLO
	mcr-smtp-001.bulldogdsl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932295AbXAGA5u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Jan 2007 19:57:50 -0500
X-Spam-Abuse: Please report all spam/abuse matters to abuse@bulldogdsl.com
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: kernel + gcc 4.1 = several problems
Date: Sun, 7 Jan 2007 00:57:54 +0000
User-Agent: KMail/1.9.5
Cc: Linus Torvalds <torvalds@osdl.org>, Mikael Pettersson <mikpe@it.uu.se>,
       76306.1226@compuserve.com, akpm@osdl.org, bunk@stusta.de,
       greg@kroah.com, linux-kernel@vger.kernel.org,
       yanmin_zhang@linux.intel.com
References: <200701030212.l032CDXe015365@harpo.it.uu.se> <Pine.LNX.4.64.0701050827290.3661@woody.osdl.org> <20070107003644.GA4240@ucw.cz>
In-Reply-To: <20070107003644.GA4240@ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200701070057.54684.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 07 January 2007 00:36, Pavel Machek wrote:
[snip]
> > However, this patch is mostly useless if you have a separate stack for
> > IRQ's (since if that happens, any interrupt will be taken on a different
> > stack which we don't see any more), so you should NOT enable the 4KSTACKS
> > config option if you try this out.
>
> stupid idea... perhaps gcc-4.1 generates bigger stackframe somewhere,
> and stack overflows?

The primary reason it's not 4KSTACKS already is that I run multiple XFS 
partitions on top of an md RAID 1. LVM isn't involved, however, and I'm not 
using any other filesystem overlays like dm.

I'm fairly sceptical that it's a stack overflow, but I'll be sure to enable 
the debugging option on the next try.

> that hw monitoring thingie... I'd turn it off. Its interactions with
> acpi are non-trivial and dangerous.

Well, GCC 3.4 kernels seem to run fine with it, but as I said to Linus I'll be 
sure to turn this and the sound drivers off in the next build.

-- 
Cheers,
Alistair.

Final year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
