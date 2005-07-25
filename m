Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261171AbVGYHnz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261171AbVGYHnz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Jul 2005 03:43:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261190AbVGYHnz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Jul 2005 03:43:55 -0400
Received: from holly.csn.ul.ie ([136.201.105.4]:32670 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S261171AbVGYHny (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Jul 2005 03:43:54 -0400
Date: Mon, 25 Jul 2005 08:43:48 +0100 (IST)
From: Dave Airlie <airlied@linux.ie>
X-X-Sender: airlied@skynet
To: Stefan Seyfried <seife@suse.de>
Cc: Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org,
       Matthew Garrett <mgarrett@chiark.greenend.org.uk>
Subject: Re: [PATCH] reset VGA adapters via BIOS on resume... (non-fbdev/con)
In-Reply-To: <42E4890C.2010801@suse.de>
Message-ID: <Pine.LNX.4.58.0507250834090.11451@skynet>
References: <Pine.LNX.4.58.0507221942540.5475@skynet> <E1Dw6lc-0007IU-00@chiark.greenend.org.uk>
 <E1Dw6lc-0007IU-00@chiark.greenend.org.uk> <20050723003140.GB1988@elf.ucw.cz>
 <E1Dw80M-0001EG-00@chiark.greenend.org.uk> <20050723004745.GA7868@atrey.karlin.mff.cuni.cz>
 <42E4890C.2010801@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > Anyway, this patch is really good, and enables S3 to work on more
> > machines. Thats good. It is not intrusive and I'll probably (try to)
> > push it.
>
> which acpi_sleep=... parameter enables it? I have machines resuming
> perfectly fine without it that i don't want to break ;-)

I'll clean it up to add that stuff soon, but I've hit a problem with it on
my main desktop, it won't come out of suspend using my patch, however
vbepost in userspace works... this is very strange, as they do the same
thing  which is execute the VBIOS at c000:3, one does it in the kernel in
REAL mode and the other does it in vm86 mode from userspace.. I think it
may be calling into the real BIOS and hanging up in there.. maybe
something to do with segment register setup or stacks.. (I've tried
on-board i865, radeon and MGA cards)...

Dave

-- 
David Airlie, Software Engineer
http://www.skynet.ie/~airlied / airlied at skynet.ie
Linux kernel - DRI, VAX / pam_smb / ILUG

