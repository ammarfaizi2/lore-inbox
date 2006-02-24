Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932282AbWBXP4v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932282AbWBXP4v (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 10:56:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932283AbWBXP4v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 10:56:51 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:61093 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932282AbWBXP4u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 10:56:50 -0500
To: Rene Herman <rene.herman@keyaccess.nl>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Arjan van de Ven <arjan@linux.intel.com>, Andi Kleen <ak@suse.de>,
       linux-kernel@vger.kernel.org, akpm@osdl.org, mingo@elte.hu
Subject: Re: Patch to reorder functions in the vmlinux to a defined order
References: <1140700758.4672.51.camel@laptopd505.fenrus.org>
	<1140707358.4672.67.camel@laptopd505.fenrus.org>
	<200602231700.36333.ak@suse.de>
	<1140713001.4672.73.camel@laptopd505.fenrus.org>
	<Pine.LNX.4.64.0602230902230.3771@g5.osdl.org>
	<43FE0B9A.40209@keyaccess.nl>
	<Pine.LNX.4.64.0602231133110.3771@g5.osdl.org>
	<43FE1764.6000300@keyaccess.nl>
	<Pine.LNX.4.64.0602231517400.3771@g5.osdl.org>
	<43FE4B00.8080205@keyaccess.nl>
	<m1r75s3kfi.fsf@ebiederm.dsl.xmission.com>
	<43FF26A8.9070600@keyaccess.nl>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Fri, 24 Feb 2006 08:55:21 -0700
In-Reply-To: <43FF26A8.9070600@keyaccess.nl> (Rene Herman's message of "Fri,
 24 Feb 2006 16:30:48 +0100")
Message-ID: <m17j7kda52.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rene Herman <rene.herman@keyaccess.nl> writes:

> Eric W. Biederman wrote:
>
>> The page table trickery is actually the more invasive approach.  I
>> believe for 32 bit kernels the real problem is giving up the identity
>> mapping of low memory.
>
> Yes, you probably don't want to have to specialcase anything there.
>
>> Short of the moving the kernel to end of the address space where
>> vmalloc and the fixmaps are now I don't think there is a reasonable
>> chunk of the address space we can use.
>
> To my handwaving ears end of the address space sounds very good though. Is there
> currently any pressure on VMALLOC_RESERVE (128M)? Teaching the linker appears to
> be a matter of changing __KERNEL_START. That leaves actually mapping ourselves
> there, and... more invasiveness?

__pa stops working on kernel addresses.

> I saw you say you already have some actual relocating patches though?

Yes.  Will post them later today, after I get them rebased against a recent
kernel.

Eric
