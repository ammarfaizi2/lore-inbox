Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261377AbVB0OLG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261377AbVB0OLG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Feb 2005 09:11:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261395AbVB0OLG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Feb 2005 09:11:06 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:48800 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261377AbVB0OLD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Feb 2005 09:11:03 -0500
Date: Sun, 27 Feb 2005 06:49:49 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Andrew Morton <akpm@osdl.org>, davem@redhat.com
Cc: Kaigai Kohei <kaigai@ak.jp.nec.com>, jlan@sgi.com,
       lse-tech@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [Lse-tech] Re: A common layer for Accounting packages
Message-ID: <20050227094949.GA22439@logos.cnet>
References: <42168D9E.1010900@sgi.com> <20050218171610.757ba9c9.akpm@osdl.org> <421993A2.4020308@ak.jp.nec.com> <421B955A.9060000@sgi.com> <421C2B99.2040600@ak.jp.nec.com> <421CEC38.7010008@sgi.com> <421EB299.4010906@ak.jp.nec.com> <20050224212839.7953167c.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050224212839.7953167c.akpm@osdl.org>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 24, 2005 at 09:28:39PM -0800, Andrew Morton wrote:
> Kaigai Kohei <kaigai@ak.jp.nec.com> wrote:
> >
> > In my understanding, what Andrew Morton said is "If target functionality can
> >  implement in user space only, then we should not modify the kernel-tree".
> 
> fork, exec and exit upcalls sound pretty good to me.  As long as
> 
> a) they use the same common machinery and
> 
> b) they are next-to-zero cost if something is listening on the netlink
>    socket but no accounting daemon is running.

b) would involved being able to avoid sending netlink messages in case there are 
no listeners. AFAIK that isnt possible currently, netlink sends 
packets unconditionally.

Am I wrong? 

