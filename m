Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270922AbTGPQbH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 12:31:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270949AbTGPQbG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 12:31:06 -0400
Received: from fw.osdl.org ([65.172.181.6]:44712 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S270922AbTGPQbA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 12:31:00 -0400
Date: Wed, 16 Jul 2003 09:38:31 -0700
From: Andrew Morton <akpm@osdl.org>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: barryn@pobox.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.6.0-test1-mm1
Message-Id: <20030716093831.6d9aa8f1.akpm@osdl.org>
In-Reply-To: <20030716150953.GL15452@holomorphy.com>
References: <20030715225608.0d3bff77.akpm@osdl.org>
	<20030716104448.GC25869@ip68-4-255-84.oc.oc.cox.net>
	<20030716035848.560674ac.akpm@osdl.org>
	<20030716122454.GJ15452@holomorphy.com>
	<20030716143221.GD25829@ip68-4-255-84.oc.oc.cox.net>
	<20030716144155.GK15452@holomorphy.com>
	<20030716150207.GE25829@ip68-4-255-84.oc.oc.cox.net>
	<20030716150953.GL15452@holomorphy.com>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III <wli@holomorphy.com> wrote:
>
> On Wed, Jul 16, 2003 at 07:41:55AM -0700, William Lee Irwin III wrote:
> >> Oh, well that won't fly; it effectively isn't a constant initializer.
> >> I'll see what can be rammed past gcc. We're shooting for something
> >> with array element 0 equal to 0x1UL and all others 0.
> 
> On Wed, Jul 16, 2003 at 08:02:07AM -0700, Barry K. Nathan wrote:
> > BTW, following my e-mail signature in this message is my .config. I
> > guess the most notable setting is that CONFIG_SMP is disabled (i.e.,
> > it's a UP compile).
> 
> Hmm. Well, ditching the strong typechecking would "fix" it, though
> that's really only papering over it.
> 

It doesn't _have_ to be initialised at compile time.  Just stick a
little loop in init_IRQ()?

