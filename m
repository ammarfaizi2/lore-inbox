Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264025AbRFFS4E>; Wed, 6 Jun 2001 14:56:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264048AbRFFSzy>; Wed, 6 Jun 2001 14:55:54 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:7724 "EHLO
	flinx.biederman.org") by vger.kernel.org with ESMTP
	id <S264025AbRFFSzs>; Wed, 6 Jun 2001 14:55:48 -0400
To: Derek Glidden <dglidden@illusionary.com>
Cc: linux-kernel@vger.kernel.org, <linux-mm@kvack.org>
Subject: Re: Break 2.4 VM in five easy steps
In-Reply-To: <3B1E4CD0.D16F58A8@illusionary.com>
	<3b204fe5.4014698@mail.mbay.net> <3B1E5316.F4B10172@illusionary.com>
	<m1wv6p5uqp.fsf@frodo.biederman.org>
	<3B1E7ABA.EECCBFE0@illusionary.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 06 Jun 2001 12:52:07 -0600
In-Reply-To: <3B1E7ABA.EECCBFE0@illusionary.com>
Message-ID: <m1ofs15tm0.fsf@frodo.biederman.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Derek Glidden <dglidden@illusionary.com> writes:


> The problem I reported is not that 2.4 uses huge amounts of swap but
> that trying to recover that swap off of disk under 2.4 can leave the
> machine in an entirely unresponsive state, while 2.2 handles identical
> situations gracefully.  
> 

The interesting thing from other reports is that it appears to be kswapd
using up CPU resources.  Not the swapout code at all.  So it appears
to be a fundamental VM issue.  And calling swapoff is just a good way
to trigger it. 

If you could confirm this by calling swapoff sometime other than at
reboot time.  That might help.  Say by running top on the console.

Eric



