Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932345AbWESP0S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932345AbWESP0S (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 May 2006 11:26:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932348AbWESP0S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 May 2006 11:26:18 -0400
Received: from smtp.osdl.org ([65.172.181.4]:51647 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932345AbWESP0R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 May 2006 11:26:17 -0400
Date: Fri, 19 May 2006 08:25:16 -0700
From: Andrew Morton <akpm@osdl.org>
To: Andrey Savochkin <saw@sw.ru>
Cc: linux-kernel@vger.kernel.org, dev@sw.ru, herbert@13thfloor.at,
       devel@openvz.org, sam@vilain.net, ebiederm@xmission.com, xemul@sw.ru,
       haveblue@us.ibm.com, clg@fr.ibm.com, serue@us.ibm.com
Subject: Re: [PATCH 0/9] namespaces: Introduction
Message-Id: <20060519082516.26cea6c5.akpm@osdl.org>
In-Reply-To: <20060519174757.A17609@castle.nmd.msu.ru>
References: <20060518154700.GA28344@sergelap.austin.ibm.com>
	<20060518103430.080e3523.akpm@osdl.org>
	<20060519174757.A17609@castle.nmd.msu.ru>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrey Savochkin <saw@sw.ru> wrote:
>
> I have a practical proposal.
>  We can start with presenting and merging the most interesting part, network
>  containers.  We discuss details, possible approaches, and related subsystems,
>  until networking is finished to its utmost detail.
>  This will create an example of virtualization of a non-trivial subsystem,
>  and we will have to agree on basic principles of virtualization of related
>  subsystems like proc.
> 
>  Virtualization of networking presents a lot of challenges and decision-making
>  points with respect to user-visible interfaces: proc, sysctl, netlink events
>  (and netlink sockets themselves), and so on.  This code will also become
>  immediately useful as an improvement over chroot.
>  I am sure that when we come to a mutually acceptable solution with respect to
>  networking, virtualization of all other subsystems can be implemented and
>  merged without many questions.
> 
>  What do people think about this plan?

It sounds like that feature might be the
most-likely-to-cause-maintainer-revolt one, in which case yes, it is
absolutely definitely the one to start with.

Because if it ends up that an acceptable approach cannot be found, and if
this feature is compulsory for any sane virtualisation implementation then
that's it - game over.  We want to discover such blockers as early in the
process as possible.
