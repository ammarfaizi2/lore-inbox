Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261181AbUK2RLG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261181AbUK2RLG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 12:11:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261298AbUK2RLG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 12:11:06 -0500
Received: from bgm-24-94-59-124.stny.rr.com ([24.94.59.124]:59824 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261181AbUK2RLA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 12:11:00 -0500
Subject: Re: [RFC] dynamic syscalls revisited
From: Steven Rostedt <rostedt@goodmis.org>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.53.0411291740390.30846@yvahk01.tjqt.qr>
References: <1101741118.25841.40.camel@localhost.localdomain>
	 <20041129151741.GA5514@infradead.org>
	 <Pine.LNX.4.53.0411291740390.30846@yvahk01.tjqt.qr>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: Kihon Technologies
Date: Mon, 29 Nov 2004 12:10:58 -0500
Message-Id: <1101748258.25841.53.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-11-29 at 17:41 +0100, Jan Engelhardt wrote:
> I do not see how dsyscalls could be better than static ones, so they are
> one-on-one. Maybe someone could elaborate why they are "a really bad idea"?

The one argument against them, that I agree with, is Linus' hooks to
avoid the GPL.  A binary only module could easily add their own hooks
into the kernel.

I've made this patch with the option to turn this off. I should have put
the option in Kernel debugging with the default off (the default is
currently on so that if you apply the patch, you have it automatically).
This way binary only modules can't take advantage of the dynamic
syscalls without recompiling the kernel.  If the user needed to compile
the kernel, then a patch can easily be added, so this is just as good of
a defense. 

-- Steve


