Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750934AbWIMWSs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750934AbWIMWSs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Sep 2006 18:18:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750984AbWIMWSs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Sep 2006 18:18:48 -0400
Received: from mx1.redhat.com ([66.187.233.31]:63169 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750934AbWIMWSr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Sep 2006 18:18:47 -0400
Date: Wed, 13 Sep 2006 23:18:41 +0100
From: Alasdair G Kergon <agk@redhat.com>
To: David Greaves <david@dgreaves.com>
Cc: LVM general discussion and development <linux-lvm@redhat.com>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: [linux-lvm] Oops and BUG in dm-snapshot
Message-ID: <20060913221840.GU13859@agk.surrey.redhat.com>
Mail-Followup-To: David Greaves <david@dgreaves.com>,
	LVM general discussion and development <linux-lvm@redhat.com>,
	"'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
References: <44D3D04B.5060603@dgreaves.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44D3D04B.5060603@dgreaves.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 04, 2006 at 11:55:07PM +0100, David Greaves wrote:
> EIP is at exit_exception_table+0x36/0x5f [dm_snapshot]

http://bugzilla.kernel.org/show_bug.cgi?id=7040

Here's a patch for this to test:
http://www.kernel.org/pub/linux/kernel/people/agk/patches/2.6/editing/dm-snapshot-fix-freeing-pending-exception.patch
(depending on your kernel, to apply it you may require earlier snapshot patches
listed in the series file in the same directory)

Alasdair
-- 
agk@redhat.com
