Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262176AbUCEDnZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Mar 2004 22:43:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262180AbUCEDnZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Mar 2004 22:43:25 -0500
Received: from mx1.redhat.com ([66.187.233.31]:52628 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262176AbUCEDnY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Mar 2004 22:43:24 -0500
Date: Thu, 4 Mar 2004 22:43:20 -0500 (EST)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Andrea Arcangeli <andrea@suse.de>
cc: Andrew Morton <akpm@osdl.org>, Peter Zaitsev <peter@mysql.com>,
       <mbligh@aracnet.com>, <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.23aa2 (bugfixes and important VM improvements for the high
 end)
In-Reply-To: <20040304232418.GW4922@dualathlon.random>
Message-ID: <Pine.LNX.4.44.0403042242150.13417-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Mar 2004, Andrea Arcangeli wrote:
> On Thu, Mar 04, 2004 at 05:14:30PM -0500, Rik van Riel wrote:
> > > or maybe you mean the page_table_lock hold during copy-user that Andrew
> > > mentioned? (copy-user doesn't mean "all VM operations" not sure if you
> > > meant this or the usual locking of every 2.4/2.6 kernel out there)
> > 
> > True, there are some other operations.  However, when
> 
> could you name one that is serialized in 4:4 and not in 3:1 with an mm
> lock? just curious. there are tons of VM operations serialized by the
> page_table_lock that hurts with threads in 3:1 too. I understood only
> copy-user needs the additional locking.

Yeah, in case of a threaded workload you're right.

For a many-processes workload the locking optimisations
definately made a different, IIRC.

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan

