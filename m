Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262623AbTIAGBq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Sep 2003 02:01:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262630AbTIAGBp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Sep 2003 02:01:45 -0400
Received: from nat-pool-bos.redhat.com ([66.187.230.200]:9072 "EHLO
	chimarrao.boston.redhat.com") by vger.kernel.org with ESMTP
	id S262623AbTIAGBn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Sep 2003 02:01:43 -0400
Date: Mon, 1 Sep 2003 02:01:35 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Marcelo Tosatti <marcelo@parcelfarce.linux.theplanet.co.uk>
cc: Andrea Arcangeli <andrea@suse.de>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: Andrea VM changes
In-Reply-To: <Pine.LNX.4.44.0308311433410.16240-100000@logos.cnet>
Message-ID: <Pine.LNX.4.44.0309010200470.25149-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 31 Aug 2003, Marcelo Tosatti wrote:

> Suppose you have a big fat hog leaking (lets say, netscape) allocating
> pages at a slow pace. Now you have a decent well behaved app who is
> allocating at a fast pace, and gets killed.
> 
> The chance the well behaved app gets killed is big, right? 

Usually syslogd, which receives an error message from the
network driver the moment memory fills up.

The near-certain death of syslogd in OOM situations is why
I wrote the OOM killer in the first place.

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan

