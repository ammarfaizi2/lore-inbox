Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933172AbWKTSG7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933172AbWKTSG7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 13:06:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934211AbWKTSG7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 13:06:59 -0500
Received: from moutng.kundenserver.de ([212.227.126.186]:52724 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S933172AbWKTSG6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 13:06:58 -0500
Message-Id: <20061120174454.067872000@arndb.de>
User-Agent: quilt/0.45-1
Date: Mon, 20 Nov 2006 18:44:54 +0100
From: Arnd Bergmann <arnd@arndb.de>
To: cbe-oss-dev@ozlabs.org
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
       Paul Mackerras <paulus@samba.org>
Subject: [PATCH 00/22] Cell patches for 2.6.20
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm trying to flush my patch queue again for 2.6.20, this is
most of what has been coming in since the last submission
to powerpc.git. Please review for inclusion in powerpc.git.

As a quick overview, the patches contain:

* new spufs file interfaces to support more gdb functionality,
  to look into the state of various HW registers without changing
  data.
* core dump support for SPUs. When core dumping a task that has
  created SPU contexts, information about them will be included
  in the dump.
* A rework of the SPU HW isolation support. Reusing an isolated
  SPU for another program now doesn't require a new spufs interface
  any more, which simplifies the implementation significantly.
* A new oprofile model for using the profile event mechanism on
  the Cell Broadband Engine. This is only for PPE profiling so far,
  profiling SPU code is still work-in-progress.
* Lots of bug fixes.

I have some other patches in my cell kernel tree currently, which
I'm not submitting myself, because I assume they will find their own
way into the kernel:
* Patches to the spidernet driver, these go through netdev
* Support for the Playstation 3, the patches are currently under
  discussion, and I expect that Paul will take them directly once
  they are done.
* xmon add-ons for debugging with SPUs. Waiting for a new version
  to be submitted.

	Arnd <><

