Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262234AbVEYBpM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262234AbVEYBpM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 21:45:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262236AbVEYBpL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 21:45:11 -0400
Received: from fire.osdl.org ([65.172.181.4]:54468 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262234AbVEYBpE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 21:45:04 -0400
Date: Tue, 24 May 2005 18:43:51 -0700
From: Andrew Morton <akpm@osdl.org>
To: dwalker@mvista.com
Cc: bhuey@lnxw.com, nickpiggin@yahoo.com.au, mingo@elte.hu, hch@infradead.org,
       linux-kernel@vger.kernel.org, sdietrich@mvista.com
Subject: Re: RT patch acceptance
Message-Id: <20050524184351.47d1a147.akpm@osdl.org>
In-Reply-To: <1116982977.19926.63.camel@dhcp153.mvista.com>
References: <4292DFC3.3060108@yahoo.com.au>
	<20050524081517.GA22205@elte.hu>
	<4292E559.3080302@yahoo.com.au>
	<20050524090240.GA13129@elte.hu>
	<4292F074.7010104@yahoo.com.au>
	<1116957953.31174.37.camel@dhcp153.mvista.com>
	<20050524224157.GA17781@nietzsche.lynx.com>
	<1116978244.19926.41.camel@dhcp153.mvista.com>
	<20050525001019.GA18048@nietzsche.lynx.com>
	<1116981913.19926.58.camel@dhcp153.mvista.com>
	<20050525005942.GA24893@nietzsche.lynx.com>
	<1116982977.19926.63.camel@dhcp153.mvista.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Walker <dwalker@mvista.com> wrote:
>
> I'm not going to ignore any of the discussion, but it would be nice to
>  hear Andrew's, or Linus's specific objections..

I have no specific objections - this all started out from my general
observation that things like process-context IRQ handlers and
priority-inheriting mutexes have had a tough reception in the past, and are
likely to do so in the future as well.

This thing will be discussed on a patch-by-patch basis.  Contra this email
thread, we won't consider it from an all-or-nothing perspective.

(That being said, it's already a mighty task to decrypt your way through
the maze-like implementation of spin_lock(), lock_kernel(),
smp_processor_id() etc, etc.  I really do wish there was some way we could
clean up/simplify that stuff before getting in and adding more source-level
complexity).

