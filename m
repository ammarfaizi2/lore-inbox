Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161001AbWCWVCO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161001AbWCWVCO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 16:02:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161005AbWCWVCO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 16:02:14 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:30095 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1161003AbWCWVCN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 16:02:13 -0500
Date: Thu, 23 Mar 2006 21:02:08 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Linus Torvalds <torvalds@osdl.org>, vgoyal@in.ibm.com,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Fastboot mailing list <fastboot@lists.osdl.org>,
       Morton Andrew Morton <akpm@osdl.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>, galak@kernel.crashing.org,
       gregkh@suse.de, bcrl@kvack.org, Dave Jiang <dave.jiang@gmail.com>,
       Maneesh Soni <maneesh@in.ibm.com>, Murali <muralim@in.ibm.com>
Subject: Re: [RFC][PATCH 1/10] 64 bit resources core changes
Message-ID: <20060323210208.GQ27946@ftp.linux.org.uk>
References: <20060323195752.GD7175@in.ibm.com> <20060323195944.GE7175@in.ibm.com> <1143145335.3147.52.camel@laptopd505.fenrus.org> <Pine.LNX.4.64.0603231250410.26286@g5.osdl.org> <1143147419.3147.54.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1143147419.3147.54.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 23, 2006 at 09:56:59PM +0100, Arjan van de Ven wrote:
> On Thu, 2006-03-23 at 12:52 -0800, Linus Torvalds wrote:
> > 
> > On Thu, 23 Mar 2006, Arjan van de Ven wrote:
> > > 
> > > hmmmm are there any platforms where unsigned long long is > 64 bits?
> > > (and yes it would be nice if there was a u64 printf flag ;)
> > 
> > Adding a new printf flag is technically _trivial_.
> > 
> > The problem is getting gcc not to warn about it every time it sees it 
> > (while not losing the gcc format string checking entirely). Do newer gcc's 
> > allow some way of saying "this flag takes this type" for extended format 
> > definitions?
> 
> afaics there is none... even if there was a "just don't warn about this
> one" would be nice.. but I don't see that either.

-Wformat is what enables those, so we can turn them all off.
