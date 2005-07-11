Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261240AbVGKIgy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261240AbVGKIgy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 04:36:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261390AbVGKIgy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 04:36:54 -0400
Received: from smtp.nedstat.nl ([194.109.98.184]:24520 "HELO smtp.nedstat.nl")
	by vger.kernel.org with SMTP id S261240AbVGKIgx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 04:36:53 -0400
Subject: Re: [PATCH] eventpoll : Suppress a short lived lock from struct
	file
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Eric Dumazet <dada1@cosmosbay.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Davide Libenzi <davidel@xmailserver.org>
In-Reply-To: <42D21D43.3060300@cosmosbay.com>
References: <4263275A.2020405@lab.ntt.co.jp>
	 <20050418040718.GA31163@taniwha.stupidest.org>
	 <4263356D.9080007@lab.ntt.co.jp>  <20050418044223.GB15002@nevyn.them.org>
	 <1113800136.355.1.camel@localhost.localdomain>
	 <Pine.LNX.4.58.0504172159120.28447@bigblue.dev.mdolabs.com>
	 <42D21D43.3060300@cosmosbay.com>
Content-Type: text/plain
Date: Mon, 11 Jul 2005 10:34:27 +0200
Message-Id: <1121070867.24086.6.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-07-11 at 09:18 +0200, Eric Dumazet wrote:
> Hi Davide
> 
> I found in my tests that there is no need to have a f_ep_lock spinlock
> attached to each struct file, using 8 bytes on 64bits platforms. The
> lock is hold for a very short time period and can be global, with almost
> no change in performance for applications using epoll, and a gain for
> all others.
> 

Have you tested the impact of this change on big SMP/NUMA machines?
I hate to see an Altrix crashing to its knees :-)

-- 
Peter Zijlstra <a.p.zijlstra@chello.nl>

