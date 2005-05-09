Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261414AbVEIXyH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261414AbVEIXyH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 May 2005 19:54:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261423AbVEIXyH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 May 2005 19:54:07 -0400
Received: from fisica.ufpr.br ([200.17.209.129]:8939 "EHLO fisica.ufpr.br")
	by vger.kernel.org with ESMTP id S261414AbVEIXyE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 May 2005 19:54:04 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <17023.63512.319555.552924@fisica.ufpr.br>
Date: Mon, 9 May 2005 20:54:00 -0300
To: Con Kolivas <kernel@kolivas.org>
Cc: ck@vds.kolivas.org, Ingo Molnar <mingo@elte.hu>,
       Markus =?iso-8859-1?q?T=F6rnqvist?= <mjt@nysv.org>,
       linux-kernel@vger.kernel.org, AndrewMorton <akpm@osdl.org>
Subject: Re: [ck] Re: [PATCH] implement nice support across physical cpus on SMP
In-Reply-To: <200505092147.06384.kernel@kolivas.org>
References: <20050509112446.GZ1399@nysv.org>
	<200505092147.06384.kernel@kolivas.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
From: carlos@fisica.ufpr.br (Carlos Carvalho)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas (kernel@kolivas.org) wrote on 9 May 2005 21:47:
 >Perhaps if I make the prio_bias multiplied instead of added to the cpu load 
 >it will be less affected by SCHED_LOAD_SCALE. The attached patch was 
 >confirmed during testing to also provide smp distribution according to nice 
 >on 4x.

It seems to work. I've tested it for a few hours on the same machine
and the 2 nice 0 processes take the bulk of the cpu time, while that
cpu bound program running at nice 19 takes only about 7%.

Maybe it's a bit early to say it's fine, but it does semm much better
than before, so I think it should go into the tree.

Thanks a lot!
