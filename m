Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932594AbWHDP1F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932594AbWHDP1F (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 11:27:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932589AbWHDP1F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 11:27:05 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:31438 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S932566AbWHDP1D
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 11:27:03 -0400
Date: Fri, 4 Aug 2006 21:01:23 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: Kirill Korotaev <dev@sw.ru>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@osdl.org>,
       mingo@elte.hu, nickpiggin@yahoo.com.au, sam@vilain.net,
       linux-kernel@vger.kernel.org, dev@openvz.org, efault@gmx.de,
       balbir@in.ibm.com, sekharan@us.ibm.com, nagar@watson.ibm.com,
       haveblue@us.ibm.com, pj@sgi.com
Subject: Re: [RFC, PATCH 0/5] Going forward with Resource Management - A cpu controller
Message-ID: <20060804153123.GB32412@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <20060804050753.GD27194@in.ibm.com> <20060803223650.423f2e6a.akpm@osdl.org> <20060803224253.49068b98.akpm@osdl.org> <1154684950.23655.178.camel@localhost.localdomain> <20060804114109.GA28988@in.ibm.com> <44D35F0B.5000801@sw.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44D35F0B.5000801@sw.ru>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 04, 2006 at 06:51:55PM +0400, Kirill Korotaev wrote:
> OpenVZ assumes that tasks can't move between task-groups for a single 
> reason:
> user shouldn't be able to escape from the container.
> But this have no implication on the design/implementation.

Doesnt the ability to move tasks between groups dynamically affect
(atleast) memory controller design (in giving up ownership etc)?
Also if we need to support this movement, we need to have some
corresponding system call/file-system interface which supports this move 
operation.

> BTW, do you see any practical use cases for tasks jumping between 
> resource-containers?

The use cases I have heard of which would benefit such a feature is
(say) for database threads which want to change their "resource
affinity" status depending on which customer query they are currently handling. 
If they are handling a query for a "important" customer, they will want affinied
to a high bandwidth resource container and later if they start handling
a less important query they will want to give up this affinity and
instead move to a low-bandwidth container.

-- 
Regards,
vatsa
