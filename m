Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261698AbULTXRO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261698AbULTXRO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Dec 2004 18:17:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261696AbULTXP0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Dec 2004 18:15:26 -0500
Received: from fw.osdl.org ([65.172.181.6]:33704 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261675AbULTXLj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Dec 2004 18:11:39 -0500
Date: Mon, 20 Dec 2004 15:15:34 -0800
From: Andrew Morton <akpm@osdl.org>
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
Cc: nacc@us.ibm.com, nickpiggin@yahoo.com.au, nish.aravamudan@gmail.com,
       paulmck@us.ibm.com, sfr@canb.auug.org.au, linux-kernel@vger.kernel.org,
       dipankar@in.ibm.com, shaohua.li@intel.com, len.brown@intel.com
Subject: Re: [PATCH] Remove RCU abuse in cpu_idle()
Message-Id: <20041220151534.224bff15.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.61.0412201556130.12334@montezuma.fsmlabs.com>
References: <Pine.LNX.4.61.0412110804500.5214@montezuma.fsmlabs.com>
	<Pine.LNX.4.61.0412112123490.7847@montezuma.fsmlabs.com>
	<Pine.LNX.4.61.0412112205290.7847@montezuma.fsmlabs.com>
	<Pine.LNX.4.61.0412112244000.7847@montezuma.fsmlabs.com>
	<29495f1d04121818403f949fdd@mail.gmail.com>
	<Pine.LNX.4.61.0412191757450.18310@montezuma.fsmlabs.com>
	<1103505344.5093.4.camel@npiggin-nld.site>
	<Pine.LNX.4.61.0412191819130.18310@montezuma.fsmlabs.com>
	<1103507784.5093.9.camel@npiggin-nld.site>
	<Pine.LNX.4.61.0412191909580.18310@montezuma.fsmlabs.com>
	<20041220182711.GA13972@us.ibm.com>
	<Pine.LNX.4.61.0412201556130.12334@montezuma.fsmlabs.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zwane Mwaikambo <zwane@arm.linux.org.uk> wrote:
>
> > I believe the only files/patches that needed to be changed were the process.c
> > changes. Here they are re-worked to use ssleep(1) instead of
> 
> This makes it hard for the person integrating the patches to graft them 
> together.

I gave up and just edited the original diff, with
s/schedule_timeout(HZ)/ssleep(1)/
