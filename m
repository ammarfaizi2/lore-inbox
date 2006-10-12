Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422664AbWJLIEz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422664AbWJLIEz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 04:04:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932506AbWJLIEz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 04:04:55 -0400
Received: from smtp.osdl.org ([65.172.181.4]:21204 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932494AbWJLIEy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 04:04:54 -0400
Date: Thu, 12 Oct 2006 01:04:06 -0700
From: Andrew Morton <akpm@osdl.org>
To: Neil Brown <neilb@suse.de>
Cc: Arjan van de Ven <arjan@infradead.org>,
       Michal Piotrowski <michal.k.k.piotrowski@gmail.com>,
       Pavel Machek <pavel@ucw.cz>, "Rafael J. Wysocki" <rjw@sisk.pl>,
       linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
       rusty@rustcorp.com.au
Subject: Re: SPAM: Re: _cpu_down deadlock [was Re: 2.6.19-rc1-mm1]
Message-Id: <20061012010406.e799e036.akpm@osdl.org>
In-Reply-To: <17709.62567.429791.797941@cse.unsw.edu.au>
References: <20061010000928.9d2d519a.akpm@osdl.org>
	<6bffcb0e0610100610p6eb65726of92b85f7d49e80bb@mail.gmail.com>
	<6bffcb0e0610100704m32ccc6bakb446671f04b04c2b@mail.gmail.com>
	<17708.33450.608010.113968@cse.unsw.edu.au>
	<6bffcb0e0610110348i1d3fc15qa0c57a6586aca3e@mail.gmail.com>
	<1160565786.3000.369.camel@laptopd505.fenrus.org>
	<17708.60613.451322.747200@cse.unsw.edu.au>
	<20061011093920.32fc2d07.akpm@osdl.org>
	<17709.33386.884615.679131@cse.unsw.edu.au>
	<1160635872.3000.399.camel@laptopd505.fenrus.org>
	<17709.62567.429791.797941@cse.unsw.edu.au>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Oct 2006 17:53:11 +1000
Neil Brown <neilb@suse.de> wrote:

> I think I'm in favour of the following. 

Would be simpler to take cpu_add_remove_lock in
[un]register_cpu_notifier().  I actually thought I'd done that to fix this
bug but must have forgotten or lost the patch :(

We can then convert all the notifier chains in there to raw_*.

