Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030359AbWILTBe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030359AbWILTBe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 15:01:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030362AbWILTBe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 15:01:34 -0400
Received: from wr-out-0506.google.com ([64.233.184.232]:28495 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1030359AbWILTBe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 15:01:34 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:sender;
        b=EhUssaP7CUrh7Uz80wcvp1r8TTnWvm+MKvgFH87FOjEtS+t5IgIx54OxeFXlt0y87HegQ5fNIS2XXjRfriKjtBov5r/kgTEhUUoc9wxTgmFvkAG7/xsWHV78bNhaKtwOjH62YSiqg5EPYXt5yRX5sUkFpeVKoBMwJBxjBnLk/aY=
Date: Tue, 12 Sep 2006 21:00:39 +0000
From: Frederik Deweerdt <deweerdt@free.fr>
To: Zach Brown <zach.brown@oracle.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       rmk+kernel@arm.linux.org.uk
Subject: Re: [-mm patch] arm build fail: vfpsingle.c
Message-ID: <20060912210039.GB1539@slug>
References: <20060912000618.a2e2afc0.akpm@osdl.org> <20060912200522.GN3775@slug> <4506FC2D.2070109@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4506FC2D.2070109@oracle.com>
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2006 at 11:27:57AM -0700, Zach Brown wrote:
> Frederik Deweerdt wrote:
> > On Tue, Sep 12, 2006 at 12:06:18AM -0700, Andrew Morton wrote:
> >> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc6/2.6.18-rc6-mm2/
> >>
> > Hi,
> > 
> > It looks like Zach Brown's patch pr_debug-check-pr_debug-arguments
> > worked as inteded.
> 
> :).  I should really take the time to get some cross compilers going.
> 
> >   arch/arm/vfp/vfpsingle.c:201: error: `func' undeclared (first use in
> >   this function)
> 
> Does changing 'func' to '__func__' in the arguments fix it?
Yes it does, but the intended use of 'func' (or so I understood) is to
print the calling function name, not the current function's, isn't it?

Frederik
> 
> - z
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
