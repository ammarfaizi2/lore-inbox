Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261458AbTIYTZZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Sep 2003 15:25:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261607AbTIYTZZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Sep 2003 15:25:25 -0400
Received: from fw.osdl.org ([65.172.181.6]:13205 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261458AbTIYTZW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Sep 2003 15:25:22 -0400
Date: Thu, 25 Sep 2003 12:05:36 -0700
From: Andrew Morton <akpm@osdl.org>
To: Chris Wright <chrisw@osdl.org>
Cc: miltonm@realtime.net, rusty@rustcorp.com.au, Omen.Wild@Dartmouth.EDU,
       linux-kernel@vger.kernel.org
Subject: Re: call_usermodehelper does not report exit status?
Message-Id: <20030925120536.1252e756.akpm@osdl.org>
In-Reply-To: <20030925114150.A18074@osdlab.pdx.osdl.net>
References: <20030919124213.7fc93067.akpm@osdl.org>
	<200309201855.h8KItHuf000466@sullivan.realtime.net>
	<20030925114150.A18074@osdlab.pdx.osdl.net>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wright <chrisw@osdl.org> wrote:
>
> Anything wrong with just setting a SIG_DFL handler?

Seems that any time we make a change here it looks fine, tests out fine,
and explodes messily three weeks later.

> W.R.T. the kernel
> pointer, either Andrew's patch which does put_user/__put_user depending
> on context, or some ugly set_fs() should work.  This simplistic approach
> works for me, thoughts?

Yes, set_fs() is better.
