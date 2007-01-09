Return-Path: <linux-kernel-owner+w=401wt.eu-S932126AbXAIPPn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932126AbXAIPPn (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 10:15:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932146AbXAIPPn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 10:15:43 -0500
Received: from mx1.redhat.com ([66.187.233.31]:41957 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932126AbXAIPPn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 10:15:43 -0500
Date: Tue, 9 Jan 2007 15:15:39 +0000
From: Alasdair G Kergon <agk@redhat.com>
To: Dave Jones <davej@redhat.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: lvm backwards compatability
Message-ID: <20070109151539.GW21980@agk.surrey.redhat.com>
Mail-Followup-To: Alasdair G Kergon <agk@redhat.com>,
	Dave Jones <davej@redhat.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <20070108230111.GC14548@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070108230111.GC14548@redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 08, 2007 at 06:01:11PM -0500, Dave Jones wrote:
> Did backwards compatability with old LVM metadata break intentionally
> in 2.6.19 ?  I have a volume that mounts just fine in 2.6.18,
> but moving to 2.6.19 gets me this..
 
No - and at first sight that's not a kernel device-mapper problem.

Please grab some diagnostics:
  run the lvmdump script (present in the newest packages) or from here:

  http://sources.redhat.com/cgi-bin/cvsweb.cgi/~checkout~/LVM2/scripts/lvm_dump.sh?content-type=text/plain&cvsroot=lvm2

with the -a and -m flags.

[NB If you use dm-crypt and have userspace device-mapper < 1.02.13 you
need to remove the encryption keys from the 'dmsetup' output by hand.]

Alasdair
-- 
agk@redhat.com
