Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932214AbVJ3AkP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932214AbVJ3AkP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Oct 2005 20:40:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932213AbVJ3AkO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Oct 2005 20:40:14 -0400
Received: from smtp206.mail.sc5.yahoo.com ([216.136.129.96]:17298 "HELO
	smtp206.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S932207AbVJ3AkN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Oct 2005 20:40:13 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:Subject:Content-Type:Content-Transfer-Encoding;
  b=alwUMaNb+uSiDbfG6fKfNmFvfQR6XPJooo+PCrlCwk5bys+Jxq8rHGhcpTHalXJX92b7JoOATUMwZ/sJwCuF5/Css+4hoy3/H8JjrW+ARmeI/1HrSTRG1VcTTDUEgdy3TvdaLjnx3pMKbgvFCFg9V1+BrNFhErDDQ7xuSvKc638=  ;
Message-ID: <436416AD.3050709@yahoo.com.au>
Date: Sun, 30 Oct 2005 11:41:17 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [patches] lockless pagecache prep round 1
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi List,

Following this are some prep patches from my lockless pagecache
patch stack, though they are nice patches that stand by themselves.
I would be interested in getting them merged soon, they have
survived quite a lot of stress testing here. Reviews and Acks from
interested parties would be helpful.

First is the generic atomic_cmpxchg stuff. These are really useful
primitives to have in general as can be seen by their subsequent
application. I've tried to do lots of compile testing, but if this
causes failures, then it is exposing bugs already in the code that
need fixing.

Second is some radix tree improvements and cleanups. This patchset
does introduce an "unused" radix tree API (lookup_slot), however
I thought it was appropriate to include this patch here because
there seem to be a number of users interested in this functionality
(lockless pagecache, reiser4, adaptive readahead), and I don't want
to see 3 different implementations!

Thanks,
Nick

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
