Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262144AbVCJG7N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262144AbVCJG7N (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 01:59:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262064AbVCJG7N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 01:59:13 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:40673 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S262144AbVCJG7I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 01:59:08 -0500
To: Vivek Goyal <vgoyal@in.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, gdb <gdb@sources.redhat.com>,
       Dave Anderson <anderson@redhat.com>,
       lkml <linux-kernel@vger.kernel.org>, fastboot <fastboot@lists.osdl.org>
Subject: Re: [Fastboot] Re: Query: Kdump: Core Image ELF Format
References: <1110286210.4195.27.camel@wks126478wss.in.ibm.com>
	<m1br9um313.fsf@ebiederm.dsl.xmission.com>
	<1110350629.31878.7.camel@wks126478wss.in.ibm.com>
	<m1ll8wlx82.fsf@ebiederm.dsl.xmission.com>
	<1110430955.3574.11.camel@wks126478wss.in.ibm.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 09 Mar 2005 23:56:04 -0700
In-Reply-To: <1110430955.3574.11.camel@wks126478wss.in.ibm.com>
Message-ID: <m1br9skn0b.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vivek Goyal <vgoyal@in.ibm.com> writes:

> I want to fill the virtual addresses of linearly mapped region. That is
> physical addresses from 0 to MAXMEM (896 MB) are mapped by kernel at
> virtual addresses PAGE_OFFSET to (PAGE_OFFSET + MAXMEM). Values of
> PAGE_OFFSET and MAXMEM are already known and hard-coded.

PAGE_OFFSET has a common value of 0xc0000000, on x86.  However
that value is by no means fixed.  The 4G/4G split changes it
as do some other patches floating around at the time.
On x86-64 I don't know how stable those kinds of offsets are.
 
> I think I used the terminology kernel virtual address and that is adding
> to the confusion. Kernel virtual addresses are not necessarily linearly
> mapped. What I meant was kernel logical addresses whose associated
> physical addresses differ only by a constant offset.

I know what you meant.  I simply meant that things don't look that
constant to me.  Especially in Linux where there are enough people
to try most of the reasonable possibilities.

I don't even think it is a bad idea.  But I do think we have a different
idea of what is constant.

Eric
