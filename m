Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261680AbUKBKCR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261680AbUKBKCR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 05:02:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261653AbUKBKCN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 05:02:13 -0500
Received: from fmr12.intel.com ([134.134.136.15]:12239 "EHLO
	orsfmr001.jf.intel.com") by vger.kernel.org with ESMTP
	id S263691AbUKBKAj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 05:00:39 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH x86_64]: Setup PER_LINUX32 on x86_64
Date: Tue, 2 Nov 2004 18:00:36 +0800
Message-ID: <8126E4F969BA254AB43EA03C59F44E84BBED0A@pdsmsx404>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH x86_64]: Setup PER_LINUX32 on x86_64
Thread-Index: AcTAuKOU32iYMuOgR+meBVLy86RD8AACAREw
From: "Jin, Gordon" <gordon.jin@intel.com>
To: <discuss@x86-64.org>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 02 Nov 2004 10:00:36.0966 (UTC) FILETIME=[CD0E2060:01C4C0C2]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jin, Gordon <> wrote on Tuesday, November 02, 2004 4:48 PM:

> On x86_64, PER_LINUX32 is not setup but used by syscall personality
> and uname. This patch sets PER_LINUX32 when x86 binary loaded so it
> can be used correctly. 
> - Set personality to PER_LINUX32 when x86 binary loaded.
> - Set personality to PER_LINUX when x86_64 binary loaded.
> - Use sys32_personality instead of sys_personality.
> - Add sys32_newuname() for syscall newuname.
> - Remove the unnecessary check for PER_LINUX32 in sys_uname().
> 
A side question is:
To distinguish 32-bit and native 64-bit app on x86-64(and some other archs),
somewhere PER_LINUX32 is used, while somewhere TIF_IA32 is used.
So both of them need maintained, respectively in task_struct and thread_info.
Is it redundant? Can we do away TIF_IA32?

Thanks,
Gordon
