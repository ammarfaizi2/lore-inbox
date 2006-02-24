Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751029AbWBXNup@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751029AbWBXNup (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 08:50:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751030AbWBXNup
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 08:50:45 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:34468 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751025AbWBXNup (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 08:50:45 -0500
To: Andi Kleen <ak@suse.de>
Cc: Arjan van de Ven <arjan@linux.intel.com>, linux-kernel@vger.kernel.org,
       akpm@osdl.org
Subject: Re: Patch to make the head.S-must-be-first-in-vmlinux order
 explicit
References: <1140700758.4672.51.camel@laptopd505.fenrus.org>
	<200602231442.19903.ak@suse.de> <43FDBF55.3060502@linux.intel.com>
	<200602231514.03001.ak@suse.de>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Fri, 24 Feb 2006 06:49:17 -0700
In-Reply-To: <200602231514.03001.ak@suse.de> (Andi Kleen's message of "Thu,
 23 Feb 2006 15:14:02 +0100")
Message-ID: <m11wxs50ki.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@suse.de> writes:

> On Thursday 23 February 2006 14:57, Arjan van de Ven wrote:
>
>> > (or at least
>> > it shouldn't), but arch/x86_64/boot/compressed/head.S
>> > seems to have the entry address hardcoded. Perhaps you can just change this
>> > to pass in the right address?
>> 
>> the issue is that the address will be a link time thing, which means 
>> lots of complexity.
>
> bzImage image should be only generated after vmlinux is done 
> and then the address should be available with a simple grep in System.map

Andi it is more than that.  At least it was last I payed attention.
There are symbols like stext that various things depend on being early,
at least last time I looked.  So while it is doable it requires some
careful looking.

Eric
