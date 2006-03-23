Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964935AbWCWVHa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964935AbWCWVHa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 16:07:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964937AbWCWVHa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 16:07:30 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:48571 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S964935AbWCWVH3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 16:07:29 -0500
Subject: Re: [RFC][PATCH 1/10] 64 bit resources core changes
From: Arjan van de Ven <arjan@infradead.org>
To: Al Viro <viro@ftp.linux.org.uk>
Cc: Linus Torvalds <torvalds@osdl.org>, vgoyal@in.ibm.com,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Fastboot mailing list <fastboot@lists.osdl.org>,
       Morton Andrew Morton <akpm@osdl.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>, galak@kernel.crashing.org,
       gregkh@suse.de, bcrl@kvack.org, Dave Jiang <dave.jiang@gmail.com>,
       Maneesh Soni <maneesh@in.ibm.com>, Murali <muralim@in.ibm.com>
In-Reply-To: <20060323210208.GQ27946@ftp.linux.org.uk>
References: <20060323195752.GD7175@in.ibm.com>
	 <20060323195944.GE7175@in.ibm.com>
	 <1143145335.3147.52.camel@laptopd505.fenrus.org>
	 <Pine.LNX.4.64.0603231250410.26286@g5.osdl.org>
	 <1143147419.3147.54.camel@laptopd505.fenrus.org>
	 <20060323210208.GQ27946@ftp.linux.org.uk>
Content-Type: text/plain
Date: Thu, 23 Mar 2006 22:07:19 +0100
Message-Id: <1143148039.3147.56.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-03-23 at 21:02 +0000, Al Viro wrote:
> On Thu, Mar 23, 2006 at 09:56:59PM +0100, Arjan van de Ven wrote:
> > On Thu, 2006-03-23 at 12:52 -0800, Linus Torvalds wrote:
> > > 
> > > On Thu, 23 Mar 2006, Arjan van de Ven wrote:
> > > > 
> > > > hmmmm are there any platforms where unsigned long long is > 64 bits?
> > > > (and yes it would be nice if there was a u64 printf flag ;)
> > > 
> > > Adding a new printf flag is technically _trivial_.
> > > 
> > > The problem is getting gcc not to warn about it every time it sees it 
> > > (while not losing the gcc format string checking entirely). Do newer gcc's 
> > > allow some way of saying "this flag takes this type" for extended format 
> > > definitions?
> > 
> > afaics there is none... even if there was a "just don't warn about this
> > one" would be nice.. but I don't see that either.
> 
> -Wformat is what enables those, so we can turn them all off.

sure it's all or nothing. not "all but the u64 one"

