Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750813AbWJEEmB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750813AbWJEEmB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 00:42:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750811AbWJEEmA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 00:42:00 -0400
Received: from hera.kernel.org ([140.211.167.34]:63198 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S1750805AbWJEEl7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 00:41:59 -0400
From: Len Brown <len.brown@intel.com>
Reply-To: Len Brown <lenb@kernel.org>
Organization: Intel Open Source Technology Center
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] Cast removal
Date: Thu, 5 Oct 2006 00:43:41 -0400
User-Agent: KMail/1.8.2
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ACPI List <linux-acpi@vger.kernel.org>
References: <Pine.LNX.4.61.0610010026050.32229@yvahk01.tjqt.qr> <200610042356.03348.len.brown@intel.com> <20061004211259.8274db49.akpm@osdl.org>
In-Reply-To: <20061004211259.8274db49.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610050043.41997.len.brown@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 05 October 2006 00:12, Andrew Morton wrote:
> On Wed, 4 Oct 2006 23:56:02 -0400
> Len Brown <len.brown@intel.com> wrote:
> 
> > I'm okay applying this patch it touches the linux-specific
> > drivers/acpi/* files only, no ACPICA files.
> 
> Why?

Why am I okay with it?
I'm okay with it because it touches files in drivers/acpi/*.c
Those files are Linux specific, and thus no problem
doing with them what we do with any other
Linux file.

> Would it help if it was split into two?

no need to, as the patch didn't touch ACPICA files.

> How do mortals distinguish ACPICA files from Linux files?

the sub-directories under drivers/acpi are ACPICA files.
They have a dual BSD/GPL license on them.
I've though of making an acpica sub-directory
to make this really clear, but there never seems to be
a good time to do stuff like that...
 
> > But I don't know if Linus will want changes like this post -rc1.
> > It might be a pain to have in the tree all the way to 2.6.20 opens b/c
> > it is sure to cause merge conflicts
> 
> Should be OK - the acpi tree is very slow-changing at present.  Or did you
> have big changes planned?

Okay, I've applied it, dealt with the conflicts,
and I'll send an -rc1 batch this week.

> Or I can maintain it externally along with the 10-20 other acpi patches I
> seem to be regularly stuck with (hint ;)

no need to.

If maintaining individual ACPI-related patches in -mm is a burden,
then refuse to.  While I'll never be able to match your latency,
I'm okay with it either way -- as I think either way the the
right thing happens in the long run.

> > -- and at the end of the day
> > the benefit of this patch is what?  A few less characters in the source... 
> >
> 
> yes, cleanups are a pain, and we do a lot of them.  And we merge just about
> all of them.  But I think it's best in the long run; and we are in this for
> the long run.  

Okay, thanks,
-Len
