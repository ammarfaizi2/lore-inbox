Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263646AbUASWvO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jan 2004 17:51:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264434AbUASWvN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jan 2004 17:51:13 -0500
Received: from gprs214-67.eurotel.cz ([160.218.214.67]:12417 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S263646AbUASWt6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jan 2004 17:49:58 -0500
Date: Mon, 19 Jan 2004 21:45:51 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: ncunningham@users.sourceforge.net, Hugang <hugang@soulinfo.com>,
       ncunningham@clear.net.nz,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       debian-powerpc@lists.debian.org
Subject: Re: Help port swsusp to ppc.
Message-ID: <20040119204551.GB380@elf.ucw.cz>
References: <20040119105237.62a43f65@localhost> <1074483354.10595.5.camel@gaston> <1074489645.2111.8.camel@laptop-linux> <1074490463.10595.16.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1074490463.10595.16.camel@gaston>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > That idea is to have a section that doesn't get replaced when we copy
> > the original kernel back. Thus, small amounts of data that suspend uses
> > or stores can be given the __nosave attribute. An example is the cpu
> > frequency value, which should match the boot kernel, not the value at
> > suspend time.
> 
> That's very hairy... You basically assume the boot kernel and the
> restore kernel are completely identical, which isn't something I would
> do. I didn't have time to dive into it, but I do/did intend to implement
> swsusp on ppc and I would eventually resume the whole environement
> straight from the bootloader without kernel help.

Well, then what you do is not swsusp.

swsusp does assume same kernel during suspend and resume. Doing resume
within bootloader (and thus avoiding this) would be completely
different design.

> Also, I haven't looked in details, but when switching to the "new" kernel
> from the "loader" (boot) one, do you shut down all devices properly ?
> This switch could actually be fairly similar to a kexec pass in this
> regard.

I hope we do shut devices down. In my tree at least.
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
