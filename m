Return-Path: <linux-kernel-owner+w=401wt.eu-S1750791AbXAKQJ2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750791AbXAKQJ2 (ORCPT <rfc822;w@1wt.eu>);
	Thu, 11 Jan 2007 11:09:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750816AbXAKQJ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Jan 2007 11:09:28 -0500
Received: from extu-mxob-2.symantec.com ([216.10.194.135]:61312 "EHLO
	extu-mxob-2.symantec.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750791AbXAKQJ1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Jan 2007 11:09:27 -0500
X-AuditID: d80ac287-a3f54bb000007fb9-50-45a6626cc96a 
Date: Thu, 11 Jan 2007 16:09:38 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@blonde.wat.veritas.com
To: Jacky Malcles <Jacky.Malcles@bull.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: can't cleanup /proc/swaps without rebooting ?
In-Reply-To: <45A650D2.90901@bull.net>
Message-ID: <Pine.LNX.4.64.0701111601310.21890@blonde.wat.veritas.com>
References: <45A650D2.90901@bull.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 11 Jan 2007 16:09:22.0200 (UTC) FILETIME=[DB30E980:01C7359A]
X-Brightmail-Tracker: AAAAAA==
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Jan 2007, Jacky Malcles wrote:
> 
> is there a way, other than rebooting, to clean up /proc/swaps ?
> 
> I'm in this situation (due to testing errors),
> # cat /proc/swaps
> Filename                                Type            Size    Used
> Priority
> /dev/sdc1                               partition       2040064 0       -1
> /tmp/swaH4mvTI/swapfilenext\040(deleted) file           48960   0       -31
> /tmp/swa5TlBva/swapfilenext\040(deleted) file           49088   0       -118
> #
> #swapon -s
> Filename                                Type            Size    Used
> Priority
> /dev/sdc1                               partition       2040064 0       -1
> /tmp/swaH4mvTI/swapfilenext\040(deleted) file           48960   0       -31
> /tmp/swa5TlBva/swapfilenext\040(deleted) file           49088   0       -118
> #

Good question.  Sorry, I don't see another way than rebooting.
Next time you're testing, best keep a link to those swapfiles.
Not an answer to be proud of, but it looks like a better answer
would need a whole new syscall (or perhaps some /proc trickery).

Hugh
