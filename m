Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262244AbVBVIHj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262244AbVBVIHj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Feb 2005 03:07:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262246AbVBVIHi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Feb 2005 03:07:38 -0500
Received: from fire.osdl.org ([65.172.181.4]:25778 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262244AbVBVIHa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Feb 2005 03:07:30 -0500
Date: Tue, 22 Feb 2005 00:07:10 -0800
From: Andrew Morton <akpm@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: raybry@sgi.com, mort@wildopensource.com, pj@sgi.com,
       linux-kernel@vger.kernel.org, hilgeman@sgi.com
Subject: Re: [PATCH/RFC] A method for clearing out page cache
Message-Id: <20050222000710.5ad0d8c1.akpm@osdl.org>
In-Reply-To: <20050222075304.GA778@elte.hu>
References: <20050214154431.GS26705@localhost>
	<20050214193704.00d47c9f.pj@sgi.com>
	<20050221192721.GB26705@localhost>
	<20050221134220.2f5911c9.akpm@osdl.org>
	<421A607B.4050606@sgi.com>
	<20050221144108.40eba4d9.akpm@osdl.org>
	<20050222075304.GA778@elte.hu>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar <mingo@elte.hu> wrote:
>
> app designers very frequently think that the VM gets its act wrong (most
>  of the time for the wrong reasons), and the last thing we want to enable
>  them is to hack real problems around.

Not really.  Memory reclaim tries to predict the future and expects some
sort of "average" workload.  For some workloads that prediction is
hopelessly wrong.  Although we could surely provide manual hinting
machinery which is less crude than this proposal.

>  . enable users to
>  specify an 'allocation priority' of some sort, which kicks out the
>  pagecache on the local node - or something like that.

Yes, that would be preferable - I don't know what the difficulty is with
that.  sys_set_mempolicy() should provide a sufficiently good hint.

