Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030195AbWILKor@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030195AbWILKor (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 06:44:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030196AbWILKor
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 06:44:47 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:65208 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1030195AbWILKoq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 06:44:46 -0400
Date: Tue, 12 Sep 2006 16:14:10 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: Rohit Seth <rohitseth@google.com>
Cc: sekharan@us.ibm.com, Rik van Riel <riel@redhat.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       CKRM-Tech <ckrm-tech@lists.sourceforge.net>, balbir@in.ibm.com,
       Dave Hansen <haveblue@us.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andi Kleen <ak@suse.de>, Christoph Hellwig <hch@infradead.org>,
       Andrey Savochkin <saw@sw.ru>, Matt Helsley <matthltc@us.ibm.com>,
       Hugh Dickins <hugh@veritas.com>, Alexey Dobriyan <adobriyan@mail.ru>,
       Kirill Korotaev <dev@sw.ru>, Oleg Nesterov <oleg@tv-sign.ru>,
       devel@openvz.org, Pavel Emelianov <xemul@openvz.org>
Subject: Re: [ckrm-tech] [PATCH] BC: resource beancounters (v4) (added user	memory)
Message-ID: <20060912104410.GA28444@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <44FD918A.7050501@sw.ru> <44FDAB81.5050608@in.ibm.com> <44FEC7E4.7030708@sw.ru> <44FF1EE4.3060005@in.ibm.com> <1157580371.31893.36.camel@linuxchandra> <45011CAC.2040502@openvz.org> <1157743424.19884.65.camel@linuxchandra> <1157751834.1214.112.camel@galaxy.corp.google.com> <1157999107.6029.7.camel@linuxchandra> <1158001831.12947.16.camel@galaxy.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1158001831.12947.16.camel@galaxy.corp.google.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 11, 2006 at 12:10:31PM -0700, Rohit Seth wrote:
> It seems that a single notion of limit should suffice, and that limit
> should more be treated as something beyond which that resource
> consumption in the container will be throttled/not_allowed.

The big question is : are containers/RG allowed to use *upto* their
limit always? In other words, will you typically setup limits such that
sum of all limits = max resource capacity? 

If it is setup like that, then what you are considering as limit is
actually guar no?

If it wont be setup like that, then I dont see how one can provide QoS.

-- 
Regards,
vatsa
