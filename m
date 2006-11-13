Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932824AbWKMT2A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932824AbWKMT2A (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 14:28:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932832AbWKMT2A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 14:28:00 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:30429 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932824AbWKMT17 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 14:27:59 -0500
From: ebiederm@xmission.com (Eric W. Biederman)
To: Andi Kleen <ak@suse.de>
Cc: vgoyal@in.ibm.com,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Reloc Kernel List <fastboot@lists.osdl.org>, akpm@osdl.org,
       hpa@zytor.com, magnus.damm@gmail.com, lwang@redhat.com,
       dzickus@redhat.com
Subject: Re: [RFC] [PATCH 2/16] x86_64: Assembly safe page.h and pgtable.h
References: <20061113162135.GA17429@in.ibm.com>
	<20061113162827.GC17429@in.ibm.com> <200611131817.01066.ak@suse.de>
Date: Mon, 13 Nov 2006 12:27:16 -0700
In-Reply-To: <200611131817.01066.ak@suse.de> (Andi Kleen's message of "Mon, 13
	Nov 2006 18:17:00 +0100")
Message-ID: <m1zmavp2p7.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@suse.de> writes:

> On Monday 13 November 2006 17:28, Vivek Goyal wrote:
>> 
>> This patch makes pgtable.h and page.h safe to include
>> in assembly files like head.S.  Allowing us to use
>> symbolic constants instead of hard coded numbers when
>> refering to the page tables.
>
> Hmm, I think the ULs are probably not needed anyways. What
> happens when you just drop them even for C? You shouldn't get any 
> new warnings i hope.

I don't remember the details anymore but there were problems when I
tried by just removing the suffixes.  I think they were
no warnings or possibly promotion problems.

Using _AC is just about as simple as dropping the suffix
and much more maintainable then maintaining multiple definitions.

Eric
