Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262626AbULPHxc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262626AbULPHxc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 02:53:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262631AbULPHxc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 02:53:32 -0500
Received: from mx1.elte.hu ([157.181.1.137]:9125 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262626AbULPHx3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 02:53:29 -0500
Date: Thu, 16 Dec 2004 08:53:01 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andi Kleen <ak@suse.de>
Cc: Lee Revell <rlrevell@joe-job.com>, Takashi Iwai <tiwai@suse.de>,
       "Michael S. Tsirkin" <mst@mellanox.co.il>, linux-kernel@vger.kernel.org,
       pavel@suse.cz, discuss@x86-64.org, gordon.jin@intel.com,
       alsa-devel <alsa-devel@lists.sourceforge.net>,
       Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>
Subject: Re: [discuss] Re: unregister_ioctl32_conversion and modules. ioctl32 revisited.
Message-ID: <20041216075301.GC11047@elte.hu>
References: <20041215065650.GM27225@wotan.suse.de> <20041215074635.GC11501@mellanox.co.il> <s5hbrcvqv7r.wl@alsa2.suse.de> <1103135460.18982.68.camel@krustophenia.net> <20041216050356.GH32718@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041216050356.GH32718@wotan.suse.de>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andi Kleen <ak@suse.de> wrote:

> > How does this all relate to Ingo's ->unlocked_ioctl stuff which is "an
> > official way to do BKL-less ioctls"?
> 
> This is another "official" way which is more powerful. I suppose it
> will replace Ingo's patch.

the ALSA changes are mine but i'm otherwise building ontop of the 
following patch in -rc3-mm1:

 http://kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.10-rc3/2.6.10-rc3-mm1/broken-out/unlocked_ioctl.patch

whichever approach gets adopted upstream, the various actors ought to
synchronize a bit more - this is the third approach so far in a very
short interval to get rid of the BKL in ioctls :-)

	Ingo
