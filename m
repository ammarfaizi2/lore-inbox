Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937058AbWLDQL3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937058AbWLDQL3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 11:11:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937059AbWLDQL3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 11:11:29 -0500
Received: from zrtps0kp.nortel.com ([47.140.192.56]:55689 "EHLO
	zrtps0kp.nortel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S937058AbWLDQL2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 11:11:28 -0500
Message-ID: <4574487F.7040805@nortel.com>
Date: Mon, 04 Dec 2006 10:10:39 -0600
From: "Chris Friesen" <cfriesen@nortel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.7) Gecko/20050427 Red Hat/1.7.7-1.1.3.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Aucoin@Houston.RR.com
CC: "'Kyle Moffett'" <mrmacman_g4@mac.com>,
       "'Tim Schmielau'" <tim@physik3.uni-rostock.de>,
       "'Andrew Morton'" <akpm@osdl.org>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, clameter@sgi.com
Subject: Re: la la la la ... swappiness
References: <200612041439.kB4EdGFn025092@ms-smtp-03.texas.rr.com>
In-Reply-To: <200612041439.kB4EdGFn025092@ms-smtp-03.texas.rr.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 04 Dec 2006 16:10:50.0906 (UTC) FILETIME=[C45DDFA0:01C717BE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Aucoin wrote:

> The definition of perfectly good here may be up for debate or
> someone can explain it to me. This perfectly good data was
> cached under the tar yet hours after the tar has completed the
> pages are still cached.

If nothing else has asked for that memory since the tar, there is no 
reason to evict the pages from the cache.  The inactive memory is 
basically "free, but still contains the previous data".

If anything asks for memory, those pages will be filled with zeros or 
the new information.  In the meantime, the kernel keeps them in the 
cache in case anyone wants the old information.

It doesn't hurt anything to keep the pages around with the old data in 
them--and it might help.

Chris
