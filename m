Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268430AbUIGS4x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268430AbUIGS4x (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 14:56:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268342AbUIGSN1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 14:13:27 -0400
Received: from inx.pm.waw.pl ([195.116.170.20]:59027 "EHLO inx.pm.waw.pl")
	by vger.kernel.org with ESMTP id S268322AbUIGSMg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 14:12:36 -0400
To: <linux-kernel@vger.kernel.org>
Subject: unneeded #include <version.h> in many places ?
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Tue, 07 Sep 2004 18:17:53 +0200
Message-ID: <m3d60yxdce.fsf@defiant.pm.waw.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I noticed some kernel .c files #include <version.h> which typically
contains something like:

#define UTS_RELEASE "2.6.9-rc1"
#define LINUX_VERSION_CODE 132617
#define KERNEL_VERSION(a,b,c) (((a) << 16) + ((b) << 8) + (c))

However, those files don't reference the macros.

The question is: are these includes completely unneeded, so I can
remove them, or do they serve some special purpose?

Another one: there are drivers using constructs like:

#if LINUX_VERSION_CODE > 0x20115
...
#endif

I understand they can be somehow useful for authors supporting many
kernel versions with a single set of files, however the gain isn't
clear to me. Should such conditional code be a) removed, b) left
in place, c) dealt with each case individually?
-- 
Krzysztof Halasa
