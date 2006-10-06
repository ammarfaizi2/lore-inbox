Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422992AbWJFVzT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422992AbWJFVzT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 17:55:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422993AbWJFVzT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 17:55:19 -0400
Received: from terminus.zytor.com ([192.83.249.54]:61319 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1422992AbWJFVzR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 17:55:17 -0400
Message-ID: <4526D084.1030700@zytor.com>
Date: Fri, 06 Oct 2006 14:54:12 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
CC: vgoyal@in.ibm.com, Andrew Morton <akpm@osdl.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Reloc Kernel List <fastboot@lists.osdl.org>, ak@suse.de,
       horms@verge.net.au, lace@jankratochvil.net, magnus.damm@gmail.com,
       lwang@redhat.com, dzickus@redhat.com, maneesh@in.ibm.com
Subject: Re: [PATCH 12/12] i386 boot: Add an ELF header to bzImage
References: <20061003170032.GA30036@in.ibm.com>	<20061003172511.GL3164@in.ibm.com>	<20061003201340.afa7bfce.akpm@osdl.org>	<m1vemzbe4c.fsf@ebiederm.dsl.xmission.com>	<20061004214403.e7d9f23b.akpm@osdl.org>	<m1ejtnb893.fsf@ebiederm.dsl.xmission.com>	<20061004233137.97451b73.akpm@osdl.org>	<m14pui4w7t.fsf@ebiederm.dsl.xmission.com>	<20061005235909.75178c09.akpm@osdl.org>	<m1bqop38nw.fsf@ebiederm.dsl.xmission.com>	<20061006183846.GF19756@in.ibm.com> <4526A66B.4030805@zytor.com> <m1ac49z2fl.fsf@ebiederm.dsl.xmission.com>
In-Reply-To: <m1ac49z2fl.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric W. Biederman wrote:
> "H. Peter Anvin" <hpa@zytor.com> writes:
> 
>> Vivek Goyal wrote:
>>> Hi Eric,
>>> I have added cld in the regenerated patch below.
>> No, the cld needs to be earlier.  It turns out this isn't the first use of
>> string instructions.
> 
> Can we rely on the int calls not setting df?  Otherwise we need to clear
> df at each use as we do with all of the later uses.
> 

Yes, we can, with a few exceptions.  INT saves the flags and IRET 
restores them.

	-hpa
