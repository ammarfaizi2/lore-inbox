Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264274AbUD0SgQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264274AbUD0SgQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 14:36:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264286AbUD0SgQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 14:36:16 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:57240 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S264274AbUD0SgN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 14:36:13 -0400
Date: Tue, 27 Apr 2004 20:36:07 +0200
From: Jens Axboe <axboe@suse.de>
To: Kenneth Johansson <ken@kenjo.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BUG] DVD writing in 2.6.6-rc2
Message-ID: <20040427183607.GA3011@suse.de>
References: <1083088772.2679.11.camel@tiger>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1083088772.2679.11.camel@tiger>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 27 2004, Kenneth Johansson wrote:
> I have a problem when using growisofs version 5.19.
> 
> The problem is that in the very end when gowisofs tries to flush the
> cache. When stracing the process I can see it sits in a call to poll
> that never returns. 
> 
> I noticed that if I start growisofs and later attach to it with "strace
> -p" I can make it continue with killing the strace process. just to see
> it hang in the next poll. But re attaching then killing the strace again
> a few times and growisofs finally dose a normal exit.
> 
> This happens every time. 

I noted the same thing yesterday with cdrdao, so yours is not an
isolated incident. I'll debug it tomorrow.

-- 
Jens Axboe

