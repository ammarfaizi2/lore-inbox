Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261961AbVCWUlB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261961AbVCWUlB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 15:41:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261268AbVCWUi0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 15:38:26 -0500
Received: from fire.osdl.org ([65.172.181.4]:50341 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262909AbVCWUhP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 15:37:15 -0500
Date: Wed, 23 Mar 2005 12:36:41 -0800
From: Andrew Morton <akpm@osdl.org>
To: Dave Airlie <airlied@gmail.com>
Cc: covici@ccs.covici.com, linux-kernel@vger.kernel.org,
       benh@kernel.crashing.org, airlied@linux.ie
Subject: Re: X not working with Radeon 9200 under 2.6.11
Message-Id: <20050323123641.65ab0c91.akpm@osdl.org>
In-Reply-To: <21d7e9970503231150263cfc5e@mail.gmail.com>
References: <16937.54786.986183.491118@ccs.covici.com>
	<20050321145301.3511c097.akpm@osdl.org>
	<16959.25374.535872.507486@ccs.covici.com>
	<20050321162214.71483708.akpm@osdl.org>
	<21d7e9970503231150263cfc5e@mail.gmail.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Airlie <airlied@gmail.com> wrote:
>
> > 
>  > It's a bit sad that xfree _used_ to work (2.6.9?) and now it doesn't work,
>  > and the fix is to switch to the x.org server.
>  > 
>  > Do we know what changed to cause this?  Was it deliberate?
> 
>  If I was a guessing man and I am due to lack of time.. I'd say the
>  address space layout changes ..

Ow.  I never saw any such reports.

It should be pretty easy to test that: do

	echo 1 > /proc/sys/vm/legacy_va_layout

before starting X.

