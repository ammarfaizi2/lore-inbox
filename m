Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267737AbUJMIih@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267737AbUJMIih (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Oct 2004 04:38:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267746AbUJMIih
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Oct 2004 04:38:37 -0400
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:33261 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S267737AbUJMIif (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Oct 2004 04:38:35 -0400
Date: Wed, 13 Oct 2004 17:44:10 +0900
From: Hiroyuki KAMEZAWA <kamezawa.hiroyu@jp.fujitsu.com>
Subject: Re: bug in 2.6.9-rc4-mm1 ia64/mm/init.c
In-reply-to: <16748.57721.66330.638048@napali.hpl.hp.com>
To: davidm@hpl.hp.com
Cc: akepner@sgi.com, linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org,
       akpm@osdl.org, jbarnes@sgi.com
Message-id: <416CEADA.2060207@jp.fujitsu.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7bit
X-Accept-Language: en-us, en
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.7.3)
 Gecko/20040910
References: <Pine.LNX.4.33.0410121705510.31839-100000@localhost.localdomain>
 <16748.57721.66330.638048@napali.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Mosberger wrote:

> Why was this patch even accepted?  It seemed rather dubious to me and
> I don't recall much discussion on its merits or safety.
> 
> 	--david

At first, that patch it is not essential to no-bitmap-buddy patch, and removing
it is okay. It seems that test and discussion are not enough now.

Since I heared that all of the pages in a granule on ia64 are guaranteed to exist,
I included that in no-bitmap-buddy-patch.
(when pagesize=16k/granule=16M,I think this has no effect.)

My purpose was to reduce # of page fault when ia64_pfn_valid() is called.
It is called heavily in bad_range() (in mm/page_alloc.c) now.


Kame <kamezawa.hiroyu@jp.fujitsu.com>




