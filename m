Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261392AbTDKRPa (for <rfc822;willy@w.ods.org>); Fri, 11 Apr 2003 13:15:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261393AbTDKRPa (for <rfc822;linux-kernel-outgoing>);
	Fri, 11 Apr 2003 13:15:30 -0400
Received: from nessie.weebeastie.net ([61.8.7.205]:6553 "EHLO
	nessie.lochness.weebeastie.net") by vger.kernel.org with ESMTP
	id S261392AbTDKRP3 (for <rfc822;linux-kernel@vger.kernel.org>); Fri, 11 Apr 2003 13:15:29 -0400
Date: Sat, 12 Apr 2003 03:26:50 +1000
From: CaT <cat@zip.com.au>
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org, sct@redhat.com, akpm@zip.com.au,
       adilger@clusterfs.com
Subject: Re: 2.5.66: slow to friggin slow journal recover
Message-ID: <20030411172650.GA458@zip.com.au>
References: <20030401100237.GA459@zip.com.au> <20030401022844.2dee1fe8.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030401022844.2dee1fe8.akpm@digeo.com>
User-Agent: Mutt/1.3.28i
Organisation: Furball Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 01, 2003 at 02:28:44AM -0800, Andrew Morton wrote:
> CaT <cat@zip.com.au> wrote:
> > The journal recovery rangers from slow to really friggin slow under
> > 2.5.66 with definate pauses in disk io stretching for 10s of seconds.
> > This does not happen with 2.5.63 and if I hit ^c on fsck and let the
> > kernel handle the journal recover for all partitions  on mountime
> > the recovery under 2.5.66 is either so fast that you don't notice
> > it or just a buttload faster. Very objective measurements of time but
> > the slowness of a journal recover as done by fsck is so noticible it's
> > not funny.
> 
> e2fsck 1.32 seems to work fine here.
> 
> Try arranging for a partition to _not_ be mounted at boot (disable it in
> /etc/fstab).  Then do a `reboot -f' and when you get a login prompt, run
> e2fsck against that partition.
> 
> If the journal recovery is still slow then try capturing the state when it is
> stuck with sysrq-T.

Any other thing I can do? Every time I try alt-sysrq-t the fscking fsck
terminates and I don't get a list of tasks whilst it is running but only
straight after (which I'm assuming is less then useful). Most annoying.

-- 
Martin's distress was in contrast to the bitter satisfaction of some
of his fellow marines as they surveyed the scene. "The Iraqis are sick
people and we are the chemotherapy," said Corporal Ryan Dupre. "I am
starting to hate this country. Wait till I get hold of a friggin' Iraqi.
No, I won't get hold of one. I'll just kill him."
	- http://www.informationclearinghouse.info/article2479.htm
