Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262403AbTJNM22 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Oct 2003 08:28:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262557AbTJNM21
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Oct 2003 08:28:27 -0400
Received: from fw.osdl.org ([65.172.181.6]:40166 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262403AbTJNM2Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Oct 2003 08:28:25 -0400
Date: Tue, 14 Oct 2003 05:31:54 -0700
From: Andrew Morton <akpm@osdl.org>
To: Anton Blanchard <anton@samba.org>
Cc: wli@holomorphy.com, linux-kernel@vger.kernel.org
Subject: Re: mem=16MB laptop testing
Message-Id: <20031014053154.469255e5.akpm@osdl.org>
In-Reply-To: <20031014121753.GA610@krispykreme>
References: <20031014105514.GH765@holomorphy.com>
	<20031014045614.22ea9c4b.akpm@osdl.org>
	<20031014121753.GA610@krispykreme>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anton Blanchard <anton@samba.org> wrote:
>
>  
> > hrm.  min_free_kbytes is normally 1024.  I'm surprised that the additional
> > 900k made so much difference.  We must be on the hairy edge.
> > 
> > It looks like we need to precalculate/scale min_free_kbytes, yes?
> 
> That would be good for both the low and high end. Id like to see it
> default to something larger on my 16GB+ machines.
> 

How big?

I guess it should be scaled by ZONE_DMA+ZONE_NORMAL, skipping ZONE_HIGHMEM.
