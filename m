Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282747AbRLGFT7>; Fri, 7 Dec 2001 00:19:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282736AbRLGFTt>; Fri, 7 Dec 2001 00:19:49 -0500
Received: from milsum.Biomed.McGill.CA ([132.206.111.48]:519 "EHLO
	milsum.biomed.mcgill.ca") by vger.kernel.org with ESMTP
	id <S282747AbRLGFTi>; Fri, 7 Dec 2001 00:19:38 -0500
Content-Type: text/plain; charset=US-ASCII
From: Christian Lavoie <clavoie@bmed.mcgill.ca>
To: Dave Jones <davej@suse.de>
Subject: Re: 2.4.17-pre5 will not boot
Date: Fri, 7 Dec 2001 00:19:37 -0500
X-Mailer: KMail [version 1.3.2]
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0112070040380.4486-100000@Appserv.suse.de>
In-Reply-To: <Pine.LNX.4.33.0112070040380.4486-100000@Appserv.suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20011207051939Z282747-752+9102@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 06 December 2001 18:46, Dave Jones wrote:

> Can you rebuild from a clean tarball, patch straight up to pre5
> and try and reproduce this ? I'm betting it won't happen and you had
> some cruft from an old build making things go awry.

Close, but no cookie.

Indeed, the problem is not the new arch/i386/kernel code.

The kernel was more or less1024kb large (can't remember the exact number), 
and my loadlin can't seem to handle that.

Might be nice to change the current error message from "Kernel isn't usable 
on boot floppies" [or words to that effect] to "Kernel isn't usable with 
loadlin, as usually seen on boot floppies"...

As to why backing a patch that doesn't get compiled in would change kernel 
size... I'm not sure I want to know.

[The fix was to modularize a couple more things]

-- 
Christian Lavoie
clavoie@bmed.mcgill.ca
