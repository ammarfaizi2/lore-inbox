Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752120AbWFWWPU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752120AbWFWWPU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 18:15:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752119AbWFWWPU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 18:15:20 -0400
Received: from mx1.redhat.com ([66.187.233.31]:26067 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1752118AbWFWWPT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 18:15:19 -0400
Date: Fri, 23 Jun 2006 23:15:13 +0100
From: Alasdair G Kergon <agk@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Kevin Corry <kevcorry@us.ibm.com>
Subject: Re: [PATCH 12/15] dm: add exports
Message-ID: <20060623221513.GC19222@agk.surrey.redhat.com>
Mail-Followup-To: Alasdair G Kergon <agk@redhat.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	Kevin Corry <kevcorry@us.ibm.com>
References: <20060621193657.GA4521@agk.surrey.redhat.com> <20060621210504.b1f387bd.akpm@osdl.org> <20060622135117.GS19222@agk.surrey.redhat.com> <20060622100353.50a7654e.akpm@osdl.org> <20060623150011.GW19222@agk.surrey.redhat.com> <20060623153323.GA4848@infradead.org> <20060623140040.01aeccf9.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060623140040.01aeccf9.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 23, 2006 at 02:00:40PM -0700, Andrew Morton wrote:
> but I'm uncertain if I can just reshuffle them like this, because at least
> two of them update the userspace-visible DM version number.

In this instance there's nothing in distributed userspace code relying on the
actual version numbers yet, so it's OK to swap them over if the ioctl patches
are held back:

  dm-prevent-removal-if-open.patch then sets #define DM_VERSION_MINOR 7

  dm-support-ioctls-on-mapped-devices.patch then sets #define DM_VERSION_MINOR 8

(The date in DM_VERSION_EXTRA is for information only - can either leave alone
or set to today's date when edited.)

Alasdair
-- 
agk@redhat.com
