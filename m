Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262439AbULOSbI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262439AbULOSbI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Dec 2004 13:31:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262438AbULOSbI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Dec 2004 13:31:08 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:38558 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S262439AbULOSbB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Dec 2004 13:31:01 -0500
Subject: Re: unregister_ioctl32_conversion and modules. ioctl32 revisited.
From: Lee Revell <rlrevell@joe-job.com>
To: Takashi Iwai <tiwai@suse.de>
Cc: "Michael S. Tsirkin" <mst@mellanox.co.il>, Andi Kleen <ak@suse.de>,
       linux-kernel@vger.kernel.org, pavel@suse.cz, discuss@x86-64.org,
       gordon.jin@intel.com, alsa-devel <alsa-devel@lists.sourceforge.net>,
       Ingo Molnar <mingo@elte.hu>
In-Reply-To: <s5hbrcvqv7r.wl@alsa2.suse.de>
References: <20041215065650.GM27225@wotan.suse.de>
	 <20041215074635.GC11501@mellanox.co.il>  <s5hbrcvqv7r.wl@alsa2.suse.de>
Content-Type: text/plain
Date: Wed, 15 Dec 2004 13:30:59 -0500
Message-Id: <1103135460.18982.68.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-12-15 at 19:20 +0100, Takashi Iwai wrote:
> At Wed, 15 Dec 2004 09:46:35 +0200,
> Michael S. Tsirkin wrote:
> > 
> > There were two additional motivations for my patch:
> > 1. Make it possible to avoid the BKL completely by writing
> >    an ioctl with proper internal locking.
> > 2. As noted by  Juergen Kreileder, the compat hash does not work
> >    for ioctls that encode additional information in the command, like this:
> > 
> > #define EVIOCGBIT(ev,len)  _IOC(_IOC_READ, 'E', 0x20 + ev, len)
> 
> I like the idea very well.  Other benifits in addition:
> 

How does this all relate to Ingo's ->unlocked_ioctl stuff which is "an
official way to do BKL-less ioctls"?

http://lkml.org/lkml/2004/12/14/53

Lee

