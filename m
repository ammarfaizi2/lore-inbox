Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261967AbVCNWKy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261967AbVCNWKy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 17:10:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262025AbVCNWKm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 17:10:42 -0500
Received: from fmr16.intel.com ([192.55.52.70]:23199 "EHLO
	fmsfmr006.fm.intel.com") by vger.kernel.org with ESMTP
	id S261988AbVCNWGR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 17:06:17 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: bad pgd/pmd in latest BK on ia64
Date: Mon, 14 Mar 2005 14:06:09 -0800
Message-ID: <B8E391BBE9FE384DAA4C5C003888BE6F031272AF@scsmsx401.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: bad pgd/pmd in latest BK on ia64
Thread-Index: AcUo3mQDYGegSbCyQ+upsIZEJCxIQwAAttew
From: "Luck, Tony" <tony.luck@intel.com>
To: "linux kernel" <linux-kernel@vger.kernel.org>
Cc: <linux-ia64@vger.kernel.org>
X-OriginalArrivalTime: 14 Mar 2005 22:06:11.0013 (UTC) FILETIME=[07E58750:01C528E2]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trying to boot a build of the latest BK on ia64 I see
a series of messages like this:

mm/memory.c:99: bad pgd e0000001feba4000.
mm/memory.c:99: bad pgd e0000001febac000.
mm/memory.c:99: bad pgd e0000001febc0d10.
mm/memory.c:105: bad pmd f000eef3f0000200.
mm/memory.c:105: bad pmd f000eef3f000e2c3.
mm/memory.c:105: bad pmd f000ff54f000eef3.
mm/memory.c:105: bad pmd f000292cf0002984.

before the kernel gets an OOPS on a deref NULL
at resched_task+0x41/0x1a0.

2.6.11-bk9 boots ok, so this was added recently.

-Tony
