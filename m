Return-Path: <linux-kernel-owner+willy=40w.ods.org-S271189AbUJVLKC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271189AbUJVLKC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 07:10:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271183AbUJVLKB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 07:10:01 -0400
Received: from holomorphy.com ([207.189.100.168]:5058 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S271189AbUJVLJY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 07:09:24 -0400
Date: Fri, 22 Oct 2004 04:09:16 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Lee Revell <rlrevell@joe-job.com>
Cc: root@chaos.analogic.com, John Cherry <cherry@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: IA32 (2.6.9 - 2004-10-20.21.30) - 11 New warnings (gcc 3.2.2)
Message-ID: <20041022110916.GP17038@holomorphy.com>
References: <200410211240.i9LCeDk8015277@cherrypit.pdx.osdl.net> <Pine.LNX.4.61.0410210942230.11962@chaos.analogic.com> <1098390149.3705.16.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1098390149.3705.16.camel@krustophenia.net>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Oct 2004, John Cherry wrote:
>>> drivers/char/mem.c:213: warning: `remap_page_range' is deprecated
>>>   (declared at include/linux/mm.h:767)

On Thu, 2004-10-21 at 09:44, Richard B. Johnson wrote:
>> Hmmm. What does one use instead???  We still use mmap in drivers
>> or is that going to be removed too?

On Thu, Oct 21, 2004 at 04:22:30PM -0400, Lee Revell wrote:
> remap_pfn_range I think.

remap_pfn_range() has identical functionality. It's been given a
distinct entrypoint name so people don't feed it raw physical addresses
by accident. It is an improvement because its interface doesn't truncate
physical addresses. I've got no idea what happened to the
drivers/char/mem.c hunk of my patch. Just check the archives, and see
that the patches I posted do actually sweep drivers/char/mem.c.


-- wli
