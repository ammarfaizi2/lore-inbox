Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263584AbTJQSoS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Oct 2003 14:44:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263491AbTJQSoS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Oct 2003 14:44:18 -0400
Received: from nat-pool-bos.redhat.com ([66.187.230.200]:6604 "EHLO
	chimarrao.boston.redhat.com") by vger.kernel.org with ESMTP
	id S263584AbTJQSml (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Oct 2003 14:42:41 -0400
Date: Fri, 17 Oct 2003 14:42:34 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: "Randy.Dunlap" <rddunlap@osdl.org>
cc: lkml <linux-kernel@vger.kernel.org>, <mingo@redhat.com>,
       <linux-mm@kvack.org>
Subject: Re: 2.6.0-test7-mm1 4G/4G hanging at boot
In-Reply-To: <20031017111955.439d01c8.rddunlap@osdl.org>
Message-ID: <Pine.LNX.4.44.0310171441530.3108-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Oct 2003, Randy.Dunlap wrote:

> then I wait for 1-2 minutes and hit the power button.
> This is on an IBM dual-proc P4 (non-HT) with 1 GB of RAM.
> 
> Has anyone else seen this?  Suggestions or fixes?

Chances are the 8kB stack window isn't 8kB aligned in the
fixmap area, because of other patches interfering.  Try
adding a dummy fixmap page to even things out.

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan

