Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031106AbWK3Sd4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031106AbWK3Sd4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 13:33:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031108AbWK3Sd4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 13:33:56 -0500
Received: from mga05.intel.com ([192.55.52.89]:36154 "EHLO
	fmsmga101.fm.intel.com") by vger.kernel.org with ESMTP
	id S1031106AbWK3Sdz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 13:33:55 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,481,1157353200"; 
   d="scan'208"; a="171205127:sNHT26143880"
Date: Thu, 30 Nov 2006 10:08:39 -0800
From: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
To: Alan <alan@lxorguk.ukuu.org.uk>
Cc: Ben Collins <bcollins@ubuntu.com>, linux-kernel@vger.kernel.org,
       torvalds@osdl.org
Subject: Re: [PATCH 1/4] [x86] Add command line option to enable/disable hyper-threading.
Message-ID: <20061130100839.A30285@unix-os.sc.intel.com>
References: <11648607683157-git-send-email-bcollins@ubuntu.com> <11648607733630-git-send-email-bcollins@ubuntu.com> <20061130110611.03aff95c@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20061130110611.03aff95c@localhost.localdomain>; from alan@lxorguk.ukuu.org.uk on Thu, Nov 30, 2006 at 11:06:11AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 30, 2006 at 11:06:11AM +0000, Alan wrote:
> On Wed, 29 Nov 2006 23:26:05 -0500
> Ben Collins <bcollins@ubuntu.com> wrote:
> 
> > This patch adds a config option to allow disabling hyper-threading by
> > default, and a kernel command line option to changes this default at
> > boot time.
> > 
> > Signed-off-by: Ben Collins <bcollins@ubuntu.com>
> 
> The description is wrong - this does not disable hyperthreading it merely
> leaves one thread idle.

How does this patch achieve that? All this patch does is not detecting the
sibling topology. Kernel will still use all the threads and it just
forgoes the intelligence of which cpus are thread and core siblings and
thus disables the optimizations done by scheduler and doesn't export the
cpu topology to the user through sysfs and /proc.

Am I missing the point of this patch?

thanks,
suresh

> I don't believe Intel have ever published a
> procedure for truely disabling HT, but if you idle a thread you may want
> to adjust the cache settings on a PIV (10.5.6 in the intel docs) and set
> it to shared mode. Need to play more with what the bios does I guess.
> 
> So Ack but with the proviso it should say "Ignoring" or "Not using" not
> "Disabling", because it does not do the latter and there seem to be
> performance differences as a result
> 
> Acked-by: Alan Cox <alan@redhat.com>
