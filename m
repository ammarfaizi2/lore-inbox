Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751167AbWJEGtx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751167AbWJEGtx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 02:49:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751515AbWJEGtx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 02:49:53 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:17339 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751167AbWJEGtw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 02:49:52 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Andrew Morton <akpm@osdl.org>
Cc: vgoyal@in.ibm.com,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Reloc Kernel List <fastboot@lists.osdl.org>, ak@suse.de,
       horms@verge.net.au, lace@jankratochvil.net, hpa@zytor.com,
       magnus.damm@gmail.com, lwang@redhat.com, dzickus@redhat.com,
       maneesh@in.ibm.com
Subject: Re: [PATCH 12/12] i386 boot: Add an ELF header to bzImage
References: <20061003170032.GA30036@in.ibm.com>
	<20061003172511.GL3164@in.ibm.com>
	<20061003201340.afa7bfce.akpm@osdl.org>
	<m1vemzbe4c.fsf@ebiederm.dsl.xmission.com>
	<20061004214403.e7d9f23b.akpm@osdl.org>
	<m1ejtnb893.fsf@ebiederm.dsl.xmission.com>
	<20061004233137.97451b73.akpm@osdl.org>
Date: Thu, 05 Oct 2006 00:48:10 -0600
In-Reply-To: <20061004233137.97451b73.akpm@osdl.org> (Andrew Morton's message
	of "Wed, 4 Oct 2006 23:31:37 -0700")
Message-ID: <m1vemz9s2d.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> writes:

> On Thu, 05 Oct 2006 00:13:12 -0600
> ebiederm@xmission.com (Eric W. Biederman) wrote:
>
>> Do things work better if you don't specify a vga=xxx mode?
>
> yes, without vga=0x263 it boots.

Ok.  It will take some digging but I suspect the problem is
that video.S is using a table or a variable placed over the original
boot sector, and expecting it to be zero initialized. 

Finding that in the pile of 2000 lines of assembly could take a
little while.

Now at least we have something other people can try and reproduce
this problem with.

Eric
