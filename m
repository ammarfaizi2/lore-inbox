Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263238AbTJBEuQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Oct 2003 00:50:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263240AbTJBEuQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Oct 2003 00:50:16 -0400
Received: from hockin.org ([66.35.79.110]:13573 "EHLO www.hockin.org")
	by vger.kernel.org with ESMTP id S263238AbTJBEuO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Oct 2003 00:50:14 -0400
Date: Wed, 1 Oct 2003 21:39:28 -0700
From: Tim Hockin <thockin@hockin.org>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Linus Torvalds <torvalds@osdl.org>, Pete Zaitcev <zaitcev@redhat.com>,
       braam@clusterfs.com,
       Linux Kernel mailing list <linux-kernel@vger.kernel.org>,
       davem@redhat.com, schwidefsky@de.ibm.com, davidm@hpl.hp.com
Subject: Re: [PATCH] Many groups patch.
Message-ID: <20031002043928.GA16534@hockin.org>
References: <Pine.LNX.4.44.0310011216530.24564-100000@home.osdl.org> <20031002022545.6FB7A2C0EA@lists.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031002022545.6FB7A2C0EA@lists.samba.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 02, 2003 at 12:09:19PM +1000, Rusty Russell wrote:
> > Augh. It also makes code even uglier than it used to be:
> 
> Sure.  First step is to put this function in kernel/compat.c where it
> belongs.  The identical function is already in kernel/uid16.c, but
> defining CONFIG_UID16 does not work for these platforms (which only
> want 16-bit uids for the 32-bit syscalls).
 

That works, I guess.  See my other message today (sorry, I forgot to CC: you
Rusty) with a different approach.  It makes uid16.c actually always be used.
