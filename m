Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270938AbUJVJ0N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270938AbUJVJ0N (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 05:26:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270916AbUJVJSb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 05:18:31 -0400
Received: from mx1.redhat.com ([66.187.233.31]:57559 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S270914AbUJVJSH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 05:18:07 -0400
Date: Fri, 22 Oct 2004 02:17:55 -0700
Message-Id: <200410220917.i9M9Ht3m025244@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: Laurent Dufour <ldufour@meiosys.com>
X-Fcc: ~/Mail/linus
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM : Thread signal informations are not freed when it is
	execing.
In-Reply-To: Laurent Dufour's message of  Thursday, 21 October 2004 15:02:03 +0200 <1098363723.27235.103.camel@soho.lab.meiosys.com>
X-Zippy-Says: It's the RINSE CYCLE!!  They've ALL IGNORED the RINSE CYCLE!!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I don't think these problems are still relevant to the current sources,
though some of them might still occur in 2.6.9.  The fix I posted for the
semantics bugs of exec vs pending signals makes de_thread not abandon the
old signal_struct at all, so it holds on to all the data structures.  If
you can reproduce any kind of leak using the code now in Linus's tree,
please show me the details.


Thanks,
Roland
