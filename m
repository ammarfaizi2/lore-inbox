Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750982AbWHPN7Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750982AbWHPN7Y (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 09:59:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750988AbWHPN7Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 09:59:24 -0400
Received: from xsmtp1.ethz.ch ([82.130.70.13]:9850 "EHLO xsmtp1.ethz.ch")
	by vger.kernel.org with ESMTP id S1750971AbWHPN7X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 09:59:23 -0400
Message-ID: <44E324B5.4090005@debian.org>
Date: Wed, 16 Aug 2006 15:59:17 +0200
From: "Giacomo A. Catenazzi" <cate@debian.org>
User-Agent: Thunderbird 1.5.0.5 (Windows/20060719)
MIME-Version: 1.0
To: "Giacomo A. Catenazzi" <cate@debian.org>,
       David Miller <davem@davemloft.net>, 7eggert@gmx.de,
       7eggert@elstempel.de, shemminger@osdl.org, mitch.a.williams@intel.com,
       netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: bonding: cannot remove certain named devices
References: <6KfTz-OX-11@gated-at.bofh.it> <6KfTA-OX-15@gated-at.bofh.it> <E1GD8rX-0001cA-CV@be1.lrz> <20060815.171002.104028951.davem@davemloft.net> <44E2BC9C.1000101@debian.org> <20060816133811.GA26471@nostromo.devel.redhat.com>
In-Reply-To: <20060816133811.GA26471@nostromo.devel.redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 16 Aug 2006 13:59:21.0736 (UTC) FILETIME=[2C9D9080:01C6C13C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bill Nottingham wrote:
> Giacomo A. Catenazzi (cate@debian.org) said: 
>>> Are you willing to work to add the special case code necessary to
>>> handle whitespace characters in the device name over all of the kernel
>>> code and also all of the userland tools too?
>> But if you don't handle spaces in userspace, you handle *, ?, [, ], $,
>> ", ', \  in userspace? Should kernel disable also these (insane device
>> chars) chars?
> 
> Don't forget unicode characters!
> 
> Seriously, while it might be insane to use some of these, I'm wondering
> if trying to filter names is more work than fixing the tools.

Fixing tools in always the good approach, and I think in this case wrong
code is really a security problem. IMHO kernel cannot filter all bad 
strings.
So, if for the kernel part it is better to filter spaces, ok!
But we should use this user space problems as the motivation to filter
names.

ciao
	cate

