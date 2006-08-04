Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161226AbWHDOgF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161226AbWHDOgF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 10:36:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161224AbWHDOgF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 10:36:05 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:13505 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1161226AbWHDOgC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 10:36:02 -0400
Date: Fri, 4 Aug 2006 15:35:17 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Kirill Korotaev <dev@sw.ru>
Cc: Andrew Morton <akpm@osdl.org>, vatsa@in.ibm.com, mingo@elte.hu,
       nickpiggin@yahoo.com.au, sam@vilain.net, linux-kernel@vger.kernel.org,
       dev@openvz.org, efault@gmx.de, balbir@in.ibm.com, sekharan@us.ibm.com,
       nagar@watson.ibm.com, haveblue@us.ibm.com, pj@sgi.com
Subject: Re: [RFC, PATCH 0/5] Going forward with Resource Management - A cpu controller
Message-ID: <20060804143517.GA7641@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Kirill Korotaev <dev@sw.ru>, Andrew Morton <akpm@osdl.org>,
	vatsa@in.ibm.com, mingo@elte.hu, nickpiggin@yahoo.com.au,
	sam@vilain.net, linux-kernel@vger.kernel.org, dev@openvz.org,
	efault@gmx.de, balbir@in.ibm.com, sekharan@us.ibm.com,
	nagar@watson.ibm.com, haveblue@us.ibm.com, pj@sgi.com
References: <20060804050753.GD27194@in.ibm.com> <20060803223650.423f2e6a.akpm@osdl.org> <44D35794.2040003@sw.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44D35794.2040003@sw.ru>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 04, 2006 at 06:20:04PM +0400, Kirill Korotaev wrote:
> For example:
> 1. Should task-group be changeable after set/inherited once?
>  Are you planning to recalculate resources on group change?
>  e.g. shared memory or used kernel memory is hard to recalculate.

I think this is a nice feature, although not on the top priority list.

> 2. should task-group resource container manage all the resources as a whole?
>  e.g. in OpenVZ tasks can belong to different CPU and UBC containers.
>  It is more flexible and e.g. we used to put some vital kernel threads
>  to a separate CPU group to decrease delays in service.

We already support different resource groups for the very limit rlimit
interface.  If we can keep the interface clean doing separate resource
groups is fine.

> 3. I also don't understand why normal binary interface like system call is 
> not used.
>   We have set_uid, sys_setrlimit and it works pretty good, does it?

Yes.  If you can design a syscall interface that is as clean as the two
mentioned above a syscall interface is the best way to go forward.

> 4. do we want hierarchical grouping?

Not at all.  It just causes a lot of pain an complexity for no real world
benefits.

