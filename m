Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262907AbVAFQlA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262907AbVAFQlA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 11:41:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262908AbVAFQkB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 11:40:01 -0500
Received: from [213.146.154.40] ([213.146.154.40]:20905 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262907AbVAFQjw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 11:39:52 -0500
Date: Thu, 6 Jan 2005 16:39:46 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Petr Vandrovec <vandrove@vc.cvut.cz>
Cc: "Michael S. Tsirkin" <mst@mellanox.co.il>, Andrew Morton <akpm@osdl.org>,
       Takashi Iwai <tiwai@suse.de>, ak@suse.de, mingo@elte.hu,
       rlrevell@joe-job.com, linux-kernel@vger.kernel.org, pavel@suse.cz,
       discuss@x86-64.org, gordon.jin@intel.com,
       alsa-devel@lists.sourceforge.net, greg@kroah.com
Subject: Re: [PATCH] macros to detect existance of unlocked_ioctl and ioctl_compat
Message-ID: <20050106163946.GA20629@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Petr Vandrovec <vandrove@vc.cvut.cz>,
	"Michael S. Tsirkin" <mst@mellanox.co.il>,
	Andrew Morton <akpm@osdl.org>, Takashi Iwai <tiwai@suse.de>,
	ak@suse.de, mingo@elte.hu, rlrevell@joe-job.com,
	linux-kernel@vger.kernel.org, pavel@suse.cz, discuss@x86-64.org,
	gordon.jin@intel.com, alsa-devel@lists.sourceforge.net,
	greg@kroah.com
References: <20041215065650.GM27225@wotan.suse.de> <20041217014345.GA11926@mellanox.co.il> <20050103011113.6f6c8f44.akpm@osdl.org> <20050105144043.GB19434@mellanox.co.il> <s5hd5wjybt8.wl@alsa2.suse.de> <20050105133448.59345b04.akpm@osdl.org> <20050106140636.GE25629@mellanox.co.il> <20050106145356.GA18725@infradead.org> <20050106163559.GG5772@vana.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050106163559.GG5772@vana.vc.cvut.cz>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 06, 2005 at 05:35:59PM +0100, Petr Vandrovec wrote:
> When Greg made sysfs GPL only, I've asked whether it is possible to merge
> vmmon/vmnet in (and changing its license, of course).  Answer on LKML was 
> quite clear: no, you are not interested in having vmmon/vmnet in Linux 
> kernel as you do not believe that they are usable for anything else than VMware.  

While I think there could be users, these users would probably come only
after the code was GPLed, so this is kinda chicken & egg.

> So please tell me what I can do to satisfy you?  You do not want our modules
> in kernel tree, and you do not want to allow us to detect kernel interface
> easily.  Of course we can use autoconf-like scripts we are using for
> example to detect pml4/pgd vs. pgd/pud vs. pgd/pmd/pte vs. pmd/pte only,
> but each time you can detect feature by looking at flags and not by trying
> to build one source after another detection is simpler and more reliable.

I don't care at all for non-opensource users, or small opensource glue for
a big propritary user.

> BTW, vmmon will still require register_ioctl32_conversion as we are using
> (abusing) it to be able to issue 64bit ioctls from 32bit application.  I
> assume that there is no supported way how to issue 64bit ioctls from 32bit
> aplication anymore after you disallow system-wide translations to be registered
> by modules.

Well, bad luck.  You'll have to stop using undocumented hacks.

