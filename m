Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262416AbTJATAq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 15:00:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262409AbTJATAq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 15:00:46 -0400
Received: from nat-pool-bos.redhat.com ([66.187.230.200]:62069 "EHLO
	chimarrao.boston.redhat.com") by vger.kernel.org with ESMTP
	id S262416AbTJATAj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 15:00:39 -0400
Date: Wed, 1 Oct 2003 14:58:43 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Chris Wright <chrisw@osdl.org>
cc: torvalds@osdl.org, <greg@kroah.com>, <linux-kernel@vger.kernel.org>
Subject: Re: sys_vserver
In-Reply-To: <20031001115127.A14425@osdlab.pdx.osdl.net>
Message-ID: <Pine.LNX.4.44.0310011454530.19538-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Oct 2003, Chris Wright wrote:

> Multiplexing, future functionality, etc...this reasoning was shot down
> before. The preferred method was to have well-typed interfaces that 
> are simple and not overloaded.  Any chance some of these needs could be
> met with existing infrastructure in 2.6?  For example, similar to the
> sys_new_s_context issue was resolved for LSM with the /proc/pid/attr/
> interface, could this be reused?

OK, a few comments here:

1) the vserver functionality definately is not "future functionality",
   people have been using it in production for a few years already

2) currently vserver only runs on 2.4 (and I think 2.2), it hasn't
   been ported to 2.6 yet and I definately plan to port it in such
   a way that we will be reusing other infrastructure whereever
   possible ... it's just that vserver needs some infrastructure
   that is not possible inside LSM

3) the needs that can be met with existing infrastructure, like
   CLONE_NEWNS or LSM should definately move out of the vserver
   patch in the port to 2.6

4) I'm all for generalising the interface, how about sys_virtual_context ?

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan

