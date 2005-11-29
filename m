Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932255AbVK2RIN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932255AbVK2RIN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Nov 2005 12:08:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932262AbVK2RIN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Nov 2005 12:08:13 -0500
Received: from ams-iport-1.cisco.com ([144.254.224.140]:786 "EHLO
	ams-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S932255AbVK2RIM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Nov 2005 12:08:12 -0500
To: Adrian Bunk <bunk@stusta.de>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       mshefty@ichips.intel.com, halr@voltaire.com, openib-general@openib.org,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] drivers/infiniband/core/mad.c: fix a NULL pointer
 dereference
X-Message-Flag: Warning: May contain useful information
References: <20051126233736.GE3988@stusta.de> <52irud4pki.fsf@cisco.com>
	<20051128002523.GA31395@stusta.de> <52psok1wne.fsf@cisco.com>
	<20051129123052.GF31395@stusta.de>
From: Roland Dreier <rolandd@cisco.com>
Date: Tue, 29 Nov 2005 09:07:58 -0800
In-Reply-To: <20051129123052.GF31395@stusta.de> (Adrian Bunk's message of
 "Tue, 29 Nov 2005 13:30:52 +0100")
Message-ID: <52veybwff5.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.17 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
X-OriginalArrivalTime: 29 Nov 2005 17:08:00.0088 (UTC) FILETIME=[737A0580:01C5F507]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Roland> Is this really important enough for the stable tree?

    Adrian> You said it fixed a crash for you.

To trigger the patch, you have to hit the error path, which in
practical terms requires buggy code calling into the function.  And
you also have to either be running with CONFIG_DEBUG_SLAB=y or be
extremely unlucky.  So I don't think anyone who's not developing IB
driver code could ever hit the crash, and any developers are going to
be running the latest tree anyway.

    Adrian> Besides this, it's a small and easy to verify change.

Sure, I don't mind it going into the stable tree.  I'm just not sure
it's worth spending everyone's time on it.

 - R.
