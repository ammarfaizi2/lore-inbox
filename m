Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264509AbTLVWTz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Dec 2003 17:19:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264522AbTLVWTz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Dec 2003 17:19:55 -0500
Received: from peabody.ximian.com ([141.154.95.10]:57818 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S264509AbTLVWTx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Dec 2003 17:19:53 -0500
Subject: Re: atomic copy_from_user?
From: Rob Love <rml@ximian.com>
To: Andrew Morton <akpm@osdl.org>
Cc: joe.korty@ccur.com, wli@holomorphy.com, albert@users.sourceforge.net,
       linux-kernel@vger.kernel.org
In-Reply-To: <20031222141431.111e7611.akpm@osdl.org>
References: <1072054100.1742.156.camel@cube>
	 <20031222150026.GD27687@holomorphy.com>
	 <20031222182637.GA2659@rudolph.ccur.com> <1072126506.3318.31.camel@fur>
	 <20031222141431.111e7611.akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1072131587.3318.54.camel@fur>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-8) 
Date: Mon, 22 Dec 2003 17:19:48 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-12-22 at 17:14, Andrew Morton wrote:

> But preempt_enable_no_resched() calls dec_preempt_count().

Yah, Joe just pointed that out.

I do not really want to change the base interfaces, anyway ;)

I do think we should add an explicit preempt_check_resched() after calls
to dec_preempt_count() where we might be delaying a reschedule, though.

	Rob Love


