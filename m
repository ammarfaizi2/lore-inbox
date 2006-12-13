Return-Path: <linux-kernel-owner+w=401wt.eu-S964866AbWLMBEa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964866AbWLMBEa (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 20:04:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964867AbWLMBEa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 20:04:30 -0500
Received: from smtp.osdl.org ([65.172.181.25]:35816 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964866AbWLMBE3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 20:04:29 -0500
X-Greylist: delayed 1152 seconds by postgrey-1.27 at vger.kernel.org; Tue, 12 Dec 2006 20:04:29 EST
Date: Tue, 12 Dec 2006 16:45:04 -0800
From: Andrew Morton <akpm@osdl.org>
To: Erik Jacobson <erikj@sgi.com>
Cc: linux-kernel@vger.kernel.org, guillaume.thouvenin@bull.net,
       matthltc@us.ibm.com
Subject: Re: [PATCH] connector: Some fixes for ia64 unaligned access errors
Message-Id: <20061212164504.d6f8a3cb.akpm@osdl.org>
In-Reply-To: <20061212175411.GA20407@sgi.com>
References: <20061207232213.GA29340@sgi.com>
	<1165881166.24721.71.camel@localhost.localdomain>
	<20061212175411.GA20407@sgi.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Dec 2006 11:54:11 -0600
Erik Jacobson <erikj@sgi.com> wrote:

> Hi Andrew.
> 
> There was some discussion on this patch but I believe we've agreed
> on the first version I sent.  This was ACKed by Matt Helsley.
> 
> Would you consider taking this in to -mm?
> 
> I've included my original patch email at the bottom.
> 

I'm a bit late to the party.

>  cn_proc.c |   94 +++++++++++++++++++++++++++++++-------------------------------

But it's rather a lot of churn for such a thing.  Did you consider simply using
put_unaligned() against the specific offending field(s)?

