Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318542AbSHUSLz>; Wed, 21 Aug 2002 14:11:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318546AbSHUSLz>; Wed, 21 Aug 2002 14:11:55 -0400
Received: from to-velocet.redhat.com ([216.138.202.10]:56560 "EHLO
	touchme.toronto.redhat.com") by vger.kernel.org with ESMTP
	id <S318542AbSHUSLy>; Wed, 21 Aug 2002 14:11:54 -0400
Date: Wed, 21 Aug 2002 14:16:01 -0400
From: Benjamin LaHaise <bcrl@redhat.com>
To: Mala Anand <manand@us.ibm.com>
Cc: alan@lxorguk.ukuu.org.uk, Bill Hartner <bhartner@us.ibm.com>,
       davem@redhat.com, linux-kernel@vger.kernel.org,
       lse-tech@lists.sourceforge.net
Subject: Re: (RFC): SKB Initialization
Message-ID: <20020821141601.F8001@redhat.com>
References: <OF874EB8CD.B30B589E-ON87256C1C.00634F29@boulder.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <OF874EB8CD.B30B589E-ON87256C1C.00634F29@boulder.ibm.com>; from manand@us.ibm.com on Wed, Aug 21, 2002 at 01:07:09PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 21, 2002 at 01:07:09PM -0500, Mala Anand wrote:
> 
> >On Wed, Aug 21, 2002 at 11:59:44AM -0500, Mala Anand wrote:
> >> The patch reduces the numer of cylces by 25%
> 
> >The data you are reporting is flawed: where are the average cycle
> >times spent in __kfree_skb with the patch?
> 
> I measured the cycles for only the initialization code in alloc_skb
> and __kfree_skb. Since the init code is removed from __kfree_skb,
> no cycles are spent there.

Then the testing technique is flawed.  You should include all of the 
operations included in an alloc_skb/kfree_skb pair in order to see 
the overall effect of the change, otherwise your change could have a 
net negative effect which would not be noticed.

		-ben
-- 
"You will be reincarnated as a toad; and you will be much happier."
