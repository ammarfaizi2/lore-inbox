Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261710AbULTXSV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261710AbULTXSV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Dec 2004 18:18:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261694AbULTXRd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Dec 2004 18:17:33 -0500
Received: from fsmlabs.com ([168.103.115.128]:22499 "EHLO fsmlabs.com")
	by vger.kernel.org with ESMTP id S261702AbULTXRM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Dec 2004 18:17:12 -0500
Date: Mon, 20 Dec 2004 16:16:32 -0700 (MST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Andrew Morton <akpm@osdl.org>
cc: nacc@us.ibm.com, nickpiggin@yahoo.com.au, nish.aravamudan@gmail.com,
       paulmck@us.ibm.com, sfr@canb.auug.org.au, linux-kernel@vger.kernel.org,
       dipankar@in.ibm.com, shaohua.li@intel.com, len.brown@intel.com
Subject: Re: [PATCH] Remove RCU abuse in cpu_idle()
In-Reply-To: <20041220151534.224bff15.akpm@osdl.org>
Message-ID: <Pine.LNX.4.61.0412201616230.12334@montezuma.fsmlabs.com>
References: <Pine.LNX.4.61.0412110804500.5214@montezuma.fsmlabs.com>
 <Pine.LNX.4.61.0412112123490.7847@montezuma.fsmlabs.com>
 <Pine.LNX.4.61.0412112205290.7847@montezuma.fsmlabs.com>
 <Pine.LNX.4.61.0412112244000.7847@montezuma.fsmlabs.com>
 <29495f1d04121818403f949fdd@mail.gmail.com> <Pine.LNX.4.61.0412191757450.18310@montezuma.fsmlabs.com>
 <1103505344.5093.4.camel@npiggin-nld.site> <Pine.LNX.4.61.0412191819130.18310@montezuma.fsmlabs.com>
 <1103507784.5093.9.camel@npiggin-nld.site> <Pine.LNX.4.61.0412191909580.18310@montezuma.fsmlabs.com>
 <20041220182711.GA13972@us.ibm.com> <Pine.LNX.4.61.0412201556130.12334@montezuma.fsmlabs.com>
 <20041220151534.224bff15.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Dec 2004, Andrew Morton wrote:

> Zwane Mwaikambo <zwane@arm.linux.org.uk> wrote:
> >
> > > I believe the only files/patches that needed to be changed were the process.c
> > > changes. Here they are re-worked to use ssleep(1) instead of
> > 
> > This makes it hard for the person integrating the patches to graft them 
> > together.
> 
> I gave up and just edited the original diff, with
> s/schedule_timeout(HZ)/ssleep(1)/

Thanks Andrew.

