Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030460AbVLHFHp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030460AbVLHFHp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Dec 2005 00:07:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030461AbVLHFHp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Dec 2005 00:07:45 -0500
Received: from mx1.redhat.com ([66.187.233.31]:51614 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1030460AbVLHFHo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Dec 2005 00:07:44 -0500
Date: Thu, 8 Dec 2005 00:07:39 -0500
From: Dave Jones <davej@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: ak@suse.de
Subject: for_each_online_cpu broken ?
Message-ID: <20051208050738.GE24356@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	linux-kernel@vger.kernel.org, ak@suse.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Whilst debugging a memory leak, I hit sysrq meminfo,
and got hot/cold info for CONFIG_NR_CPUS rather than 4 cpus
I fixed a bug recently in mm/page_alloc.c to change this from
a for_each_cpu to a for_each_online_cpu and I'm pretty certain
I tested that it worked, but for reasons unknown, it's now
misbehaving again.

I've only tried reproducing this on x86-64 so far.

		Dave

