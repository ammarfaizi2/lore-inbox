Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261548AbVCRJda@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261548AbVCRJda (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Mar 2005 04:33:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261549AbVCRJda
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Mar 2005 04:33:30 -0500
Received: from fire.osdl.org ([65.172.181.4]:55968 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261548AbVCRJdN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Mar 2005 04:33:13 -0500
Date: Fri, 18 Mar 2005 01:32:51 -0800
From: Andrew Morton <akpm@osdl.org>
To: rostedt@goodmis.org
Cc: mingo@elte.hu, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] remove lame schedule in journal inverted_lock (was: Re:
 [patch 0/3] j_state_lock, j_list_lock, remove-bitlocks)
Message-Id: <20050318013251.330e4d78.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0503180415370.21994@localhost.localdomain>
References: <Pine.LNX.4.58.0503141024530.697@localhost.localdomain>
	<Pine.LNX.4.58.0503150641030.6456@localhost.localdomain>
	<20050315120053.GA4686@elte.hu>
	<Pine.LNX.4.58.0503150746110.6456@localhost.localdomain>
	<20050315133540.GB4686@elte.hu>
	<Pine.LNX.4.58.0503151150170.6456@localhost.localdomain>
	<20050316085029.GA11414@elte.hu>
	<20050316011510.2a3bdfdb.akpm@osdl.org>
	<20050316095155.GA15080@elte.hu>
	<20050316020408.434cc620.akpm@osdl.org>
	<20050316101906.GA17328@elte.hu>
	<20050316024022.6d5c4706.akpm@osdl.org>
	<Pine.LNX.4.58.0503160600200.11824@localhost.localdomain>
	<20050316031909.08e6cab7.akpm@osdl.org>
	<Pine.LNX.4.58.0503160853360.11824@localhost.localdomain>
	<Pine.LNX.4.58.0503161141001.14087@localhost.localdomain>
	<Pine.LNX.4.58.0503161234350.14460@localhost.localdomain>
	<20050316131521.48b1354e.akpm@osdl.org>
	<Pine.LNX.4.58.0503170406500.17019@localhost.localdomain>
	<Pine.LNX.4.58.0503180415370.21994@localhost.localdomain>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Rostedt <rostedt@goodmis.org> wrote:
>
> 
> Andrew,
> 
> Since I haven't gotten a response from you,

It sometimes takes me half a day to get onto looking at patches.  And if I
take them I usually don't reply (sorry).  But I don't drop stuff, so if you
don't hear, please assume the patch stuck.  If others raise objections
to the patch I'll usually duck it as well, but it's pretty obvious when that
happens.

I really should knock up a script to send out an email when I add a patch
to -mm.

> I'd figure that you may have
> missed this, since the subject didn't change.  So I changed the subject to
> get your attention, and I've resent this. Here's the patch to get rid of
> the the lame schedule that was in fs/jbd/commit.c.   Let me know if this
> patch is appropriate.

I'm rather aghast at all the ifdeffery and complexity in this one.  But I
haven't looked at it closely yet.

