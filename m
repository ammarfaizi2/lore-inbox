Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261933AbVCHJm7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261933AbVCHJm7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 04:42:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261934AbVCHJm7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 04:42:59 -0500
Received: from fire.osdl.org ([65.172.181.4]:16305 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261933AbVCHJm4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 04:42:56 -0500
Date: Tue, 8 Mar 2005 01:41:41 -0800
From: Andrew Morton <akpm@osdl.org>
To: suparna@in.ibm.com
Cc: sebastien.dugue@bull.net, linux-aio@kvack.org,
       linux-kernel@vger.kernel.org, pbadari@us.ibm.com, daniel@osdl.org
Subject: Re: [PATCH] 2.6.10 -  direct-io async short read bug
Message-Id: <20050308014141.08a546a9.akpm@osdl.org>
In-Reply-To: <20050308094159.GA4144@in.ibm.com>
References: <1110189607.11938.14.camel@frecb000686>
	<20050307223917.1e800784.akpm@osdl.org>
	<20050308090946.GA4100@in.ibm.com>
	<20050308011814.706c094e.akpm@osdl.org>
	<20050308094159.GA4144@in.ibm.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Suparna Bhattacharya <suparna@in.ibm.com> wrote:
>
> > > can you spot what is going wrong here that we have to try and
>  > > workaround this later ?
>  > 
>  > Good question.  Do we have the i_sem coverage to prevent a concurrent
>  > truncate?
>  > 
>  > But from Sebastien's description it doesn't soound as if a concurrent
>  > truncate is involved.
> 
>  Daniel McNeil has a testcase that reproduces the problem - seemed
>  like a single thread thing - that's what puzzles me.

OK.  It'd be nice if we could find a solution which gets around that i_size
access in the ISR, if someone has the time to look into it?

