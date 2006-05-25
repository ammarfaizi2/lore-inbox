Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030262AbWEYQls@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030262AbWEYQls (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 12:41:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030265AbWEYQls
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 12:41:48 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:30111 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1030262AbWEYQlr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 12:41:47 -0400
To: "Magnus Damm" <magnus.damm@gmail.com>
Cc: "Magnus Damm" <magnus@valinux.co.jp>, fastboot@lists.osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [Fastboot] [PATCH 00/03] kexec: Avoid overwriting the current
 pgd (V2)
References: <20060524044232.14219.68240.sendpatchset@cherry.local>
	<20060524225631.GA23291@in.ibm.com>
	<1148522948.5793.98.camel@localhost>
	<m1k68astge.fsf@ebiederm.dsl.xmission.com>
	<1148527837.5793.121.camel@localhost>
	<m17j4aso43.fsf@ebiederm.dsl.xmission.com>
	<aec7e5c30605250029jfab09e4y26556abf8f16628d@mail.gmail.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Thu, 25 May 2006 10:40:48 -0600
In-Reply-To: <aec7e5c30605250029jfab09e4y26556abf8f16628d@mail.gmail.com> (Magnus
 Damm's message of "Thu, 25 May 2006 16:29:00 +0900")
Message-ID: <m1psi2dpm7.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Magnus Damm" <magnus.damm@gmail.com> writes:
>
> Also, I feel that my approach with a valid idt and gdt is more robust.

One of my biggest concerns with the current code is that it is not
sufficiently robust, in the kdump case.  So I am all in favor things
that improve that situation.  At the same time just moving code from C
to assembly doesn't make it more robust, especially when the comments
explaining what the code does don't come along.

>> The big problem was you did several things with a single patch,
>> and that made the review much more difficult than it had to be.
>>
>> Having to check if you correctly modified the page tables, while also
>> having to check for segmentation, and the interrupt descriptor
>> transformations was distracting.
>
> Let me know which parts you think are good and we will implement and
> review them bit by bit instead then.

Skip the infrastructure changes, and the rest looks like real
possibilities.

Eric
