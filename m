Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271540AbTGQVJS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 17:09:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271543AbTGQVJS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 17:09:18 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:4268 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S271532AbTGQVJH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 17:09:07 -0400
Message-ID: <3F1713E5.6020206@pobox.com>
Date: Thu, 17 Jul 2003 17:23:49 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Mike Fedyk <mfedyk@matchmail.com>
CC: Dave Jones <davej@codemonkey.org.uk>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.5 'what to expect'
References: <20030711140219.GB16433@suse.de> <3F170D0F.7070304@pobox.com> <20030717211623.GA2289@matchmail.com>
In-Reply-To: <20030717211623.GA2289@matchmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Fedyk wrote:
> On Thu, Jul 17, 2003 at 04:54:39PM -0400, Jeff Garzik wrote:
> 
>>Another one:
>>
>>rmmod on net drivers no longer produces the behavior that's existed 
>>since modules were first added to the kernel.
> 
> 
> And that new behaviour is?


No reference counts reported to module subsystem at all, so, you can 
rmmod a module at any time, even if the interface is up and running.

Even though net devices are independently refcounted and internally 
consistent, I have no idea if the module's code is refcounted elsewhere 
or not.  So, I hope it's safe...

	Jeff



