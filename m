Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264903AbUHCCD4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264903AbUHCCD4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 22:03:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264960AbUHCCD4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 22:03:56 -0400
Received: from holomorphy.com ([207.189.100.168]:9905 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S264903AbUHCCDz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 22:03:55 -0400
Date: Mon, 2 Aug 2004 19:03:45 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Peter Williams <pwil3058@bigpond.net.au>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Michal Kaczmarski <fallow@op.pl>, Shane Shrybman <shrybman@aei.ca>
Subject: Re: [PATCH] V-3.0 Single Priority Array O(1) CPU Scheduler Evaluation
Message-ID: <20040803020345.GU2334@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Peter Williams <pwil3058@bigpond.net.au>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Michal Kaczmarski <fallow@op.pl>, Shane Shrybman <shrybman@aei.ca>
References: <410DDFD2.5090400@bigpond.net.au> <20040802134257.GE2334@holomorphy.com> <410EDD60.8040406@bigpond.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <410EDD60.8040406@bigpond.net.au>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
>> Hmm. Given do_promotions() I'd expect fenceposts, not iteration over
>> the priority levels of the runqueue.

On Tue, Aug 03, 2004 at 10:33:36AM +1000, Peter Williams wrote:
> I don't understand what you mean.  Do you mean something like the more 
> complex promotion mechanism in the (earlier) EBS scheduler where tasks 
> only get promoted if they've been on a queue without being serviced 
> within a given time?

An array of size N can be rotated in O(1) time if an integer is kept
along with it to represent an offset that has to be added to externally-
visible indices mod N to recover the true index.


-- wli
