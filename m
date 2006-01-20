Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750966AbWATRME@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750966AbWATRME (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 12:12:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750939AbWATRME
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 12:12:04 -0500
Received: from ns2.lanforge.com ([66.165.47.211]:222 "EHLO ns2.lanforge.com")
	by vger.kernel.org with ESMTP id S1750930AbWATRL7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 12:11:59 -0500
Message-ID: <43D119CF.9040805@candelatech.com>
Date: Fri, 20 Jan 2006 09:11:43 -0800
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.12) Gecko/20050922 Fedora/1.7.12-1.3.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Peter Staubach <staubach@redhat.com>
CC: Trond Myklebust <trond.myklebust@fys.uio.no>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Can you specify a local IP or Interface to be used on a per NFS
 mount basis?
References: <43CECB00.40405@candelatech.com>	 <1137631728.13076.1.camel@lade.trondhjem.org>	 <43CEF7A6.30802@candelatech.com>	 <1137641084.8864.3.camel@lade.trondhjem.org>	 <43CF0768.60703@candelatech.com> <1137644698.8864.8.camel@lade.trondhjem.org> <43D06687.2050108@candelatech.com> <43D0EB32.5050909@redhat.com>
In-Reply-To: <43D0EB32.5050909@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Staubach wrote:

> These changes are very IPv4 specific.  Perhaps they could be constructed 
> in a
> bit more IP version agnostic fashion?  IPv6 is coming as well as other 
> transport
> choices, not all of whose addresses will fit into 32 bits.

Sure..it'd be best to pass in a generic structure that can hold
ipv4 or v6 address and port.  But, I have no setup to test ipv6,
don't need to specify the port, and this patch can't go in anyway
because Trond doesn't want to change the binary structure....

If we go to a text base API, could just pass it in as "IP:port"
and let the kernel parsing logic decide if it's IPv4, v6 or something
else...  Of course, it sure is nice to leave all the parsing logic
in user-space, but then you're back to a binary API...

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

