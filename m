Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422751AbWJ3XcM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422751AbWJ3XcM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 18:32:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422756AbWJ3XcM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 18:32:12 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.144]:19150 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1422744AbWJ3XcK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 18:32:10 -0500
Date: Mon, 30 Oct 2006 17:32:09 -0600
From: Michael Halcrow <mhalcrow@us.ibm.com>
To: akpm@osdl.org
Cc: LKML <linux-kernel@vger.kernel.org>, mhalcrow@us.ibm.com
Subject: [PATCH 0/6] eCryptfs: Crypto API updates and d_count fixes
Message-ID: <20061030233209.GC3458@us.ibm.com>
Reply-To: Michael Halcrow <mhalcrow@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The lower d_count is not being handled right in eCryptfs, preventing
an unmount of the lower filesystem under some circumstances. This
patch set should make the d_count values sane in the lower
filesystem. It also includes changes to move from the deprecated
crypto API calls. These are bugfixes and compiler warning fixes; I
recommend merging them into 2.6.19.
