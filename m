Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264855AbTLVWSF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Dec 2003 17:18:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264867AbTLVWSF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Dec 2003 17:18:05 -0500
Received: from peabody.ximian.com ([141.154.95.10]:55514 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S264855AbTLVWSC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Dec 2003 17:18:02 -0500
Subject: Re: atomic copy_from_user?
From: Rob Love <rml@ximian.com>
To: Joe Korty <joe.korty@ccur.com>
Cc: William Lee Irwin III <wli@holomorphy.com>,
       Albert Cahalan <albert@users.sourceforge.net>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <20031222220610.GA3451@rudolph.ccur.com>
References: <1072054100.1742.156.camel@cube>
	 <20031222150026.GD27687@holomorphy.com>
	 <20031222182637.GA2659@rudolph.ccur.com> <1072126506.3318.31.camel@fur>
	 <20031222220610.GA3451@rudolph.ccur.com>
Content-Type: text/plain
Message-Id: <1072131479.3318.52.camel@fur>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-8) 
Date: Mon, 22 Dec 2003 17:18:00 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-12-22 at 17:06, Joe Korty wrote:

> If this is done then preempt_enable_no_resched() and preempt_enable() also
> need to be adjusted, as they both call dec_preempt_count().

True.

In that case, and because dec_preempt_count() is our base interface, I
think we should leave it alone and go back to your original idea
(explicitly call preempt_check_resched()).

	Rob Love


