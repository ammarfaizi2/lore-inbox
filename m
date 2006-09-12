Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932188AbWILME7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932188AbWILME7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 08:04:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932260AbWILME7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 08:04:59 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:37329 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932188AbWILME6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 08:04:58 -0400
Date: Tue, 12 Sep 2006 17:34:07 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: Pavel Emelianov <xemul@openvz.org>
Cc: Rik van Riel <riel@redhat.com>, sekharan@us.ibm.com,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       CKRM-Tech <ckrm-tech@lists.sourceforge.net>,
       Dave Hansen <haveblue@us.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andi Kleen <ak@suse.de>, Christoph Hellwig <hch@infradead.org>,
       Andrey Savochkin <saw@sw.ru>, Matt Helsley <matthltc@us.ibm.com>,
       Hugh Dickins <hugh@veritas.com>, Alexey Dobriyan <adobriyan@mail.ru>,
       Kirill Korotaev <dev@sw.ru>, Oleg Nesterov <oleg@tv-sign.ru>,
       devel@openvz.org
Subject: Re: [ckrm-tech] [PATCH] BC: resource beancounters (v4) (added user memory)
Message-ID: <20060912120407.GA28959@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <1157579641.31893.26.camel@linuxchandra> <44FFCA4D.9090202@openvz.org> <1157656616.19884.34.camel@linuxchandra> <45011A47.1020407@openvz.org> <1157742442.19884.47.camel@linuxchandra> <450509EE.9010809@openvz.org> <20060911130428.GA16404@in.ibm.com> <45068AD9.50308@openvz.org> <20060912102943.GA28128@in.ibm.com> <450694BB.3060304@openvz.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <450694BB.3060304@openvz.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2006 at 03:06:35PM +0400, Pavel Emelianov wrote:
> Hmmm... Beancounters can provide this after trivial changes.

All that is needed is some interface to set a thread's BC id (which you
seem to have already - sys_set_bcid)

> We may schedule them in current set of "pending" features
> (http://wiki.openvz.org/UBC_discussion)
> 
> But this can create a kind of DoS within an application:
>   A thread continuously touches new and new pages to it's BC and
> these pages are get touched by other threads also. Sooner or later

Any good reason why threads will touch each other's working set?
Sure nothing prevents them from touching, but I would expect each thread
(serving a separate domain) to work on its own set of private pages?

> this BC will hit it's limit and reclaiming this set of pages would affect
> all the other threads.

-- 
Regards,
vatsa
