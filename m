Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269097AbUJERXx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269097AbUJERXx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 13:23:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269099AbUJERXw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 13:23:52 -0400
Received: from umhlanga.stratnet.net ([12.162.17.40]:40735 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S269097AbUJERXs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 13:23:48 -0400
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org
X-Message-Flag: Warning: May contain useful information
References: <52u0t9u414.fsf@topspin.com> <200410051032.39531.arnd@arndb.de>
From: Roland Dreier <roland@topspin.com>
Date: Tue, 05 Oct 2004 10:23:45 -0700
In-Reply-To: <200410051032.39531.arnd@arndb.de> (Arnd Bergmann's message of
 "Tue, 5 Oct 2004 10:32:33 +0200")
Message-ID: <52vfdprsda.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: roland@topspin.com
Subject: Re: proper way to annotate kernel use of sys_xxx?
Content-Type: text/plain; charset=us-ascii
X-SA-Exim-Version: 4.1 (built Tue, 17 Aug 2004 11:06:07 +0200)
X-SA-Exim-Scanned: Yes (on eddore)
X-OriginalArrivalTime: 05 Oct 2004 17:23:46.0697 (UTC) FILETIME=[12341790:01C4AB00]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Arnd> In this case, you can easily convert the calls to use
    Arnd> filp_open/vfs_read/filp_close, though I'm not sure if that's
    Arnd> the correct solution either.

For the do_mounts.c code, I see how the call to sys_open() could be
replaced with a call to filp_open().  However, vfs_read() still takes
a __user pointer for its buffer argument -- in fact, even the
filesystem .aio_read method takes a __user pointer.  So I'm not sure
how this code should be fixed.

Thanks,
  Roland
