Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030212AbWILRX7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030212AbWILRX7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 13:23:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030221AbWILRX7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 13:23:59 -0400
Received: from smtp-out.google.com ([216.239.45.12]:5340 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1030212AbWILRX5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 13:23:57 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:subject:from:reply-to:to:cc:in-reply-to:references:
	content-type:organization:date:message-id:mime-version:x-mailer:content-transfer-encoding;
	b=uCKSVXnODIqaWxUnNz7eTKK6pBBq/Bi77QQijlWopfaLqaLfpU7VSPguhOXrwlMmP
	yVxFPo6FiyX73u7lzw7QA==
Subject: Re: [ckrm-tech] [PATCH] BC: resource beancounters (v4) (added
	user	memory)
From: Rohit Seth <rohitseth@google.com>
Reply-To: rohitseth@google.com
To: vatsa@in.ibm.com
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
In-Reply-To: <20060912104410.GA28444@in.ibm.com>
References: <44FD918A.7050501@sw.ru> <44FDAB81.5050608@in.ibm.com>
	 <44FEC7E4.7030708@sw.ru> <44FF1EE4.3060005@in.ibm.com>
	 <1157580371.31893.36.camel@linuxchandra> <45011CAC.2040502@openvz.org>
	 <1157743424.19884.65.camel@linuxchandra>
	 <1157751834.1214.112.camel@galaxy.corp.google.com>
	 <1157999107.6029.7.camel@linuxchandra>
	 <1158001831.12947.16.camel@galaxy.corp.google.com>
	 <20060912104410.GA28444@in.ibm.com>
Content-Type: text/plain
Organization: Google Inc
Date: Tue, 12 Sep 2006 10:22:32 -0700
Message-Id: <1158081752.20211.12.camel@galaxy.corp.google.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-09-12 at 16:14 +0530, Srivatsa Vaddagiri wrote:
> On Mon, Sep 11, 2006 at 12:10:31PM -0700, Rohit Seth wrote:
> > It seems that a single notion of limit should suffice, and that limit
> > should more be treated as something beyond which that resource
> > consumption in the container will be throttled/not_allowed.
> 
> The big question is : are containers/RG allowed to use *upto* their
> limit always? In other words, will you typically setup limits such that
> sum of all limits = max resource capacity? 
> 

If a user is really interested in ensuring that all scheduled jobs (or
containers) get what they have asked for (guarantees) then making the
sum of all container limits equal to total system limit is the right
thing to do.

> If it is setup like that, then what you are considering as limit is
> actually guar no?
> 
Right.  And if we do it like this then it is up to sysadmin to configure
the thing right without adding additional logic in kernel.

-rohit


