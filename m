Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264425AbTLVPTD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Dec 2003 10:19:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264426AbTLVPTC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Dec 2003 10:19:02 -0500
Received: from nat-pool-bos.redhat.com ([66.187.230.200]:11089 "EHLO
	chimarrao.boston.redhat.com") by vger.kernel.org with ESMTP
	id S264425AbTLVPTB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Dec 2003 10:19:01 -0500
Date: Mon, 22 Dec 2003 10:18:58 -0500 (EST)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Andreas Unterkircher <unki@netshadow.at>
cc: linux-kernel@vger.kernel.org
Subject: Re: /proc/meminfo values
In-Reply-To: <1072104601.1165.33.camel@winsucks>
Message-ID: <Pine.LNX.4.44.0312221017570.7321-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Dec 2003, Andreas Unterkircher wrote:

> but with 2.6 it looks like they have been removed. where can i get the
> exactly free memory (+ swap) from the kernel so i havn't to use the
> kb-values which i get back from /proc/meminfo?

The values are in page granularity.  On x86 you're not going
to get them at any finer granularity than 4kB increments,
because that is the page size.

The kB values are still smaller than the allocation granularity,
so no accuracy is lost.

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan

