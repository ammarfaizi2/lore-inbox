Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261433AbTIZQOj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Sep 2003 12:14:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261522AbTIZQOj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Sep 2003 12:14:39 -0400
Received: from gaia.cela.pl ([213.134.162.11]:1286 "EHLO gaia.cela.pl")
	by vger.kernel.org with ESMTP id S261433AbTIZQOi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Sep 2003 12:14:38 -0400
Date: Fri, 26 Sep 2003 18:14:17 +0200 (CEST)
From: Maciej Zenczykowski <maze@cela.pl>
To: Ruth Ivimey-Cook <Ruth.Ivimey-Cook@ivimey.org>
cc: Ingo Molnar <mingo@elte.hu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Syscall security
In-Reply-To: <Pine.LNX.4.44.0309261521190.22241-100000@gatemaster.ivimey.org>
Message-ID: <Pine.LNX.4.44.0309261810290.6080-100000@gaia.cela.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >Unfortunately sometimes the data transfer through stdio can be counted in 
> >hundreds of MB (or even in extreme cases a couple of GB), plus it is 
> 
> Would running the process under user-mode linux help any? (I'm not sure)

I think that's trying to kill a fly with a cannon.  Especially since 
afterwards the process in UML would still need to be somehow protected 
from calling UML syscalls - I'm not quite sure how UML works (never really 
used it), but I'm assuming it will still allow getuid/gettimeofday etc 
syscalls.  Correct me if I'm wrong _or_ if i'm misinterpreting your idea.
Besides sometimes these processes are spawned in the dozens (sometimes 
they spawn massively with very little CPU intensity, other times very 
rarely but with massive CPU use) - would I then need a seperate UML kernel 
per spawn? and if not then how would this help?

Thx,
MaZe.

