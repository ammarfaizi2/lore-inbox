Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262049AbUCaQXK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Mar 2004 11:23:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262051AbUCaQXK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Mar 2004 11:23:10 -0500
Received: from ext.lri.fr ([129.175.15.4]:49355 "EHLO newext.lri.fr")
	by vger.kernel.org with ESMTP id S262049AbUCaQXG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Mar 2004 11:23:06 -0500
Date: Wed, 31 Mar 2004 17:57:52 +0200
From: Ignacy Gawedzki <Ignacy.Gawedzki@lri.fr>
To: usagi-users@linux-ipv6.org
Cc: David Stevens <dlstevens@us.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: (usagi-users 02872) Re: IPv6 multicast in 2.4.25 broken?
Message-ID: <20040331175752.A16121@qubit.lri.fr>
References: <20040324185243.GB27409@zenon.mine.nu> <OFE1BE522F.02DB03E7-ON88256E67.00767AD5-88256E67.0077576D@us.ibm.com> <20040331084053.GA25253@zenon.mine.nu> <20040331220129.d245fc9%hibi665@oki.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20040331220129.d245fc9%hibi665@oki.com>; from hibi665@oki.com on Wed, Mar 31, 2004 at 10:01:29PM +0900
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 31, 2004 at 10:01:29PM +0900, thus spake Takashi Hibi:
> Isn't it related to the patch (usagi-users 02627)?
> http://www2.linux-ipv6.org/ml/usagi-users/msg02626.html
> 
> If the socket is bound to non-multicast address, it can't receive
> multicast packets.

This is why it doesn't work anymore, as it shouldn't have in the first
place.  Thanks for pointing this out.  I did not know that source
address selection is automatic, depending on the multicast address
prefix (ff05::/16, ff02::/16, etc) and the IPV6_MULTICAST_IF option, so
I instinctively did bind the socket to the unicast address and not the
multicast address.

Now it seems to work like a charm. =)

Thanks,

Ignacy

-- 
To err is human, to moo bovine.
