Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264795AbUG2RNx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264795AbUG2RNx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 13:13:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264299AbUG2RLw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 13:11:52 -0400
Received: from holomorphy.com ([207.189.100.168]:27029 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S264791AbUG2RKw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 13:10:52 -0400
Date: Thu, 29 Jul 2004 10:10:37 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Avi Kivity <avi@exanet.com>
Cc: jmoyer@redhat.com, suparna@in.ibm.com, linux-aio@kvack.org,
       linux-kernel@vger.kernel.org, linux-osdl@osdl.org
Subject: Re: [PATCH 20/22] AIO poll
Message-ID: <20040729171037.GS2334@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Avi Kivity <avi@exanet.com>, jmoyer@redhat.com, suparna@in.ibm.com,
	linux-aio@kvack.org, linux-kernel@vger.kernel.org,
	linux-osdl@osdl.org
References: <20040702130030.GA4256@in.ibm.com> <20040702163946.GJ3450@in.ibm.com> <16649.5485.651481.534569@segfault.boston.redhat.com> <41091FAA.6080409@exanet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41091FAA.6080409@exanet.com>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Moyer wrote:
>> What are the barriers to getting the AIO poll support into the kernel?  I
>> think if we have AIO support at all, it makes sense to add this.

On Thu, Jul 29, 2004 at 07:02:50PM +0300, Avi Kivity wrote:
> I second the motion. I don't see how one can write a server which uses 
> both networking and block aio without aio poll.

I just did it for OLS. The answer is busywait. i.e. 100% cpu. This is
because you can't use timeouts unless they're unified.


-- wli
