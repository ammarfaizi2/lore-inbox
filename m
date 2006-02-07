Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030214AbWBGWWV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030214AbWBGWWV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 17:22:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030212AbWBGWWV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 17:22:21 -0500
Received: from watts.utsl.gen.nz ([202.78.240.73]:57501 "EHLO mail.utsl.gen.nz")
	by vger.kernel.org with ESMTP id S1030207AbWBGWWT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 17:22:19 -0500
Message-ID: <43E91D85.6000100@vilain.net>
Date: Wed, 08 Feb 2006 11:21:57 +1300
From: Sam Vilain <sam@vilain.net>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Kirill Korotaev <dev@sw.ru>
Cc: Linus Torvalds <torvalds@osdl.org>, Dave Hansen <haveblue@us.ibm.com>,
       Kirill Korotaev <dev@openvz.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       frankeh@watson.ibm.com, clg@fr.ibm.com, greg@kroah.com,
       alan@lxorguk.ukuu.org.uk, serue@us.ibm.com, arjan@infradead.org,
       Rik van Riel <riel@redhat.com>, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
       Andrey Savochkin <saw@sawoct.com>, devel@openvz.org,
       Pavel Emelianov <xemul@sw.ru>
Subject: Re: [RFC][PATCH 1/5] Virtualization/containers: startup
References: <43E38BD1.4070707@openvz.org>  <Pine.LNX.4.64.0602030905380.4630@g5.osdl.org> <43E3915A.2080000@sw.ru>  <Pine.LNX.4.64.0602030939250.4630@g5.osdl.org> <1138991641.6189.37.camel@localhost.localdomain> <43E61448.7010704@sw.ru> <Pine.LNX.4.64.0602060847130.3854@g5.osdl.org> <43E7E998.2020007@vilain.net> <43E890CB.1060608@sw.ru>
In-Reply-To: <43E890CB.1060608@sw.ru>
X-Enigmail-Version: 0.92.1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kirill Korotaev wrote:
>>> I'd suggest
>>>
>>>     current->container    - the current EFFECTIVE container
>>>     current->master_container - the "long term" container.
>>>
>>> (replace "master" with some other non-S&M term if you want)
>> Hmm.  You actually need a linked list, otherwise you have replaced a one
>> level flat structure with a two level one, and you miss out on some of
>> the applications.  VServer uses a special structure for this.
> 
> Nope! :) This is pointer to current/effective container, which can be 
> anywhere in the hierarchy. list should be inside container struct.

So why store anything other than the effective container in the task?

Sam.
