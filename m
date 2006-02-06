Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750909AbWBFJ6K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750909AbWBFJ6K (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 04:58:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750913AbWBFJ6K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 04:58:10 -0500
Received: from smtp.osdl.org ([65.172.181.4]:33180 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750909AbWBFJ6I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 04:58:08 -0500
Date: Mon, 6 Feb 2006 01:57:09 -0800
From: Andrew Morton <akpm@osdl.org>
To: Paul Jackson <pj@sgi.com>
Cc: dgc@sgi.com, steiner@sgi.com, Simon.Derr@bull.net, ak@suse.de,
       linux-kernel@vger.kernel.org, clameter@sgi.com
Subject: Re: [PATCH 1/5] cpuset memory spread basic implementation
Message-Id: <20060206015709.01bf4d16.akpm@osdl.org>
In-Reply-To: <20060206013227.2407cf8c.pj@sgi.com>
References: <20060204071910.10021.8437.sendpatchset@jackhammer.engr.sgi.com>
	<20060205203711.2c855971.akpm@osdl.org>
	<20060205225629.5d887661.pj@sgi.com>
	<20060205230816.4ae6b6e2.akpm@osdl.org>
	<20060206013227.2407cf8c.pj@sgi.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Jackson <pj@sgi.com> wrote:
>
>  Is page vs slab cache the appropriate level of granularity?
> 

I guess so.  Doing it on a per-cpuset+per-slab or per-cpuset+per-inode
basis would get a bit complex implementation-wise, I expect.  And a smart
application could roughly implement that itself anyway by turning spreading
on and off as it goes.

One does wonder about the buffer-head slab - it's pretty tightly bound to
pagecache..

