Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267378AbUIAQCo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267378AbUIAQCo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 12:02:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267338AbUIAQC3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 12:02:29 -0400
Received: from umhlanga.stratnet.net ([12.162.17.40]:22774 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S267378AbUIAQBo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 12:01:44 -0400
To: Albert Cahalan <albert@users.sf.net>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       arjanv@redhat.com, viro@parcelfarce.linux.theplanet.co.uk,
       mst@mellanox.co.il, filia@softhome.net
Subject: Re: f_ops flag to speed up compatible ioctls in linux kernel
X-Message-Flag: Warning: May contain useful information
References: <1094052981.431.7160.camel@cube>
From: Roland Dreier <roland@topspin.com>
Date: Wed, 01 Sep 2004 08:59:09 -0700
In-Reply-To: <1094052981.431.7160.camel@cube> (Albert Cahalan's message of
 "01 Sep 2004 11:36:21 -0400")
Message-ID: <52vfey0ylu.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 01 Sep 2004 15:59:09.0218 (UTC) FILETIME=[9DBEC820:01C4903C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Albert> Per-command parameters included?

    Albert> People really do want private syscalls. An ioctl is that,
    Albert> in a namespace defined by the file descriptor. So ioctl()
    Albert> provides local scope to something that would otherwise be
    Albert> global.

Yes, this is exactly right.  One issue raised by this thread is that
the ioctl32 compatibility code only allows one compatibility handler
per ioctl number.  It seems that this creates all sorts of
possibilities for mayhem because it makes the ioctl namespace global
in scope in some situations.  Does anyone have any thoughts on if/how
this should be addressed.

 - Roland
