Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932220AbWHHGqp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932220AbWHHGqp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 02:46:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932269AbWHHGqp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 02:46:45 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:43461 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932260AbWHHGqo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 02:46:44 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Andi Kleen <ak@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, "Randy.Dunlap" <rdunlap@xenotime.net>,
       "Protasevich, Natalie" <Natalie.Protasevich@unisys.com>,
       linux-kernel@vger.kernel.org, Arjan van de Ven <arjan@infradead.org>
Subject: Re: [PATCH] x86_64:  Auto size the per cpu area.
References: <m1irl4ftya.fsf@ebiederm.dsl.xmission.com>
	<1155005284.3042.11.camel@laptopd505.fenrus.org>
	<m13bc7aidw.fsf_-_@ebiederm.dsl.xmission.com>
	<200608080801.29789.ak@suse.de>
Date: Tue, 08 Aug 2006 00:46:23 -0600
In-Reply-To: <200608080801.29789.ak@suse.de> (Andi Kleen's message of "Tue, 8
	Aug 2006 08:01:29 +0200")
Message-ID: <m1lkpz9134.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@suse.de> writes:

> On Tuesday 08 August 2006 07:47, Eric W. Biederman wrote:
>> 
>> Now for a completely different but trivial approach.
>> I just boot tested it with 255 CPUS and everything worked.
>> 
>> Currently everything (except module data) we place in
>> the per cpu area we know about at compile time.  So
>> instead of allocating a fixed size for the per_cpu area
>> allocate the number of bytes we need plus a fixed constant
>> for to be used for modules.
>> 
>> It isn't perfect but it is much less of a pain to
>> work with than what we are doing now.
>
> Yes makes sense.
>
> However not that particular patch - i already changed that
> code in my tree because I needed really early per cpu for something and
> i had switched to using a static array for cpu0's cpudata.
>
> I will modify it to work like your proposal.

Sounds good to me.


Eric
