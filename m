Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263199AbTEVT6j (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 May 2003 15:58:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263201AbTEVT6j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 May 2003 15:58:39 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:55498 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S263199AbTEVT6i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 May 2003 15:58:38 -0400
Date: Thu, 22 May 2003 13:14:34 -0700
From: Andrew Morton <akpm@digeo.com>
To: Paul Larson <plars@linuxtestproject.org>
Cc: felipe_alfaro@linuxmail.org, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: 2.5.69-mm8
Message-Id: <20030522131434.710a0c7d.akpm@digeo.com>
In-Reply-To: <1053631843.2648.3248.camel@plars>
References: <20030522021652.6601ed2b.akpm@digeo.com>
	<1053629620.596.1.camel@teapot.felipe-alfaro.com>
	<1053631843.2648.3248.camel@plars>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 22 May 2003 20:11:43.0085 (UTC) FILETIME=[5CD461D0:01C3209E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Larson <plars@linuxtestproject.org> wrote:
>
> 2.5.69-mm8 is bleeding for me. :)  See bugs #738 and #739.

#739 seems to be the b_committed_data race.  Alex is cooking up a fix for
that.  Sorry, I didn't realise it was that easy to trigger.

I'm fairly amazed about #738.  The asertion at fs/jbd/transaction.c:2023
(J_ASSERT_JH(jh, kernel_locked())) is bogus and should be removed.
