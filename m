Return-Path: <linux-kernel-owner+w=401wt.eu-S1751301AbWLLNCj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751301AbWLLNCj (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 08:02:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751302AbWLLNCj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 08:02:39 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:55254 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751301AbWLLNCi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 08:02:38 -0500
Message-ID: <457EA86B.5010407@garzik.org>
Date: Tue, 12 Dec 2006 08:02:35 -0500
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: Josh Boyer <jwboyer@gmail.com>
CC: Linux Kernel <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, jffs-dev@axis.com,
       David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH/RFC] Delete JFFS (version 1)
References: <457EA2FE.3050206@garzik.org> <625fc13d0612120456p1d74663fp21e40ee84a8819bc@mail.gmail.com>
In-Reply-To: <625fc13d0612120456p1d74663fp21e40ee84a8819bc@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.7 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Josh Boyer wrote:
> On 12/12/06, Jeff Garzik <jeff@garzik.org> wrote:
>> I have created the 'kill-jffs' branch of
>> git://git.kernel.org/pub/scm/linux/kernel/git/jgarzik/misc-2.6.git that
>> removes fs/jffs.
>>
>> I argue that you can count the users (who aren't on 2.4) on one hand,
>> and developers don't seem to have cared for it in ages.
>>
>> People are already talking about jffs2 replacements, so I propose we zap
>> jffs in 2.6.21.
> 
> I'm usually all for killing broken code, but JFFS isn't really broken
> is it?  Is there some burden it's causing by being in the kernel at
> the moment?

It's always been the case that we remove Linux kernel code when the 
number of users (and more importantly, developers) drops to near-nil.

Every line of code is one more place you have to audit when code 
changes, one more place to update each time the VFS API is touched.

When it's more likely to get struck by lightning than encounter 
filesystem X on a random hard drive in the field, filesystem X need not 
be in the kernel.

IMO, of course :)

	Jeff



