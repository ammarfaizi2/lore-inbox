Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936463AbWLALj5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936463AbWLALj5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 06:39:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936471AbWLALj5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 06:39:57 -0500
Received: from z2.cat.iki.fi ([212.16.98.133]:3267 "EHLO z2.cat.iki.fi")
	by vger.kernel.org with ESMTP id S936463AbWLALj4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 06:39:56 -0500
Date: Fri, 1 Dec 2006 13:39:54 +0200
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: linux-kernel@vger.kernel.org
Subject: Linux poll(2) functionality difference from Solaris (10)
Message-ID: <20061201113954.GX10054@mea-ext.zmailer.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am coding first rounds usually on Linux, but I do try to verify
everything on several other UNIXes.

During this port debugging I realized that on Solaris the
poll(2) result flags return POLLEOF without POLLIN on files
that have EOF condition for reading.

In same situation the Linux 2.6.15 returns POLLIN, but I don't
know if there is also POLLEOF.  (Same with 2.6.9 at vger.kernel.org)


To track the issue, I did enter it also into Kernel Bugzilla:

  http://bugzilla.kernel.org/show_bug.cgi?id=7609


/Matti Aarnio  -- Now VGER could run more than 1000 parallel
outgoing SMTP sessions.  (Not that it really needs to.)
