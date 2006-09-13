Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030472AbWIMBem@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030472AbWIMBem (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 21:34:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030478AbWIMBel
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 21:34:41 -0400
Received: from smtp-out.google.com ([216.239.45.12]:3706 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1030472AbWIMBel (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 21:34:41 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:subject:from:reply-to:to:cc:in-reply-to:references:
	content-type:organization:date:message-id:mime-version:x-mailer:content-transfer-encoding;
	b=AB1aaoVw9LBWyqcX56LKesAhqWDApH8tXDHkWr7ZbFFJW9lTpXx9NJwMjqmuV1OMg
	w2wFPEu0KyibskABMBO+Q==
Subject: Re: [ckrm-tech] [PATCH] BC: resource beancounters
	(v4)	(added	user	memory)
From: Rohit Seth <rohitseth@google.com>
Reply-To: rohitseth@google.com
To: sekharan@us.ibm.com
Cc: Rik van Riel <riel@redhat.com>, vatsa@in.ibm.com,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       CKRM-Tech <ckrm-tech@lists.sourceforge.net>, balbir@in.ibm.com,
       Dave Hansen <haveblue@us.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andi Kleen <ak@suse.de>, Christoph Hellwig <hch@infradead.org>,
       Andrey Savochkin <saw@sw.ru>, Matt Helsley <matthltc@us.ibm.com>,
       Hugh Dickins <hugh@veritas.com>, Alexey Dobriyan <adobriyan@mail.ru>,
       Kirill Korotaev <dev@sw.ru>, Oleg Nesterov <oleg@tv-sign.ru>,
       devel@openvz.org, Pavel Emelianov <xemul@openvz.org>
In-Reply-To: <1158109991.4800.43.camel@linuxchandra>
References: <44FD918A.7050501@sw.ru> <44FDAB81.5050608@in.ibm.com>
	 <44FEC7E4.7030708@sw.ru> <44FF1EE4.3060005@in.ibm.com>
	 <1157580371.31893.36.camel@linuxchandra> <45011CAC.2040502@openvz.org>
	 <1157743424.19884.65.camel@linuxchandra>
	 <1157751834.1214.112.camel@galaxy.corp.google.com>
	 <1157999107.6029.7.camel@linuxchandra>
	 <1158001831.12947.16.camel@galaxy.corp.google.com>
	 <20060912104410.GA28444@in.ibm.com>
	 <1158081752.20211.12.camel@galaxy.corp.google.com>
	 <1158105732.4800.26.camel@linuxchandra>
	 <1158108203.20211.52.camel@galaxy.corp.google.com>
	 <1158109991.4800.43.camel@linuxchandra>
Content-Type: text/plain
Organization: Google Inc
Date: Tue, 12 Sep 2006 18:33:38 -0700
Message-Id: <1158111218.20211.69.camel@galaxy.corp.google.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-09-12 at 18:13 -0700, Chandra Seetharaman wrote:
> On Tue, 2006-09-12 at 17:43 -0700, Rohit Seth wrote:
> <snip>
> 
> > > It won't be a complete solution, as the user won't be able to
> > >  - set both guarantee and limit for a resource group
> > >  - use limit on some and guarantee on some
> > >  - optimize the usage of available resources 
> > 
> > I think, if we have some of the dynamic resource limit adjustments
> > possible then some of the above functionality could be achieved. And I
> > think that could be a good start point.
> 
> 
> Yes, dynamic resource adjustments should be available. But, you can't
> expect the sysadmin to sit around and keep tweaking the limits so as to
> achieve the QoS he wants. (Even if you have an application sitting and
> doing it, as I pointed in other email it may not be possible for
> different scenarios).
> > 


As said earlier, if strict QoS is desired then system should be
appropriately partitioned so that the sum of limits doesn't exceed
physical limit (that is cost of QoS).  Let us first get at least that
much settled on and accepted in mainline before getting into these
esoteric features.

-rohit

