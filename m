Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261533AbVALXHN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261533AbVALXHN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 18:07:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261560AbVALXHI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 18:07:08 -0500
Received: from fw.osdl.org ([65.172.181.6]:62623 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261533AbVALXGQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 18:06:16 -0500
Date: Wed, 12 Jan 2005 15:10:49 -0800
From: Andrew Morton <akpm@osdl.org>
To: Greg KH <greg@kroah.com>
Cc: ak@suse.de, mst@mellanox.co.il, tiwai@suse.de, mingo@elte.hu,
       rlrevell@joe-job.com, linux-kernel@vger.kernel.org, pavel@suse.cz,
       discuss@x86-64.org, gordon.jin@intel.com,
       alsa-devel@lists.sourceforge.net, VANDROVE@vc.cvut.cz
Subject: Re: [PATCH] fix: macros to detect existance of unlocked_ioctl and
 compat_ioctl
Message-Id: <20050112151049.7473db7d.akpm@osdl.org>
In-Reply-To: <20050112225230.GA14590@kroah.com>
References: <20041215065650.GM27225@wotan.suse.de>
	<20041217014345.GA11926@mellanox.co.il>
	<20050103011113.6f6c8f44.akpm@osdl.org>
	<20050105144043.GB19434@mellanox.co.il>
	<s5hd5wjybt8.wl@alsa2.suse.de>
	<20050105133448.59345b04.akpm@osdl.org>
	<20050106140636.GE25629@mellanox.co.il>
	<20050112203606.GA23307@mellanox.co.il>
	<20050112212954.GA13558@kroah.com>
	<20050112214326.GB14703@wotan.suse.de>
	<20050112225230.GA14590@kroah.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH <greg@kroah.com> wrote:
>
> On Wed, Jan 12, 2005 at 10:43:26PM +0100, Andi Kleen wrote:
> > > No, we do not do that in the kernel today, and I'm pretty sure we don't
> > 
> > Actually we do. e.g. take a look at skbuff.h HAVE_*
> > There are other examples too.
> > 
> > > want to start doing it (it would get _huge_ very quickly...)
> > 
> > I disagree since the alternative is so ugly.
> 
> But the main problem with this is, when do we start deleting the HAVE_
> symbols?

This is a self-correcting system.  If the symbols are so offensive, someone
will get offended and will submit a patch to delete them at the appropriate
time.  If they're not so offensive then we've nothing to care about.

> ...
> And as for that "policy", it's been stated in public by Andrew and
> Linus and me (if I count for anything, doubtful...) a number of
> documented times.

not me ;) It's two lines of code and makes things much simpler for the
users of our work.  Seems a no-brainer.

And practically speaking, we don't make such fundamental driver-visible
changes _that_ often - if we end up getting buried under a proliferation of
HAVE_FOO macros, then the presence of the macros is the least of our
problems, yes?
