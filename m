Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263861AbTLKWmt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Dec 2003 17:42:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264233AbTLKWmt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Dec 2003 17:42:49 -0500
Received: from nat-pool-bos.redhat.com ([66.187.230.200]:47779 "EHLO
	chimarrao.boston.redhat.com") by vger.kernel.org with ESMTP
	id S263861AbTLKWms (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Dec 2003 17:42:48 -0500
Date: Thu, 11 Dec 2003 17:42:46 -0500 (EST)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Mike Fedyk <mfedyk@matchmail.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Mem: and Swap: lines in /proc/meminfo
In-Reply-To: <20031211222311.GH15401@matchmail.com>
Message-ID: <Pine.LNX.4.44.0312111741150.15419-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Dec 2003, Mike Fedyk wrote:

> Inact_dirty:     21516 kB
> Inact_laundry:   65612 kB
> Inact_clean:     19812 kB
> 
> These three are seperate lists in rmap, and are equal to "Inactive:" in
> the -aa vm.

I should add an Inactive: list to -rmap that sums up all
3, to make it a bit easier on programs parsing /proc.

Note that the inactive clean pages count (more or less)
as free pages, too.

> Inact_target:   150080 kB
> 
> This doesn't account any memory, but is only what the VM is trying to size
> the sum of the three lists above.
> 
> Do I have that right?

Yes, you're completely right.

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan

