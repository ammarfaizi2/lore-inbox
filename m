Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262313AbVC2PZ7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262313AbVC2PZ7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 10:25:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262312AbVC2PZ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 10:25:59 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:2493 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S262316AbVC2PZw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 10:25:52 -0500
Date: Tue, 29 Mar 2005 07:23:35 -0800
From: Paul Jackson <pj@engr.sgi.com>
To: Guillaume Thouvenin <guillaume.thouvenin@bull.net>
Cc: johnpol@2ka.mipt.ru, akpm@osdl.org, greg@kroah.com,
       linux-kernel@vger.kernel.org, jlan@engr.sgi.com, efocht@hpce.nec.com,
       linuxram@us.ibm.com, gh@us.ibm.com, elsa-devel@lists.sourceforge.net
Subject: Re: [patch 1/2] fork_connector: add a fork connector
Message-Id: <20050329072335.52b06462.pj@engr.sgi.com>
In-Reply-To: <1112087822.8426.46.camel@frecb000711.frec.bull.fr>
References: <1111745010.684.49.camel@frecb000711.frec.bull.fr>
	<20050328134242.4c6f7583.pj@engr.sgi.com>
	<1112079856.5243.24.camel@uganda>
	<20050329004915.27cd0edf.pj@engr.sgi.com>
	<1112087822.8426.46.camel@frecb000711.frec.bull.fr>
Organization: SGI
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Guillaume wrote:
>   The goal of the fork connector is to inform a user space application
> that a fork occurs in the kernel. This information (cpu ID, parent PID
> and child PID) can be used by several user space applications. It's not
> only for accounting. Accounting and fork_connector are two different
> things and thus, fork_connector doesn't do the merge of any kinds of
> data (and it will never do). 

Yes - it is clear that the fork_connector does this - inform user space
of fork information <cpu, parent, child>.  I'm not saying that
fork_connector should merge data; I'm observing that it doesn't, and
that this would seem to serve the needs of accounting poorly.

Out of curiosity, what are these 'several user space applications?'  The
only one I know of is this extension to bsd accounting to include
capturing parent and child pid at fork.  Probably you've mentioned some
other uses of fork_connector before here, but I missed it.

> The relayfs is done, like Evgeniy said, for large amount of
> datas. So I think that it's not suitable for what we want to achieve
> with the fork connector.

I never claimed that relayfs was appropriate for fork_connector.

I'm not trying to tape a rock to Evgeniy's screwdriver.  I'm saying that
accounting looks like a nail to me, so let us see what rocks and hammers
we have in our tool box.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@engr.sgi.com> 1.650.933.1373, 1.925.600.0401
