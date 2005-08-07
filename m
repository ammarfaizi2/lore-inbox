Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752777AbVHGVYe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752777AbVHGVYe (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Aug 2005 17:24:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752778AbVHGVYe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Aug 2005 17:24:34 -0400
Received: from hockin.org ([66.35.79.110]:30168 "EHLO www.hockin.org")
	by vger.kernel.org with ESMTP id S1752777AbVHGVYd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Aug 2005 17:24:33 -0400
Date: Sun, 7 Aug 2005 14:24:25 -0700
From: Tim Hockin <thockin@hockin.org>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Andi Kleen <ak@suse.de>, Erick Turnquist <jhujhiti@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Lost Ticks on x86_64
Message-ID: <20050807212425.GA7926@hockin.org>
References: <5348b8ba050806204453392f7f@mail.gmail.com.suse.lists.linux.kernel> <p73mznuc732.fsf@bragg.suse.de> <1123440679.12766.5.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1123440679.12766.5.camel@mindpipe>
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 07, 2005 at 02:51:19PM -0400, Lee Revell wrote:
> > It's most likely bad SMM code in the BIOS that blocks the CPU too long
> > and is triggered in idle. You can verify that by using idle=poll
> > (not recommended for production, just for testing) and see if it goes away.
> > 
> 
> WTF, since when do *desktops* use SMM?  Are you telling me that we have
> to worry about these stupid ACPI/SMM hardware bugs on the desktop too?

SMM is how BIOSes do legacy support (which stops at OS-handover).  It's
also how some BIOSes do ECC reporting and logging.

We just do pci tweaks to turn it off in the OS.
