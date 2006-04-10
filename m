Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751126AbWDJK1e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751126AbWDJK1e (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Apr 2006 06:27:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751128AbWDJK1d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Apr 2006 06:27:33 -0400
Received: from mail27.syd.optusnet.com.au ([211.29.133.168]:34226 "EHLO
	mail27.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1751126AbWDJK1d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Apr 2006 06:27:33 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Grzegorz Kulewski <kangur@polcom.net>
Subject: Re: Slow swapon for big (12GB) swap
Date: Mon, 10 Apr 2006 20:27:13 +1000
User-Agent: KMail/1.9.1
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.63.0604091338030.31989@alpha.polcom.net> <20060410004030.5e48be79.akpm@osdl.org> <Pine.LNX.4.63.0604101218380.31989@alpha.polcom.net>
In-Reply-To: <Pine.LNX.4.63.0604101218380.31989@alpha.polcom.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604102027.13741.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 10 April 2006 20:25, Grzegorz Kulewski wrote:
> The kernel is 2.6.16-rc3-git2-ck1. There is -ck patch in it but I strongly
> hope that swap prefetch is not *that* buggy to cause such things... I am
> considering testing vanilla. Con CC'd.

Turn it off by setting the swap_prefetch tunable to 0. That disables even 
storing swapped information. Swap prefetch does very little with that set to 
0, but ultimately you'd have to de-configure it to be sure I guess.

-- 
-ck
