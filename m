Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264507AbTLVVkY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Dec 2003 16:40:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264508AbTLVVkY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Dec 2003 16:40:24 -0500
Received: from peabody.ximian.com ([141.154.95.10]:48601 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S264507AbTLVVkV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Dec 2003 16:40:21 -0500
Subject: Re: atomic copy_from_user?
From: Rob Love <rml@ximian.com>
To: Joe Korty <joe.korty@ccur.com>
Cc: William Lee Irwin III <wli@holomorphy.com>,
       Albert Cahalan <albert@users.sourceforge.net>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <20031222212237.GA2865@rudolph.ccur.com>
References: <1072054100.1742.156.camel@cube>
	 <20031222150026.GD27687@holomorphy.com>
	 <20031222182637.GA2659@rudolph.ccur.com> <1072126506.3318.31.camel@fur>
	 <20031222212237.GA2865@rudolph.ccur.com>
Content-Type: text/plain
Message-Id: <1072129210.3318.34.camel@fur>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-8) 
Date: Mon, 22 Dec 2003 16:40:11 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-12-22 at 16:22, Joe Korty wrote:

> I am guessing that nowdays even when preemption is disabled one can
> find preempt_count still being used somewhere.  Otherwise it would be
> better to replace all uses of inc_preempt_count() with
> preempt_disable() and dec_preempt_count() with preempt_enable().

Right.  So why did you make this patch? :)

inc_preempt_count() and dec_preempt_count() are for use when you
_absolutely_ must manage the preemption counter, regardless of whether
or not kernel preemption is enabled.

They are used for things like atomic kmaps.

	Rob Love


