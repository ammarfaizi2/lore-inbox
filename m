Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1751393AbWFEUJ6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751393AbWFEUJ6 (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 16:09:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751398AbWFEUJ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 16:09:57 -0400
Received: from mx1.redhat.com ([66.187.233.31]:29115 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751393AbWFEUJ5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 16:09:57 -0400
Date: Mon, 5 Jun 2006 16:09:47 -0400
From: Dave Jones <davej@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Jaroslav Kysela <perex@suse.cz>,
        Takashi Iwai <tiwai@suse.de>
Subject: Re: 2.6.17-rc5-mm3
Message-ID: <20060605200947.GC6143@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	Jaroslav Kysela <perex@suse.cz>, Takashi Iwai <tiwai@suse.de>
References: <20060603232004.68c4e1e3.akpm@osdl.org> <20060605194844.GA6143@redhat.com> <20060605130626.3f2917a2.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060605130626.3f2917a2.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 05, 2006 at 01:06:26PM -0700, Andrew Morton wrote:

 > > Then, the whole thing locked up after probing the parallel port.
 > > I disabled it in the BIOS, and then it locked up probing the floppy drive..
 > > http://www.codemonkey.org.uk/junk/DSC00348.JPG
 > 
 > That looks like the same thing?
 > 
 > > System is still alive, and responds to keyboard, but makes no forward progress.
 > > 
 > > (sysrq-B spewed a lockdep trace and then rebooted. I'll try and get
 > > that hooked up to a serial console)
 > > 
 > > On a whim, I enabled the floppy drive in the BIOS, and rebooted.
 > > That got me here. http://www.codemonkey.org.uk/junk/DSC00349.JPG
 > > Same dead userspace.
 > 
 > So does that.

The top half the screen is the same as the first pic yes, but the purpose
of those latter two pics was to show that we're locking up (in aparently
different places) shortly afterwards.

 > Try reverting debug-shared-irqs.patch, or disable the sound driver?

Will turn off the sound driver, and see what happens.

		Dave

-- 
http://www.codemonkey.org.uk
