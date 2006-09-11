Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932067AbWIKKW2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932067AbWIKKW2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 06:22:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932136AbWIKKW1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 06:22:27 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:58308 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S932067AbWIKKW0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 06:22:26 -0400
Date: Mon, 11 Sep 2006 15:51:52 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: Pavel Emelianov <xemul@openvz.org>
Cc: balbir@in.ibm.com, Rik van Riel <riel@redhat.com>, sekharan@us.ibm.com,
       CKRM-Tech <ckrm-tech@lists.sourceforge.net>,
       Dave Hansen <haveblue@us.ibm.com>, Andi Kleen <ak@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Christoph Hellwig <hch@infradead.org>, Andrey Savochkin <saw@sw.ru>,
       devel@openvz.org, Matt Helsley <matthltc@us.ibm.com>,
       Hugh Dickins <hugh@veritas.com>, Alexey Dobriyan <adobriyan@mail.ru>,
       Kirill Korotaev <dev@sw.ru>, Oleg Nesterov <oleg@tv-sign.ru>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [ckrm-tech] [PATCH] BC: resource beancounters (v4) (added	user memory)
Message-ID: <20060911102152.GC17182@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <44FDAB81.5050608@in.ibm.com> <44FEC7E4.7030708@sw.ru> <44FF1EE4.3060005@in.ibm.com> <1157580371.31893.36.camel@linuxchandra> <45011CAC.2040502@openvz.org> <1157730221.26324.52.camel@localhost.localdomain> <4501B5F0.9050802@in.ibm.com> <450508BB.7020609@openvz.org> <4505161E.1040401@in.ibm.com> <45051AC7.2000607@openvz.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45051AC7.2000607@openvz.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 11, 2006 at 12:13:59PM +0400, Pavel Emelianov wrote:
> If I set up 9 groups to have 100Mb limit then I have 100Mb assured (on
> 1Gb node)
> for the 10th one exactly. And I do not have to set up any guarantee as
> it won't affect
> anything. So what a guarantee parameter is needed for?

I presume you are talking of hard-limiting each group to 100 MB here. In
which case, wont the 100MB (reserved for 10th group) be unutilized
untill 10th group is started (it may never be started for that matter!).

IMO it would be better to go and use that free 100 MB for reclaimable memory
and give that up when 10th group is started.


-- 
Regards,
vatsa
