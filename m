Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262472AbUJ0O5I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262472AbUJ0O5I (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 10:57:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262474AbUJ0O5H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 10:57:07 -0400
Received: from mx1.redhat.com ([66.187.233.31]:34001 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262472AbUJ0O5C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 10:57:02 -0400
Date: Wed, 27 Oct 2004 10:56:45 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
cc: akpm@osdl.org, <linux-kernel@vger.kernel.org>
Subject: Re: [patch] cputime: introduce cputime.
In-Reply-To: <20041027142139.GB3405@mschwid3.boeblingen.de.ibm.com>
Message-ID: <Pine.LNX.4.44.0410271053060.21548-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Oct 2004, Martin Schwidefsky wrote:

> The third thing that gets introduced by this patch is an additional field
> for the /proc/stat interface: cpu steal time. An architecture can account
> cpu steal time by calls to the account_stealtime function. The cpu
> which backs a virtual processor doesn't spent all of its time for the
> virtual cpu. To get meaningful cpu usage numbers this involuntary wait
> time needs to be accounted and exported to user space.

This will be useful for User Mode Linux, Xen and iSeries too.

I suspect we'll also want to report hypervisor wait time in
/proc/stat, so we can see how much time our guest is really
getting...

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan


