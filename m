Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261970AbVASXN3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261970AbVASXN3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 18:13:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261968AbVASXMk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 18:12:40 -0500
Received: from acomp.externet.hu ([212.40.96.68]:63925 "HELO www.acomp.hu")
	by vger.kernel.org with SMTP id S261966AbVASXMY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 18:12:24 -0500
Date: Thu, 20 Jan 2005 00:13:22 +0100
From: Janos Farkas <jf-ml-k1-1087813225@lk8rp.mail.xeon.eu.org>
To: linux-kernel@vger.kernel.org
Cc: Andi Kleen <ak@suse.de>, Chris Bruner <cryst@golden.net>
Subject: COMMAND_LINE_SIZE increasing in 2.6.11-rc1-bk6
Message-ID: <20050119231322.GA2287@lk8rp.mail.xeon.eu.org>
Mail-Followup-To: Janos Farkas <jf-ml-k1-1087813225@lk8rp.mail.xeon.eu.org>,
	linux-kernel@vger.kernel.org, Andi Kleen <ak@suse.de>,
	Chris Bruner <cryst@golden.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andi!

I had difficulties booting recent rc1-bkN kernels on at least two
Athlon machines (but somehow, on an *old* Pentium laptop booted with the
a very similar system just fine).

The kernel just hung very early, just after displaying "BIOS data check
successful" by lilo (22.6.1).  Ctrl-Alt-Del worked to reboot, but
nothing else was shown.

It is a similar experience to Chris Bruner's post here:
> http://article.gmane.org/gmane.linux.kernel/271352

I also recall someone having similar problem with Opterons too, but
can't find just now..

rc1-bk6 didn't boot, and thus I started checking revisions:
rc1-bk3 did boot (as well as plain rc1)
rc1-bk4 didn't boot
rc1-bk7 booted *after* reverting the patch below:

> 4 days ak 1.2329.1.38 [PATCH] x86_64/i386: increase command line size
> Enlarge i386/x86-64 kernel command line to 2k
> This is useful when the kernel command line is used to pass other
> information to initrds or installers.
> On i386 it was duplicated for unknown reasons.
> Signed-off-by: Andi Kleen
> Signed-off-by: Andrew Morton
> Signed-off-by: Linus Torvalds

While arguably it's not a completely scientific approach (no plain bk7,
and no bk6 reverted was tested), I'm inclined to say this was my
problem...

Isn't this define a lilo dependence?

-- 
Janos | romfs is at http://romfs.sourceforge.net/ | Don't talk about silence.
