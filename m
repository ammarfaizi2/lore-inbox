Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964781AbWHQJhQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964781AbWHQJhQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 05:37:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964783AbWHQJhP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 05:37:15 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:51392 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S964781AbWHQJhO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 05:37:14 -0400
Subject: Re: GPL Violation?
From: David Woodhouse <dwmw2@infradead.org>
To: Patrick McFarland <diablod3@gmail.com>
Cc: Anonymous User <anonymouslinuxuser@gmail.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <200608170242.40969.diablod3@gmail.com>
References: <40d80630608162248y498cb970r97a14c582fd663e1@mail.gmail.com>
	 <200608170242.40969.diablod3@gmail.com>
Content-Type: text/plain
Date: Thu, 17 Aug 2006 10:37:11 +0100
Message-Id: <1155807431.22871.157.camel@pmac.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.6.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-08-17 at 02:42 -0400, Patrick McFarland wrote:
> They don't have to release source code for any module you wrote from scratch 
> themselves, but said modules cannot say they are GPL (ie, they have to poison 
> the kernel). 

If you're distributing a product which contains both the kernel and some
modules, then there is a more important (or at least a more clear-cut)
caveat to bear in mind than the question of whether the module in itself
is a derived work.

Read section 2 of the GPL carefully:

	"These requirements apply to the modified work as a whole.  If
	identifiable sections of that work are not derived from the
	Program, and can be reasonably considered independent and
	separate works in themselves, then this License, and its terms,
	do not apply to those sections when you distribute them as
	separate works."

That's what Patrick is referring to, presumably, (and he's assuming that
your module would _not_ be derived from the kernel, which many people
are already disputing).

However, do not let that debate distract you from the fact that the GPL
continues as follows:

	"But when you distribute the same sections as part of a whole
	which is a work based on the Program, the distribution of the
	whole must be on the terms of this License, whose permissions
	for other licensees extend to the ENTIRE WHOLE, and thus to EACH
	AND EVERY PART REGARDLESS OF WHO WROTE IT."

So when you distribute a product which combines the kernel and some
driver module, and which isn't 'mere aggregation on a storage medium'
but is actually a coherent whole which works together and wouldn't
function correctly if either the kernel or the module were missing, then
your module _must_ be released under the terms of the GPL too.

This is entirely separate to the question of whether the module should
be considered a derived work in itself -- if we consider the module a
derived work (as I personally do), then of course you must release the
module's source under the terms of the GPL, whatever happens.

But _even_ if GregKH, Arjan and all of IBM's lawyers are wrong and we
don't consider the module a derived work, then you may release the
module without source _only_ if you do so on its _own_ ("as separate
works"), and not as part of a product which also contains a Linux
kernel.

-- 
dwmw2

