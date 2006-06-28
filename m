Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751512AbWF1Rv0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751512AbWF1Rv0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 13:51:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751514AbWF1RvZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 13:51:25 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:47004 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751507AbWF1RvY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 13:51:24 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Andrey Savochkin <saw@swsoft.com>
Cc: dlezcano@fr.ibm.com, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       serue@us.ibm.com, haveblue@us.ibm.com, clg@fr.ibm.com,
       Andrew Morton <akpm@osdl.org>, dev@sw.ru, herbert@13thfloor.at,
       devel@openvz.org, sam@vilain.net, viro@ftp.linux.org.uk,
       Alexey Kuznetsov <alexey@sw.ru>
Subject: Re: Network namespaces a path to mergable code.
References: <20060626134945.A28942@castle.nmd.msu.ru>
	<m14py6ldlj.fsf@ebiederm.dsl.xmission.com>
	<20060627215859.A20679@castle.nmd.msu.ru>
	<m1ejx9kj1r.fsf@ebiederm.dsl.xmission.com>
	<20060628150605.A29274@castle.nmd.msu.ru>
	<m1sllpfckx.fsf@ebiederm.dsl.xmission.com>
	<20060628212240.A1833@castle.nmd.msu.ru>
Date: Wed, 28 Jun 2006 11:50:00 -0600
In-Reply-To: <20060628212240.A1833@castle.nmd.msu.ru> (Andrey Savochkin's
	message of "Wed, 28 Jun 2006 21:22:40 +0400")
Message-ID: <m1veqldvav.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrey Savochkin <saw@swsoft.com> writes:

>> A general pattern that happens in cleanups is the discovery
>> that code using an old interface in a problematic way really
>> could be done much better another way.  I didn't dig enough
>> to see if that was the case in any of the code that you changed.
>
> Well, there is obvious improvement of this kind: many protocols walk over
> device list to find devices with non-NULL protocol specific pointers.
> For example, IPv6, decnet and others do it on module unloading to clean up.
> Those places just ask for some simpler standard way of doing it, but I wasn't
> bold enough for such radical change.
> Do you think I should try?

It probably makes sense to asses that after the patches are split up.
Unless you run into something obvious.

Eric
