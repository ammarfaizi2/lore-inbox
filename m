Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265261AbTLMRyX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Dec 2003 12:54:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265265AbTLMRyW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Dec 2003 12:54:22 -0500
Received: from nat-pool-bos.redhat.com ([66.187.230.200]:63808 "EHLO
	chimarrao.boston.redhat.com") by vger.kernel.org with ESMTP
	id S265261AbTLMRyV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Dec 2003 12:54:21 -0500
Date: Sat, 13 Dec 2003 12:54:19 -0500 (EST)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Mike Fedyk <mfedyk@matchmail.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: More questions about 2.6 /proc/meminfo was: (Mem: and Swap:
 lines in /proc/meminfo)
In-Reply-To: <20031213032330.GA1769@matchmail.com>
Message-ID: <Pine.LNX.4.44.0312131010400.26386-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Dec 2003, Mike Fedyk wrote:

> VmallocUsed is being reported in /proc/meminfo in 2.6 now.
> 
> Is VmallocUsed contained within any of the other memory reported below?

No.

> How can I get VmallocUsed from userspace in earlier kernels (2.[024])?

You can't.

> And the same questions with PageTables too. :)

Same answers ;)

Maybe I should send marcelo a patch to export the PageTables
number in /proc somewhere ?

> Are Dirty: and Writeback: counted in Inactive: or are they seperate?

They're unrelated statistics to active/inactive and will
overlap with active/inactive.

> Does Mapped: include all files mmap()ed, or only the executable ones?

Mapped: includes all mmap()ed pages, regardless of executable
status.

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan

