Return-Path: <linux-kernel-owner+w=401wt.eu-S1753273AbWLTHuS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753273AbWLTHuS (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 02:50:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753539AbWLTHuS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 02:50:18 -0500
Received: from ug-out-1314.google.com ([66.249.92.171]:12618 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753273AbWLTHuR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 02:50:17 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mail-followup-to:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=GB+Uc+YhIJtnv6izuzQfKMJMIQbzQC1+nBTEbAWwGshgvCFpBADcThEFDcddYWnh0ZdQ/pGaqS4JwtrdsJR6F5myRVx6Px+601ZMmhZpyWxZ2MbkiiHICH3tCzrhwTjJwX8zzfzwV1FCWsMPJ+MCrGGeCDHgpX00FZ57RYX0xqg=
Date: Wed, 20 Dec 2006 16:49:17 +0900
From: Akinobu Mita <akinobu.mita@gmail.com>
To: Paul Mackerras <paulus@samba.org>
Cc: linux-kernel@vger.kernel.org, Anton Blanchard <anton@samba.org>
Subject: Re: [PATCH] powerpc: use is_init()
Message-ID: <20061220074917.GA4038@APFDCB5C>
Mail-Followup-To: Akinobu Mita <akinobu.mita@gmail.com>,
	Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org,
	Anton Blanchard <anton@samba.org>
References: <20061219083549.GA4025@APFDCB5C> <17800.46811.966114.640221@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17800.46811.966114.640221@cargo.ozlabs.ibm.com>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 20, 2006 at 03:06:51PM +1100, Paul Mackerras wrote:
> Akinobu Mita writes:
> 
> > Use is_init() rather than hard coded pid comparison.
> 
> What's the context of this patch?  Why is this a good thing to do?
> 

This is just minor cleanup patch.
is_init() is available on 2.6.20-rc1 (include/linux/sched.h):

/**
 * is_init - check if a task structure is init
 * @tsk: Task structure to be checked.
 *
 * Check if a task structure is the first user space task the kernel created.
 */
static inline int is_init(struct task_struct *tsk)
{
        return tsk->pid == 1;
}

