Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269010AbUIXWaY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269010AbUIXWaY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 18:30:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269023AbUIXWaY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 18:30:24 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:197 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S269010AbUIXWaV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 18:30:21 -0400
Message-ID: <41549FEF.30008@pobox.com>
Date: Fri, 24 Sep 2004 18:30:07 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Chris Wright <chrisw@osdl.org>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: mlock(1)
References: <41547C16.4070301@pobox.com> <20040924132247.W1973@build.pdx.osdl.net> <1096060045.10800.4.camel@localhost.localdomain> <20040924151906.X1924@build.pdx.osdl.net>
In-Reply-To: <20040924151906.X1924@build.pdx.osdl.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wright wrote:
> * Alan Cox (alan@lxorguk.ukuu.org.uk) wrote:
> 
>>On Gwe, 2004-09-24 at 21:22, Chris Wright wrote:
>>
>>>Hard to say if it's a policy decision outside the scope of the app.
>>>Esp. if the app knows it needs to not be swapped.  Either something that
>>>has realtime needs, or more specifically, privacy needs.  Don't need to
>>>mlock all of gpg to ensure key data never hits swap.
>>
>>Keys are a different case anyway. We can swap them if we have encrypted
>>swap (hardware or software) and we could use the crypto lib just to
>>crypt some pages in swap although that might be complex. As such a
>>MAP_CRYPT seems better than mlock. If we don't have cryptable swap then
>>fine its mlock.
> 
> 
> Yeah, sounds nice.  This is still very much an app specific policy, not
> something that a helper such as mlock(1) would solve.

It's all app-specific policy.  mlock(1) allows the sysadmin to apply 
app-specific policy on top of whatever app-specific policy the engineer 
has chosen to hardcode into his app.

A smart sysadmin that knows the working set of his _local configuration_ 
of a given app is sometimes in a better position to make a decision 
about mlockall(2) than the engineer.

	Jeff



