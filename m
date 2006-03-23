Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932467AbWCWAFF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932467AbWCWAFF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 19:05:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932583AbWCWAFF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 19:05:05 -0500
Received: from mx.pathscale.com ([64.160.42.68]:8660 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S932467AbWCWAFE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 19:05:04 -0500
Content-Type: multipart/mixed; boundary="===============0254726861=="
MIME-Version: 1.0
Subject: [PATCH 0 of 18] [RFC] ipath - almost-final round of patches for
	submission
Message-Id: <patchbomb.1143072293@eng-12.pathscale.com>
Date: Wed, 22 Mar 2006 16:04:53 -0800
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: linux-kernel@vger.kernel.org, rdreier@cisco.com, greg@kroah.com
Cc: openib-general@openib.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--===============0254726861==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is another round of ipath driver patches for review.  I believe
the driver is almost ready for submission.  We have addressed all prior
feedback that I am aware of.

Major changes since the last round of review comments:

  - Layered drivers now do the right thing when the underlying devices
    get hotplugged.

  - The memory leak that Linus, Hugh, and others have been so helpful with
    during the past week is fixed; we now use remap_pfn_range instead of a
    nopage handler.

  - There are no longer any binary or multiple-valued files in sysfs.
    Instead, we've added an ipathfs filesystem for that stuff.

There are two things left to do:

  - ipath_rc.c contains some enormous functions that we are in the
    process of breaking up into more digestible chunks.

  - The ipathfs filesystem doesn't handle hotplugged devices.

If you have any comments or suggestions, please let me know.  If the
current code looks OK, I expect to make a final submission for 2.6.17
in a day or two, once we have the above two items completed.

	<b

--===============0254726861==--
