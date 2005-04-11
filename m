Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261843AbVDKRVH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261843AbVDKRVH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 13:21:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261861AbVDKRVH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 13:21:07 -0400
Received: from webmail.topspin.com ([12.162.17.3]:7605 "EHLO
	exch-1.topspincom.com") by vger.kernel.org with ESMTP
	id S261852AbVDKRUw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 13:20:52 -0400
To: Troy Benjegerdes <hozer@hozed.org>
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: [PATCH][RFC][0/4] InfiniBand userspace verbs implementation
X-Message-Flag: Warning: May contain useful information
References: <200544159.Ahk9l0puXy39U6u6@topspin.com>
	<20050411142213.GC26127@kalmia.hozed.org> <52mzs51g5g.fsf@topspin.com>
	<20050411163342.GE26127@kalmia.hozed.org>
From: Roland Dreier <roland@topspin.com>
Date: Mon, 11 Apr 2005 09:56:53 -0700
In-Reply-To: <20050411163342.GE26127@kalmia.hozed.org> (Troy Benjegerdes's
 message of "Mon, 11 Apr 2005 11:33:42 -0500")
Message-ID: <5264yt1cbu.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 11 Apr 2005 16:56:54.0078 (UTC) FILETIME=[76AAF5E0:01C53EB7]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Troy> Is there a check in the kernel that the memory is actually
    Troy> mlock()ed?

No.

    Troy> What if a malicious (or broken) application does
    Troy> ibv_reg_mr() but doesn't lock the memory? Does the IB card
    Troy> get a physical address for a page that might get swapped
    Troy> out?

No, the kernel does get_user_pages().  So the pages that the HCA gets
will not be swapped or used for anything else.  The only thing a
malicious userspace app can do is screw itself up.

 - R.
