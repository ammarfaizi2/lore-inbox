Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932129AbWBRTuR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932129AbWBRTuR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Feb 2006 14:50:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932130AbWBRTuQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Feb 2006 14:50:16 -0500
Received: from mx1.redhat.com ([66.187.233.31]:60063 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932129AbWBRTuP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Feb 2006 14:50:15 -0500
Date: Sat, 18 Feb 2006 19:50:05 +0000
From: Alasdair G Kergon <agk@redhat.com>
To: "Jun'ichi Nomura" <j-nomura@ce.jp.nec.com>
Cc: Alasdair G Kergon <agk@redhat.com>, Neil Brown <neilb@suse.de>,
       Lars Marowsky-Bree <lmb@suse.de>,
       device-mapper development <dm-devel@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] sysfs representation of stacked devices (dm/md common)
Message-ID: <20060218195005.GT12169@agk.surrey.redhat.com>
Mail-Followup-To: Jun'ichi Nomura <j-nomura@ce.jp.nec.com>,
	Alasdair G Kergon <agk@redhat.com>, Neil Brown <neilb@suse.de>,
	Lars Marowsky-Bree <lmb@suse.de>,
	device-mapper development <dm-devel@redhat.com>,
	linux-kernel@vger.kernel.org
References: <43F60F31.1030507@ce.jp.nec.com> <43F60F8C.8090207@ce.jp.nec.com> <20060217184435.GM12169@agk.surrey.redhat.com> <43F67274.80509@ce.jp.nec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43F67274.80509@ce.jp.nec.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 17, 2006 at 08:03:48PM -0500, Jun'ichi Nomura wrote:
> I moved the sysfs_add_link() to the last part of dm_resume().

Test with trees of devices too - where a whole tree is suspended -
I don't think you can allocate anywhere in dm_swap_table()
without PF_MEMALLOC (which I recently removed and am reluctant
to reinstate).

Have you considered if anything is feasible based around bd_claim()?
Doesn't it make more sense for the links to be set up at table
load time - i.e. superset of both tables if present?

Alasdair
-- 
agk@redhat.com
