Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263731AbTJORa7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Oct 2003 13:30:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263732AbTJORa7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Oct 2003 13:30:59 -0400
Received: from fw.osdl.org ([65.172.181.6]:50109 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263731AbTJORa5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Oct 2003 13:30:57 -0400
Date: Wed, 15 Oct 2003 10:34:31 -0700
From: Andrew Morton <akpm@osdl.org>
To: Martin Waitz <tali@admingilde.org>
Cc: anton@samba.org, wli@holomorphy.com, linux-kernel@vger.kernel.org
Subject: Re: mem=16MB laptop testing
Message-Id: <20031015103431.3bf1dfea.akpm@osdl.org>
In-Reply-To: <20031015133231.GK9850@admingilde.org>
References: <20031014105514.GH765@holomorphy.com>
	<20031014045614.22ea9c4b.akpm@osdl.org>
	<20031014121753.GA610@krispykreme>
	<20031014053154.469255e5.akpm@osdl.org>
	<20031014124457.GB610@krispykreme>
	<20031014164004.5f698467.akpm@osdl.org>
	<20031015133231.GK9850@admingilde.org>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Waitz <tali@admingilde.org> wrote:
>
> On Tue, Oct 14, 2003 at 04:40:04PM -0700, Andrew Morton wrote:
>  > + *	min_free_kbytes = lowmem_kbytes / sqrt(lowmem_kbytes)
> 
>  you do have a strange sqrt here ;)

You're the fifth person to tell me that.  Is this linux-kernel or linux-math?

Turns out that the int_sqrt() I stole from oom-kill.c appears to get wrong
numbers anyway.  I'll probably steal fb_sqrt(), which appears to get
correct numbers and consolidate it all...

