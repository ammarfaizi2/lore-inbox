Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964977AbWHQNlg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964977AbWHQNlg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 09:41:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964982AbWHQNld
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 09:41:33 -0400
Received: from mailhub.sw.ru ([195.214.233.200]:51567 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S964978AbWHQNk4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 09:40:56 -0400
Message-ID: <44E47274.70506@sw.ru>
Date: Thu, 17 Aug 2006 17:43:16 +0400
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.13) Gecko/20060417
X-Accept-Language: en-us, en, ru
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Ingo Molnar <mingo@elte.hu>,
       Christoph Hellwig <hch@infradead.org>,
       Pavel Emelianov <xemul@openvz.org>, Andrey Savochkin <saw@sw.ru>,
       devel@openvz.org, Rik van Riel <riel@redhat.com>, hugh@veritas.com,
       ckrm-tech@lists.sourceforge.net, Andi Kleen <ak@suse.de>
Subject: Re: [RFC][PATCH 7/7] UBC: proc interface
References: <44E33893.6020700@sw.ru> <44E33D5E.7000205@sw.ru> <20060816171328.GA27898@kroah.com>
In-Reply-To: <20060816171328.GA27898@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Wed, Aug 16, 2006 at 07:44:30PM +0400, Kirill Korotaev wrote:
> 
>>Add proc interface (/proc/user_beancounters) allowing to see current
>>state (usage/limits/fails for each UB). Implemented via seq files.
> 
> 
> Ugh, why /proc?  This doesn't have anything to do with processes, just
> users, right?  What's wrong with /sys/kernel/ instead?
We can move it, if there are much objections.
It is just here for more than 3 years (AFAIK starting from Alan's UBC)
and would be nice to have for compatibility (at least with existing OpenVZ).
But if it is required -- will do.

> Or /sys/kernel/debug/user_beancounters/ in debugfs as this is just a
> debugging thing, right?
debugfs is usually OFF imho. you don't export meminfo information in debugfs,
correct? user usages are the same imho...

Kirill
