Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933400AbWF0LOw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933400AbWF0LOw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 07:14:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933404AbWF0LOw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 07:14:52 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:15235 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S933398AbWF0LOu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 07:14:50 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Kirill Korotaev <dev@sw.ru>
Cc: Andrey Savochkin <saw@swsoft.com>, dlezcano@fr.ibm.com,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org, serue@us.ibm.com,
       haveblue@us.ibm.com, clg@fr.ibm.com, Andrew Morton <akpm@osdl.org>,
       herbert@13thfloor.at, devel@openvz.org, sam@vilain.net,
       viro@ftp.linux.org.uk
Subject: Re: [RFC][patch 1/4] Network namespaces: cleanup of dev_base list use
References: <20060626134945.A28942@castle.nmd.msu.ru>
	<m1odwguez3.fsf@ebiederm.dsl.xmission.com> <44A0D755.5090204@sw.ru>
Date: Tue, 27 Jun 2006 05:13:28 -0600
In-Reply-To: <44A0D755.5090204@sw.ru> (Kirill Korotaev's message of "Tue, 27
	Jun 2006 10:59:33 +0400")
Message-ID: <m11wtaonqf.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kirill Korotaev <dev@sw.ru> writes:

>>>Cleanup of dev_base list use, with the aim to make device list per-namespace.
>>>In almost every occasion, use of dev_base variable and dev->next pointer
>>>could be easily replaced by for_each_netdev loop.
>>>A few most complicated places were converted to using
>>>first_netdev()/next_netdev().
>> As a proof of concept patch this is ok.
>> As a real world patch this is much too big, which prevents review.
>> Plus it takes a few actions that are more than replace just
>> iterators through the device list.
> Mmm, actually it is a whole changeset and should go as a one patch. I didn't
> find it to be big and my review took only 5-10mins..
> I also don't think that mailing each driver maintainer is a good idea.
> Only if we want to make some buzz :)

Thanks for supporting my case.  You reviewed it and missed the obvious typo.
I do agree that a patchset doing it all should happen at once.

As for not mailing the maintainers of the code we are changing.  That
would just be irresponsible.

Eric
