Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262857AbVAFPKh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262857AbVAFPKh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 10:10:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262865AbVAFPKg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 10:10:36 -0500
Received: from news.suse.de ([195.135.220.2]:61860 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262868AbVAFPKJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 10:10:09 -0500
Date: Thu, 6 Jan 2005 16:09:42 +0100
From: Andi Kleen <ak@suse.de>
To: Christoph Hellwig <hch@infradead.org>,
       "Michael S. Tsirkin" <mst@mellanox.co.il>,
       Andrew Morton <akpm@osdl.org>, Takashi Iwai <tiwai@suse.de>, ak@suse.de,
       mingo@elte.hu, rlrevell@joe-job.com, linux-kernel@vger.kernel.org,
       pavel@suse.cz, discuss@x86-64.org, gordon.jin@intel.com,
       alsa-devel@lists.sourceforge.net, greg@kroah.com, VANDROVE@vc.cvut.cz
Subject: Re: [PATCH] macros to detect existance of unlocked_ioctl and ioctl_compat
Message-ID: <20050106150941.GE1830@wotan.suse.de>
References: <20041215065650.GM27225@wotan.suse.de> <20041217014345.GA11926@mellanox.co.il> <20050103011113.6f6c8f44.akpm@osdl.org> <20050105144043.GB19434@mellanox.co.il> <s5hd5wjybt8.wl@alsa2.suse.de> <20050105133448.59345b04.akpm@osdl.org> <20050106140636.GE25629@mellanox.co.il> <20050106145356.GA18725@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050106145356.GA18725@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 06, 2005 at 02:53:56PM +0000, Christoph Hellwig wrote:
> On Thu, Jan 06, 2005 at 04:06:36PM +0200, Michael S. Tsirkin wrote:
> > > It should be, unless there's some problem.  In maybe a week or so.
> > 
> > To make life bearable for out-of kernel modules, the following patch
> > adds 2 macros so that existance of unlocked_ioctl and ioctl_compat
> > can be easily detected.
> 
> That's not the way we're making additions.  Get your code merged and
> there won't be any need to detect the feature.

I would agree that it shouldn't be used for in tree code, but for
out of tree code it is rather useful. There are other such feature macros
for major driver interface changes too (e.g. in the network stack).

-Andi
