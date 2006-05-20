Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751454AbWETA7U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751454AbWETA7U (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 May 2006 20:59:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751457AbWETA7U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 May 2006 20:59:20 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:50064 "EHLO
	watts.utsl.gen.nz") by vger.kernel.org with ESMTP id S1751454AbWETA7U
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 May 2006 20:59:20 -0400
Subject: Re: [PATCH 0/9] namespaces: Introduction
From: Sam Vilain <sam@vilain.net>
To: Andrey Savochkin <saw@sw.ru>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org, dev@sw.ru,
       herbert@13thfloor.at, devel@openvz.org, ebiederm@xmission.com,
       xemul@sw.ru, haveblue@us.ibm.com, clg@fr.ibm.com,
       "Serge E. Hallyn" <serue@us.ibm.com>
In-Reply-To: <20060519174757.A17609@castle.nmd.msu.ru>
References: <20060518154700.GA28344@sergelap.austin.ibm.com>
	 <20060518103430.080e3523.akpm@osdl.org>
	 <20060519174757.A17609@castle.nmd.msu.ru>
Content-Type: text/plain
Date: Sat, 20 May 2006 12:16:04 +1200
Message-Id: <1148084165.7103.14.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-05-19 at 17:47 +0400, Andrey Savochkin wrote:
> We can start with presenting and merging the most interesting part, network
> containers.  We discuss details, possible approaches, and related subsystems,
> until networking is finished to its utmost detail.
> This will create an example of virtualization of a non-trivial subsystem,
> and we will have to agree on basic principles of virtualization of related
> subsystems like proc.
[...]
> What do people think about this plan?

Network is an interesting one because you have multiple solutions - the
very simple approach of network binding (as used by Jacques Gelina's
original IP vhost work from December 1997), and network virtualisation.
That virtualisation itself can be broken down into providing merely
virtual interfaces (so that, for instance, you can have independent lo
interfaces in the virtual servers) as in Vserver 2.1.x, or providing a
completely virtualised network stack, as in Vserver ngnet (and possibly
OpenVZ?).

Each solution performs the virtualisation at a different level, and has
incrementally higher orders of inefficiency and maintenance
requirements.  Yet none of them are essentially better or worse than the
others.

So, we might end up with all three eventually - but binding alone is the
simplest and still extremely useful.

Sam.

