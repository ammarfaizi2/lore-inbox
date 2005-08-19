Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932477AbVHSIek@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932477AbVHSIek (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Aug 2005 04:34:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932487AbVHSIek
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Aug 2005 04:34:40 -0400
Received: from mail.fh-wedel.de ([213.39.232.198]:22144 "EHLO
	moskovskaya.fh-wedel.de") by vger.kernel.org with ESMTP
	id S932477AbVHSIej (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Aug 2005 04:34:39 -0400
Date: Fri, 19 Aug 2005 10:33:32 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: dean gaudet <dean-list-linux-kernel@arctic.org>
Cc: Folkert van Heusden <folkert@vanheusden.com>, linux-kernel@vger.kernel.org
Subject: Re: zero-copy read() interface
Message-ID: <20050819083332.GC29333@wohnheim.fh-wedel.de>
References: <20050818100151.GF12313@vanheusden.com> <20050818100536.GB16751@wohnheim.fh-wedel.de> <20050818104131.GH12313@vanheusden.com> <Pine.LNX.4.63.0508181633510.20705@twinlark.arctic.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.63.0508181633510.20705@twinlark.arctic.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 August 2005 16:34:18 -0700, dean gaudet wrote:
> On Thu, 18 Aug 2005, Folkert van Heusden wrote:
> 
> > Doesn't that one also use copying? I've also heard that using mmap is
> > expensive due to pagefaulting. I've found, for example, that copying a
> > 1.3GB file using read/write instead of mmap & memcpy is seconds faster.
> 
> why would you memcpy if you're using mmap()?  just write() the mmap()d 
> region.

Still unnecessary.  Userspace doesn't want to see the data at all, so
it shouldn't.  The solution should either be sendfile(2), which Linus
doesn't like much, or the upcoming pipe stuff.

Jörn

-- 
Linux [...] existed just for discussion between people who wanted
to show off how geeky they were.
-- Rob Enderle
