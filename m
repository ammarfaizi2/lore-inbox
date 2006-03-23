Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964913AbWCWVBf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964913AbWCWVBf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 16:01:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964935AbWCWVBf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 16:01:35 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:58766 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S964913AbWCWVBe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 16:01:34 -0500
Date: Thu, 23 Mar 2006 21:01:28 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Arjan van de Ven <arjan@infradead.org>, vgoyal@in.ibm.com,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Fastboot mailing list <fastboot@lists.osdl.org>,
       Morton Andrew Morton <akpm@osdl.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>, galak@kernel.crashing.org,
       gregkh@suse.de, bcrl@kvack.org, Dave Jiang <dave.jiang@gmail.com>,
       Maneesh Soni <maneesh@in.ibm.com>, Murali <muralim@in.ibm.com>
Subject: Re: [RFC][PATCH 1/10] 64 bit resources core changes
Message-ID: <20060323210128.GP27946@ftp.linux.org.uk>
References: <20060323195752.GD7175@in.ibm.com> <20060323195944.GE7175@in.ibm.com> <1143145335.3147.52.camel@laptopd505.fenrus.org> <Pine.LNX.4.64.0603231250410.26286@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0603231250410.26286@g5.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 23, 2006 at 12:52:42PM -0800, Linus Torvalds wrote:
> 
> 
> On Thu, 23 Mar 2006, Arjan van de Ven wrote:
> > 
> > hmmmm are there any platforms where unsigned long long is > 64 bits?
> > (and yes it would be nice if there was a u64 printf flag ;)
> 
> Adding a new printf flag is technically _trivial_.
> 
> The problem is getting gcc not to warn about it every time it sees it 
> (while not losing the gcc format string checking entirely). Do newer gcc's 
> allow some way of saying "this flag takes this type" for extended format 
> definitions?

Well...  We could implement that in sparse and tell gcc to stop bothering
with that warning.  At which point it becomes trivial to extend...
