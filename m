Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266129AbUG1WeG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266129AbUG1WeG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 18:34:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266685AbUG1WdW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 18:33:22 -0400
Received: from ns1.lanforge.com ([66.165.47.210]:2018 "EHLO www.lanforge.com")
	by vger.kernel.org with ESMTP id S266129AbUG1Wa7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 18:30:59 -0400
Message-ID: <4108291D.7000804@candelatech.com>
Date: Wed, 28 Jul 2004 15:30:53 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@redhat.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: PATCH: VLAN support for 3c59x/3c90x
References: <20040728124256.GA31246@devserv.devel.redhat.com> <41081BC4.6040607@candelatech.com> <20040728221554.GA22747@devserv.devel.redhat.com>
In-Reply-To: <20040728221554.GA22747@devserv.devel.redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> On Wed, Jul 28, 2004 at 02:33:56PM -0700, Ben Greear wrote:
> 
>>>Stefan de Konink ported this code from the 2.4 VLAN patches and tested it
>>>extensively. I cleaned up the ifdefs and fixed a problem with bracketing
>>>that made older cards fail.
>>
>>I am sure this will be appreciated by the VLAN users!
>>
>>Also, do you happen to know how large of an MTU these cards
>>can support?
> 
> 
> In VLAN mode they support just the extra VLAN bits, with the length
> checking turned off its either FDDI or jumbo frame size but I don't remember
> which. I think FDDI.

So if you try to configure the MTU to 1504 using ifconfig or whatever,
will that actually work?

One reason I ask is that I saw a report of a bug/issue where it was
not possible to send a raw-packet from user space that is bigger than
the MTU.  This would preclude user-space from generating a VLAN packet
with the extra 4 bytes.  Being able to change the MTU would at least
partially work around this issue.

Ben


-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

