Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265609AbUA0TbE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jan 2004 14:31:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265592AbUA0T36
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jan 2004 14:29:58 -0500
Received: from ns.suse.de ([195.135.220.2]:62650 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S265609AbUA0T3c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jan 2004 14:29:32 -0500
Date: Tue, 27 Jan 2004 20:29:30 +0100
From: Andi Kleen <ak@suse.de>
To: dada1 <dada1@cosmosbay.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: linux-2.6.1 x86_64 : STACK_TOP and text/data
Message-Id: <20040127202930.6c29bbcf.ak@suse.de>
In-Reply-To: <4016B493.9050404@cosmosbay.com>
References: <OFCE30A640.024A04A1-ONC1256E28.003023EA-C1256E28.0030BF4E@de.ibm.com.suse.lists.linux.kernel>
	<40162E9A.1080005@cosmosbay.com.suse.lists.linux.kernel>
	<p73k73dfdvs.fsf@nielsen.suse.de>
	<4016B493.9050404@cosmosbay.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Jan 2004 19:57:23 +0100
dada1 <dada1@cosmosbay.com> wrote:

> Andi Kleen wrote:
> 
> > STACK_TOP is only for 32bit a.out executables running on x86-64
> >
> >ELF 32bit and 64bit programs use different defaults.
> >
> >-Andi
> >
> >
> >  
> >
> Hi Andi
> 
> I'm afraid not Andi

You're right. Thanks for reporting this. This seems to be a 2.6 
specific bug, it didn't happen in 2.4.

I will fix it. It should definitely use PAGE_OFFSET for 64bit 
processes and 4GB for !3GB 32bit processes.

-Andi
