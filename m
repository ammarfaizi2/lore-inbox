Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265040AbUGMNEw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265040AbUGMNEw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jul 2004 09:04:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265051AbUGMNEw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jul 2004 09:04:52 -0400
Received: from holomorphy.com ([207.189.100.168]:3477 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S265040AbUGMNEu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jul 2004 09:04:50 -0400
Date: Tue, 13 Jul 2004 06:04:48 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: preempt-timing-2.6.8-rc1
Message-ID: <20040713130448.GB21066@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Nick Piggin <nickpiggin@yahoo.com.au>, linux-kernel@vger.kernel.org
References: <20040713122805.GZ21066@holomorphy.com> <40F3DACC.9070703@yahoo.com.au> <20040713125331.GA21066@holomorphy.com> <40F3DC52.1030308@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40F3DC52.1030308@yahoo.com.au>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
>> AFAICT this is nothing more than rounding up.

On Tue, Jul 13, 2004 at 10:57:54PM +1000, Nick Piggin wrote:
> But you want to round down by definition of preempt_thresh, don't you?
> preempt_thresh = 1ms = 1000000us
> ie. warn me if the lock hold goes _to or above_ 1000000us

The semantics I implemented are warning for strictly above the
preempt_thresh. Whether those semantics are ideal is irrelevant; it's
faithful to those semantics. Given that people are asking for sub-
millisecond latencies, maybe I should increase the precision.


-- wli
