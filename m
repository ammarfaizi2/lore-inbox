Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261236AbVCXX2y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261236AbVCXX2y (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 18:28:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261243AbVCXX2y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 18:28:54 -0500
Received: from mx1.redhat.com ([66.187.233.31]:41146 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261236AbVCXX2x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 18:28:53 -0500
Date: Thu, 24 Mar 2005 18:27:31 -0500
From: Bill Nottingham <notting@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org
Subject: bad caching behavior in 2.6.12rc1
Message-ID: <20050324232731.GA14812@nostromo.devel.redhat.com>
Mail-Followup-To: linux-kernel@vger.kernel.org, akpm@osdl.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When I upgraded from 2.6.11 to 2.6.12rc1, the VM started
behaving really badly with respect to caching.

Test box is a 1.5GB laptop.

In typical use, I would open a mailbox A, and then switch
to mailbox B. Immediately switching back to mailbox A, I
would find out it was no longer cached. (Using maildirs,
FWIW.)

Looking at /proc/meminfo, I would see:

LowFree: 8-12MB
HighFree: 300-400MB
Cached: 100-200MB

i.e., it was evicting cache when there was plenty of highmem
available for use.

When going back to 2.6.11, and using the same sort of the
workload, the caching would behave more as expected.

Bill
