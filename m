Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261574AbSJZWF5>; Sat, 26 Oct 2002 18:05:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261616AbSJZWF4>; Sat, 26 Oct 2002 18:05:56 -0400
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:61387 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261574AbSJZWF4>; Sat, 26 Oct 2002 18:05:56 -0400
Subject: Re: [PATCH,RFC] faster kmalloc lookup
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3DBAEB64.1090109@colorfullife.com>
References: <3DBAEB64.1090109@colorfullife.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 26 Oct 2002 23:30:12 +0100
Message-Id: <1035671412.13032.125.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2002-10-26 at 20:22, Manfred Spraul wrote:
> kmalloc spends a large part of the total execution time trying to find 
> the cache for the passed in size.
> 
> What about the attached patch (against 2.5.44-mm5)?
> It uses fls jump over the caches that are definitively too small.

Out of curiousity how does fls compare with finding the right cache by
using a binary tree walk ? A lot of platforms seem to use generic_fls
which has a lot of conditions in it and also a lot of references to just
computed values that look likely to stall 

