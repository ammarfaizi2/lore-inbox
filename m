Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261551AbUEFEoh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261551AbUEFEoh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 May 2004 00:44:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261602AbUEFEoh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 May 2004 00:44:37 -0400
Received: from [66.35.79.110] ([66.35.79.110]:25240 "EHLO www.hockin.org")
	by vger.kernel.org with ESMTP id S261551AbUEFEog (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 May 2004 00:44:36 -0400
Date: Wed, 5 May 2004 21:44:33 -0700
From: Tim Hockin <thockin@hockin.org>
To: linux-kernel@vger.kernel.org
Cc: viro@parcelfarce.linux.theplanet.co.uk
Subject: lazy-umount cwd and ..
Message-ID: <20040506044433.GA13933@hockin.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I notice that a process that is in a dir which gets lazy-unmounted
suddenly sees it's current dir change and its '..' dir points back to
itself.

I'm not sure it's a huge deal, but we have a half-patch floating around
that changes the behavior such that the unmounted mnt->mnt_parent is
retained and unreferenced when the mnt is finally released.  This seems to
make any process which is in the unmounted mount not see anything
different, but does not let any new processes into the mount.

Minor, but friendly.

Should I bother to polish this patch off and send it, or is it just not
something we want to care about?

Tim
