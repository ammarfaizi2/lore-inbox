Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030217AbWECPnb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030217AbWECPnb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 May 2006 11:43:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965228AbWECPnb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 May 2006 11:43:31 -0400
Received: from ms-smtp-02.texas.rr.com ([24.93.47.41]:12520 "EHLO
	ms-smtp-02.texas.rr.com") by vger.kernel.org with ESMTP
	id S965227AbWECPnb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 May 2006 11:43:31 -0400
Subject: [PATCH 0/2][RFC] New version of shared page tables
From: Dave McCracken <dmccr@us.ibm.com>
To: Hugh Dickins <hugh@veritas.com>
Cc: Linux Memory Management <linux-mm@kvack.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Wed, 03 May 2006 10:43:24 -0500
Message-Id: <1146671004.24422.20.camel@wildcat.int.mccr.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I've done some cleanup and some bugfixing.  Hugh, please review
this version instead of the old one.  I like my locking mechanism
for unsharing on this one a lot better.  It works on an address
range instead of depending on a vma, which more closely reflects
the way it's used.

The first patch just standardizes the pxd_page/pxd_page_kernel macros
for all architectures.

The second patch is the heart of shared page tables.

This version of the patches is against 2.6.17-rc3.

Dave McCracken



