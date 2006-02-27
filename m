Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750838AbWB0J2t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750838AbWB0J2t (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 04:28:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750852AbWB0J2t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 04:28:49 -0500
Received: from smtp108.mail.mud.yahoo.com ([209.191.85.218]:55462 "HELO
	smtp108.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750838AbWB0J2s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 04:28:48 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=DXnFGcKQHaqWwbOr9yRc2uGfTnFNOVWt2VYYmLbgSNHsiNJGHu6/fZsQ0JvaGMrWPt3l7mcge+vlXCSj13oNNrTWTs/H7Av5qyCj0PK+nPdQ9v7ANnXFB3EQVJd650snG9thwFlHl+zYOSdmRur2JodYfOPjYaCkg5BzsrxQQJY=  ;
Message-ID: <4402C650.7070502@yahoo.com.au>
Date: Mon, 27 Feb 2006 20:28:48 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Dave Jones <davej@redhat.com>
CC: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.6.16-rc5
References: <Pine.LNX.4.64.0602262122000.22647@g5.osdl.org> <20060227074211.GB15638@redhat.com>
In-Reply-To: <20060227074211.GB15638@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones wrote:

> Those brave Fedora-rawhide testers have also hit an assortment of slab
> related errors recently, manifesting in various ways including our old
> friend the negative page_mapcount.
> 
> (From a 2.6.16rc4-git6 based kernel ...)
> https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=182593
> 

 From that report, the page flags indicate that the page is regular
old pagecache. I'd be very surprised if there is a mapcount bug here.

It looks like something is scribbling in memory, which I would
suspect first.

However if you do see new mm/rmap bugs, do keep posting them so we
can see if there is a pattern.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
