Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424330AbWLBSZH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424330AbWLBSZH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Dec 2006 13:25:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424332AbWLBSZG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Dec 2006 13:25:06 -0500
Received: from www.osadl.org ([213.239.205.134]:41345 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1424330AbWLBSZD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Dec 2006 13:25:03 -0500
Subject: Re: [RFC] timers, pointers to functions and type safety
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Al Viro <viro@ftp.linux.org.uk>
Cc: Matthew Wilcox <matthew@wil.cx>, Linus Torvalds <torvalds@osdl.org>,
       linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20061202181957.GK3078@ftp.linux.org.uk>
References: <20061201172149.GC3078@ftp.linux.org.uk>
	 <1165064370.24604.36.camel@localhost.localdomain>
	 <20061202140521.GJ3078@ftp.linux.org.uk>
	 <1165070713.24604.50.camel@localhost.localdomain>
	 <20061202160252.GQ14076@parisc-linux.org>
	 <1165082803.24604.54.camel@localhost.localdomain>
	 <20061202181957.GK3078@ftp.linux.org.uk>
Content-Type: text/plain
Date: Sat, 02 Dec 2006 19:27:56 +0100
Message-Id: <1165084076.24604.56.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-12-02 at 18:19 +0000, Al Viro wrote:
> > This is going to make a lot of data structures smaller, when the
> > timer_list is embedded in the structure itself and for the lot, which
> > ignores the timer callback argument anyway.
> 
> container_of => still lousy type safety.  All over the sodding place.

Not less than timer->data, where timer data is void *

	tglx


