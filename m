Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261945AbTHYQJt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Aug 2003 12:09:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261950AbTHYQJt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Aug 2003 12:09:49 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:22249 "EHLO
	mtvmime01.veritas.com") by vger.kernel.org with ESMTP
	id S261945AbTHYQJs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Aug 2003 12:09:48 -0400
Date: Mon, 25 Aug 2003 17:11:29 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Paul Larson <plars@linuxtestproject.org>
cc: lkml <linux-kernel@vger.kernel.org>,
       ltp-results <ltp-results@lists.sourceforge.net>, <linstab@osdl.org>
Subject: Re: LTP nightly regression results for 2.6.0-test3-bk2,bk3,bk5,bk6,bk7,mm3,mjb1
In-Reply-To: <1061415052.3909.1733.camel@plars>
Message-ID: <Pine.LNX.4.44.0308251656500.1322-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 20 Aug 2003, Paul Larson wrote:
> 
> Here's the latest batch of LTP test results for the latest 2.6 bk
> snapshots and mm/mjb trees.  These results and previous results are
> archived at: http://developer.osdl.org/dev/ltp/results/
>....
> swapoff01      FAIL               FAIL                    N            N
> swapoff02      FAIL               FAIL                    N            N

Paul, I've not been able to reproduce those swapoff failures.
Your ltp.outs indicate that it was the swapon which failed,
but its error code is not shown; nor the tmpfile outputs from
setup's system(3) calls (if I remember rightly, system succeeds
if it can run what's asked, whether what it runs fails or not).
Please try running a swapoff01 and swapoff02 modified to catch
that info: it may quickly identify the issue.

Hugh

