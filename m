Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965071AbVLJIj0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965071AbVLJIj0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Dec 2005 03:39:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932778AbVLJIj0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Dec 2005 03:39:26 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:11795 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S932775AbVLJIj0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Dec 2005 03:39:26 -0500
Date: Sat, 10 Dec 2005 08:39:15 +0000
From: Pavel Machek <pavel@ucw.cz>
To: Matthew Dobson <colpatch@us.ibm.com>
Cc: Chris Wright <chrisw@osdl.org>, linux-kernel@vger.kernel.org,
       Linux Memory Management <linux-mm@kvack.org>
Subject: Re: [RFC][PATCH 0/8] Critical Page Pool
Message-ID: <20051210083915.GB2833@ucw.cz>
References: <437E2C69.4000708@us.ibm.com> <20051118195657.GI7991@shell0.pdx.osdl.net> <43815F64.4070502@us.ibm.com> <20051121132910.GA1971@elf.ucw.cz> <439616B6.1020308@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <439616B6.1020308@us.ibm.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > ...and then you find out that your test was not "bad enough" or that
> > it needs more memory on different machines. It may be good enough hack
> > for your usage, but I do not think it belongs in mainline.
> > 								Pavel
> 
> Way late in responding to this, but...
> 
> Apropriate sizing of this pool is a known issue.  For example, we want to
> use it to keep the networking stack alive during extreme memory pressure
> situations.  The only way to size the pool so as to *guarantee* that it
> will not be exhausted during the 2 minute window we need would be to ensure
> that the pool has at least (TOTAL_BANDWITH_OF_ALL_NICS * 120 seconds) bytes
> available.  In the case of a simple system with a single GigE adapter we'd
> need (1 gigbit/sec * 120 sec) = 120 gigabits = 15 gigabytes of reserve
> pool.  That is obviously completely impractical, considering many boxes

And it is not enough... If someone hits you with small packets,
allocation overhead is going to be high.
							Pavel
-- 
Thanks, Sharp!
