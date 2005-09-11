Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750860AbVIKUjP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750860AbVIKUjP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Sep 2005 16:39:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750861AbVIKUjO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Sep 2005 16:39:14 -0400
Received: from fmr15.intel.com ([192.55.52.69]:57275 "EHLO
	fmsfmr005.fm.intel.com") by vger.kernel.org with ESMTP
	id S1750859AbVIKUjN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Sep 2005 16:39:13 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: new asm-offsets.h patch problems
Date: Sun, 11 Sep 2005 13:39:07 -0700
Message-ID: <B8E391BBE9FE384DAA4C5C003888BE6F045A8E70@scsmsx401.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: new asm-offsets.h patch problems
Thread-Index: AcW2pJy/5UxBgf3gRw6qdHGy+FP8FAAO4CrQAAwKTaA=
From: "Luck, Tony" <tony.luck@intel.com>
To: "Luck, Tony" <tony.luck@intel.com>, "Sam Ravnborg" <sam@ravnborg.org>
Cc: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 11 Sep 2005 20:39:09.0864 (UTC) FILETIME=[DC9E2A80:01C5B710]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>I'll try it.  Hunk#2 of the change to Makefile didn't apply with
>patch ... I had to apply it by hand.

Either I goofed on the hand application of this patch, or it isn't
working.  Curious thing is that it works with some config files, but
not with others.  When I first reported this problem, all my builds
had worked except for the sn2_defconfig one.  With this patch applied
I'm seeing bigsur_defconfig fail quite regularly.

E.g. this sequence (starting from a clean tree):

 $ cp arch/ia64/configs/bigsur_defconfig .config
 $ yes '' | make oldconfig
 $ make prepare

leaves me with an include/asm-ia64/asm-offsets.h that only has the
definition of IA64_TASK_SIZE at 0.

-Tony
