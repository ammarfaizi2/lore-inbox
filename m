Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751744AbWEIKAw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751744AbWEIKAw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 06:00:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751731AbWEIKAw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 06:00:52 -0400
Received: from courier.cs.helsinki.fi ([128.214.9.1]:6310 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP
	id S1751485AbWEIKAv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 06:00:51 -0400
Date: Tue, 9 May 2006 13:00:44 +0300 (EEST)
From: Pekka J Enberg <penberg@cs.Helsinki.FI>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
cc: davem@davemloft.net, akpm@osdl.org, linux-kernel@vger.kernel.org,
       blaisorblade@yahoo.it, jdike@karaya.com,
       user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [PROBLEM] UML is killed by SIGALRM
In-Reply-To: <20060509092154.GC9417@osiris.boeblingen.de.ibm.com>
Message-ID: <Pine.LNX.4.58.0605091259430.27821@sbz-30.cs.Helsinki.FI>
References: <Pine.LNX.4.58.0605091125400.24592@sbz-30.cs.Helsinki.FI>
 <20060509092154.GC9417@osiris.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 May 2006, Heiko Carstens wrote:
> No idea what might cause this. Guess there are no messages on the console?

Nope.

On Tue, 9 May 2006, Heiko Carstens wrote:
> > I did a git bisect which found the offending commit:
> > 
> >     [IPV4]: inet_init() -> fs_initcall
> > 
> >     Convert inet_init to an fs_initcall to make sure its called before any
> >     device driver's initcall.
> 
> Could you try the patch below? It will move inet_init a bit down the chain of
> the initcall list. Even though I doubt it will help...

Tried it, still the same problem.

				Pekka
