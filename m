Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932566AbVINBn4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932566AbVINBn4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 21:43:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932565AbVINBn4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 21:43:56 -0400
Received: from ams-iport-1.cisco.com ([144.254.224.140]:59699 "EHLO
	ams-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S932566AbVINBnz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 21:43:55 -0400
To: Andrew Morton <akpm@osdl.org>
Cc: James Morris <jmorris@namei.org>, linux-kernel@vger.kernel.org,
       sds@epoch.ncsc.mil
Subject: Re: [PATCH] SELinux - convert to kzalloc
X-Message-Flag: Warning: May contain useful information
References: <Pine.LNX.4.63.0509131116280.3479@excalibur.intercode>
	<20050913120707.74a19800.akpm@osdl.org>
From: Roland Dreier <rolandd@cisco.com>
Date: Tue, 13 Sep 2005 18:43:48 -0700
In-Reply-To: <20050913120707.74a19800.akpm@osdl.org> (Andrew Morton's
 message of "Tue, 13 Sep 2005 12:07:07 -0700")
Message-ID: <52y8602zl7.fsf@cisco.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 14 Sep 2005 01:43:50.0107 (UTC) FILETIME=[C15162B0:01C5B8CD]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Andrew> That's a nice size reduction.  If we had
    Andrew> kzalloc_gfp_kernel(size_t) we could drop an argument and
    Andrew> save even more, but I suspect Linus would come after me
    Andrew> with a cattle prod.

Could one make kzalloc() an inline and do some __builtin_constant_p()
trickery on the flags parameter to get the same effect?

I'll give it a try and see what happens.

 - R.
