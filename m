Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319760AbSIMTww>; Fri, 13 Sep 2002 15:52:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319763AbSIMTww>; Fri, 13 Sep 2002 15:52:52 -0400
Received: from to-velocet.redhat.com ([216.138.202.10]:57593 "EHLO
	touchme.toronto.redhat.com") by vger.kernel.org with ESMTP
	id <S319760AbSIMTww>; Fri, 13 Sep 2002 15:52:52 -0400
Date: Fri, 13 Sep 2002 15:57:44 -0400
From: Benjamin LaHaise <bcrl@redhat.com>
To: Andrew Morton <akpm@digeo.com>
Cc: Jens Axboe <axboe@suse.de>, Suparna Bhattacharya <suparna@in.ibm.com>,
       Shailabh Nagar <nagar@watson.ibm.com>, Linux Aio <linux-aio@kvack.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5 port of aio-20020619 for raw devices
Message-ID: <20020913155744.C2969@redhat.com>
References: <3D80DB14.2040809@watson.ibm.com> <20020912143540.J18217@redhat.com> <20020913184652.C2758@in.ibm.com> <20020913134404.GG935@suse.de> <3D823DCC.3E303941@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3D823DCC.3E303941@digeo.com>; from akpm@digeo.com on Fri, Sep 13, 2002 at 12:34:36PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 13, 2002 at 12:34:36PM -0700, Andrew Morton wrote:
> It has the disadvantage that we may have some data which is mergeable,
> and would in fact nonblockingly fit into a "congested" queue.  Don't
> know if that makes a lot of difference in practice.

That's what I was thinking.  Not having a congested queue really breaks 
aio as your submit point is not supposed to incur significant latency: an 
io should -EAGAIN if it would cost a large delay to setup.

		-ben
-- 
"You will be reincarnated as a toad; and you will be much happier."
