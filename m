Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264503AbUD0XdD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264503AbUD0XdD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 19:33:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264444AbUD0XcH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 19:32:07 -0400
Received: from gate.crashing.org ([63.228.1.57]:1509 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S264429AbUD0Xaq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 19:30:46 -0400
Subject: Re: Bug#234976: kernel-source-2.6.4: Software Suspend doesn't work
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: ncunningham@linuxmail.org
Cc: Pavel Machek <pavel@suse.cz>, Herbert Xu <herbert@gondor.apana.org.au>,
       Andrew Morton <akpm@zip.com.au>, seife@suse.de,
       Nigel Cunningham <ncunningham@linuxmail.com>,
       Roland Stigge <stigge@antcom.de>, 234976@bugs.debian.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <opr641k5m2shwjtr@laptop-linux.wpcb.org.au>
References: <20040426104015.GA5772@gondor.apana.org.au>
	 <opr6193np1ruvnp2@laptop-linux.wpcb.org.au>
	 <20040426131152.GN2595@openzaurus.ucw.cz>
	 <1083048985.12517.21.camel@gaston> <20040427102127.GB10593@elf.ucw.cz>
	 <20040427102344.GA24313@gondor.apana.org.au>
	 <20040427124837.GK10593@elf.ucw.cz>
	 <20040427125402.GA16740@gondor.apana.org.au>
	 <20040427215236.GA469@elf.ucw.cz>
	 <opr640q9abshwjtr@laptop-linux.wpcb.org.au>
	 <20040427231626.GA32689@elf.ucw.cz>
	 <opr641k5m2shwjtr@laptop-linux.wpcb.org.au>
Content-Type: text/plain
Message-Id: <1083108250.16475.54.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 28 Apr 2004 09:24:11 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> ged, anyway...
> 
> Could do. And on the top of merging, sorry for the delays I'm getting  
> there. I figured out yesterday what was holding me back with getting SMP &  
> HighMem going under 2.6. It was really simple: the compile was using -O2.  
> A quick change to the Makefile and I can now use a C file as I do with 2.4.

Which, as I keep saying, is plain broken ... You simply cannot control
what side effects the compiler will generate, like touching the stack,
etc... Such a critical routine _has_ to be written in assembly (and
properly commented of course). Anything else is asking for trouble.

Ben.

