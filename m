Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267197AbUHDB5E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267197AbUHDB5E (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Aug 2004 21:57:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267194AbUHDB5E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Aug 2004 21:57:04 -0400
Received: from holomorphy.com ([207.189.100.168]:40120 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S267197AbUHDB47 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Aug 2004 21:56:59 -0400
Date: Tue, 3 Aug 2004 18:56:54 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Rik van Riel <riel@redhat.com>, Chris Wright <chrisw@osdl.org>,
       Arjan van de Ven <arjanv@redhat.com>, linux-kernel@vger.kernel.org,
       akpm@osdl.org
Subject: Re: [patch] mlock-as-nonroot revisted
Message-ID: <20040804015654.GH2334@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrea Arcangeli <andrea@suse.de>, Rik van Riel <riel@redhat.com>,
	Chris Wright <chrisw@osdl.org>,
	Arjan van de Ven <arjanv@redhat.com>, linux-kernel@vger.kernel.org,
	akpm@osdl.org
References: <20040803212231.GJ2241@dualathlon.random> <Pine.LNX.4.44.0408031729100.5948-100000@dhcp83-102.boston.redhat.com> <20040803213942.GL2241@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040803213942.GL2241@dualathlon.random>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 03, 2004 at 05:31:08PM -0400, Rik van Riel wrote:
>> If root wants to screw over a user, there's nothing we
>> can do.  I am not worried about the scenario you describe
>> because hugetlbfs seems to be used only by Oracle anyway,
>> so you won't run into issues like you describe.

On Tue, Aug 03, 2004 at 11:39:42PM +0200, Andrea Arcangeli wrote:
> hugetlbfs isn't only used by oracle. Anyways if you were right then why
> is there a IPC_CAP_LOCK in hugetlbfs in the first place? If Oracle is
> the only user then just drop such check and stop binding rlimits to
> persistent fs objects.

Excellent. It appears the check for the ability to mlock is now
checking the amount of memory to be locked.


-- wli
