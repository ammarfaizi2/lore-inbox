Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262849AbVAFPOp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262849AbVAFPOp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 10:14:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262872AbVAFPOo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 10:14:44 -0500
Received: from [213.146.154.40] ([213.146.154.40]:44711 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262849AbVAFPOe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 10:14:34 -0500
Date: Thu, 6 Jan 2005 15:14:29 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Andi Kleen <ak@suse.de>
Cc: "Michael S. Tsirkin" <mst@mellanox.co.il>, Andrew Morton <akpm@osdl.org>,
       Takashi Iwai <tiwai@suse.de>, mingo@elte.hu, rlrevell@joe-job.com,
       linux-kernel@vger.kernel.org, pavel@suse.cz, discuss@x86-64.org,
       gordon.jin@intel.com, greg@kroah.com, VANDROVE@vc.cvut.cz
Subject: Re: [PATCH] macros to detect existance of unlocked_ioctl and ioctl_compat
Message-ID: <20050106151429.GA19155@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andi Kleen <ak@suse.de>, "Michael S. Tsirkin" <mst@mellanox.co.il>,
	Andrew Morton <akpm@osdl.org>, Takashi Iwai <tiwai@suse.de>,
	mingo@elte.hu, rlrevell@joe-job.com, linux-kernel@vger.kernel.org,
	pavel@suse.cz, discuss@x86-64.org, gordon.jin@intel.com,
	greg@kroah.com, VANDROVE@vc.cvut.cz
References: <20041215065650.GM27225@wotan.suse.de> <20041217014345.GA11926@mellanox.co.il> <20050103011113.6f6c8f44.akpm@osdl.org> <20050105144043.GB19434@mellanox.co.il> <s5hd5wjybt8.wl@alsa2.suse.de> <20050105133448.59345b04.akpm@osdl.org> <20050106140636.GE25629@mellanox.co.il> <20050106145356.GA18725@infradead.org> <20050106150941.GE1830@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050106150941.GE1830@wotan.suse.de>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 06, 2005 at 04:09:42PM +0100, Andi Kleen wrote:
> I would agree that it shouldn't be used for in tree code, but for
> out of tree code it is rather useful. There are other such feature macros
> for major driver interface changes too (e.g. in the network stack).

Which is the only place doing it.  We had this discussion in the past
(lastone I revolve Greg vetoed it).  We simply shouldn't clutter our
headers for the sake of out of tree drivers - with LINUX_VERSION_CODE
we've already implemented a mechanism for out of tree drivers.

p.s. droppe alsa-devel from Cc because of the braindead moderation policy.
