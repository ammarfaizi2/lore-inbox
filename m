Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751342AbWARGLw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751342AbWARGLw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 01:11:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751343AbWARGLw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 01:11:52 -0500
Received: from ms-smtp-01.texas.rr.com ([24.93.47.40]:19942 "EHLO
	ms-smtp-01-eri0.texas.rr.com") by vger.kernel.org with ESMTP
	id S1751342AbWARGLw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 01:11:52 -0500
Date: Wed, 18 Jan 2006 00:11:24 -0600
From: Dave McCracken <dmccr@us.ibm.com>
To: Dave Hansen <haveblue@us.ibm.com>, Robin Holt <holt@sgi.com>
cc: Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Linux Memory Management <linux-mm@kvack.org>
Subject: Re: [PATCH/RFC] Shared page tables
Message-ID: <318E5C5091D3BB0EA8F0C497@[10.1.1.4]>
In-Reply-To: <1137543450.27951.4.camel@localhost.localdomain>
References: <A6D73CCDC544257F3D97F143@[10.1.1.4]>	
 <20060117235302.GA22451@lnx-holt.americas.sgi.com>
 <1137543450.27951.4.camel@localhost.localdomain>
X-Mailer: Mulberry/4.0.0b4 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--On Tuesday, January 17, 2006 16:17:30 -0800 Dave Hansen
<haveblue@us.ibm.com> wrote:

> On Tue, 2006-01-17 at 17:53 -0600, Robin Holt wrote:
>> This appears to work on ia64 with the attached patch.  Could you
>> send me any test application you think would be helpful for me
>> to verify it is operating correctly?  I could not get the PTSHARE_PUD
>> to compile.  I put _NO_ effort into it.  I found the following line
>> was invalid and quit trying.
> ...
>> +config PTSHARE
>> +	bool "Share page tables"
>> +	default y
>> +	help
>> +	  Turn on sharing of page tables between processes for large shared
>> +	  memory regions.
> ...
> 
> These are probably best put in mm/Kconfig, especially if you're going to
> have verbatim copies in each architecture.

No, the specific variables that should be set are different per
architecture, and some (most) architectures don't yet support shared page
tables.  It's likely some never will.

Dave McCracken

