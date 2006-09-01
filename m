Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750721AbWIASPj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750721AbWIASPj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Sep 2006 14:15:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750722AbWIASPj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Sep 2006 14:15:39 -0400
Received: from smtp.osdl.org ([65.172.181.4]:62111 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750721AbWIASPi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Sep 2006 14:15:38 -0400
Date: Fri, 1 Sep 2006 11:09:12 -0700
From: Andrew Morton <akpm@osdl.org>
To: eranian@hpl.hp.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/18] 2.6.17.9 perfmon2 patch for review: sampling
 format support
Message-Id: <20060901110912.e27099e8.akpm@osdl.org>
In-Reply-To: <20060901160925.GF27854@frankl.hpl.hp.com>
References: <200608230805.k7N85v1s000408@frankl.hpl.hp.com>
	<20060823153537.cb36b9ac.akpm@osdl.org>
	<20060901160925.GF27854@frankl.hpl.hp.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Sep 2006 09:09:25 -0700
Stephane Eranian <eranian@hpl.hp.com> wrote:

> > Why identify a format with a UUID rather than via a nice human-readable name?
> > 
> 
> Although a UUID is slightly more difficult to manipulate than a clear text string, it
> offers several advantages:
> 	- is guaranteed unique
> 	- generation is fully distributed
> 	- easy generation with uuidgen
> 	- fixed size
> 	- very easy to pass to the kernel, there is not char * in a struct pass to kernel
> 	- not to worry about '\0'

The kernel has got along OK using ascii strings for this sort of thing in
thousands of places for many years.  Is there something special or unique
about perfmon's requirements which make UUIDs a clearly superior
implementation?

> We use UUID to idenitfy a format + a version number. The version number can be useful
> to identify backward compatible versions of a format.

Interfaces use major and minor version numbering for that.
