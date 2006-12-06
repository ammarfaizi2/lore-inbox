Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1760443AbWLFKU3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760443AbWLFKU3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 05:20:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760447AbWLFKU3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 05:20:29 -0500
Received: from mx1.redhat.com ([66.187.233.31]:44909 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760438AbWLFKU2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 05:20:28 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20061206002403.GA4587@ftp.linux.org.uk> 
References: <20061206002403.GA4587@ftp.linux.org.uk>  <20061204114851.GA25859@elte.hu> <20061201172149.GC3078@ftp.linux.org.uk> <1165064370.24604.36.camel@localhost.localdomain> <20061202140521.GJ3078@ftp.linux.org.uk> <1165070713.24604.50.camel@localhost.localdomain> <20061202160252.GQ14076@parisc-linux.org> <1165082803.24604.54.camel@localhost.localdomain> <20061202181957.GK3078@ftp.linux.org.uk> <28665.1165234964@redhat.com> 
To: Al Viro <viro@ftp.linux.org.uk>
Cc: David Howells <dhowells@redhat.com>, Ingo Molnar <mingo@elte.hu>,
       Thomas Gleixner <tglx@linutronix.de>, Matthew Wilcox <matthew@wil.cx>,
       Linus Torvalds <torvalds@osdl.org>, linux-arch@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] timers, pointers to functions and type safety 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Wed, 06 Dec 2006 10:20:10 +0000
Message-ID: <17534.1165400410@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Al Viro <viro@ftp.linux.org.uk> wrote:

> Guys, please, look at actual users of that stuff.

I've been and looked at every single user of work_struct in the kernel (at
least, I think I have), and 99% of those just expect data to be the container
of the work_struct or a data structure linked to it.  I had to come up with a
way to deal with cases where data is something from which you can't derive
from the work_struct address, but I'm not sure how best to do that for timers.

I haven't, however, been and looked at timers, so I can't say what actually
applies there.

David
