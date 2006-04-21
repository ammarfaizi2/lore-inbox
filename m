Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750960AbWDUSlg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750960AbWDUSlg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 14:41:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751296AbWDUSlg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 14:41:36 -0400
Received: from smtp104.mail.mud.yahoo.com ([209.191.85.214]:27267 "HELO
	smtp104.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750960AbWDUSlf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 14:41:35 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=C7cDzgJADuko0P/5lGZOLTAD1mYVkFzfTcfKWybKnfZt1SJ+G4QZLwZJYEmyyAC2HkVQBsVqsgG6HK9uORsyqKwsFM0Qe9HjlbaBYX1yp4pzCxO2oMHJ0EVRyPNEMDNqXAM0/fQ6pycUFADOT11belTqEMN5ZCORTYGA/p6/pu0=  ;
Message-ID: <4448D8BF.9040601@yahoo.com.au>
Date: Fri, 21 Apr 2006 23:06:07 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: David Woodhouse <dwmw2@infradead.org>
CC: akpm@osdl.org, andrea@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Shrink rbtree
References: <1145623663.11909.139.camel@pmac.infradead.org>
In-Reply-To: <1145623663.11909.139.camel@pmac.infradead.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

Doesn't seem like a bad idea...

David Woodhouse wrote:
> Our rbtree implementation uses a whole integer for colour information.
> In fact, because of alignment constraints on a 64-bit machine it'll be a
> whole 64 bits there. We only need a single bit, though -- and we know
> the pointers are always going to be aligned. So let's just use the

How do we know the pointers are always going to be aligned? IIRC
struct address_space needed to be explicitly aligned when doing
this trick in page->mapping because some platform byte aligned it.

Nick

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
