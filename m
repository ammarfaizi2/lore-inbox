Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753788AbWKFUdb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753788AbWKFUdb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 15:33:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753787AbWKFUdb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 15:33:31 -0500
Received: from mx1.redhat.com ([66.187.233.31]:34204 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1753782AbWKFUda (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 15:33:30 -0500
Date: Mon, 6 Nov 2006 15:22:33 -0500 (EST)
From: Jason Baron <jbaron@redhat.com>
X-X-Sender: jbaron@dhcp83-20.boston.redhat.com
To: Roland Dreier <rdreier@cisco.com>
cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       arjan@infradead.org
Subject: Re: locking hierarchy based on lockdep
In-Reply-To: <adapsc0l40x.fsf@cisco.com>
Message-ID: <Pine.LNX.4.64.0611061519220.29750@dhcp83-20.boston.redhat.com>
References: <Pine.LNX.4.64.0611061315380.29750@dhcp83-20.boston.redhat.com>
 <20061106200529.GA15370@elte.hu> <adapsc0l40x.fsf@cisco.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 6 Nov 2006, Roland Dreier wrote:

>  > i like your idea of using lockdep to document locking hierarchies.
> 
> Yes, it's definitely a cool idea.  I think the current implementation
> is not that useful, since it jams all the unrelated kernel locks into
> a single ordered list, when in fact many locks simply have no ordering
> relationship at all because they're never both taken.  This makes the
> list hard to read and in fact loses the information of which locks
> have been taken together.
> 
>  - R.
> 

interesting...perhaps if we layered say the directory structure on the 
list too like by the top level kernel directories drivers, kernel, mm, 
net, etc. it might be more readable.


