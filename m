Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264530AbTH2LqW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Aug 2003 07:46:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264533AbTH2LqW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Aug 2003 07:46:22 -0400
Received: from user-0cal2fl.cable.mindspring.com ([24.170.137.245]:32676 "EHLO
	bender.davehollis.com") by vger.kernel.org with ESMTP
	id S264530AbTH2LqR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Aug 2003 07:46:17 -0400
Message-ID: <3F4F3D18.4010804@davehollis.com>
Date: Fri, 29 Aug 2003 07:46:32 -0400
From: David T Hollis <dhollis@davehollis.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: arjanv@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: We have ethtool_ops, any thoughts on miitool_ops?
References: <3F4EB6F4.3010007@davehollis.com>	<1062147016.4999.0.camel@laptop.fenrus.com> <20030829041629.69a3be62.davem@redhat.com>
In-Reply-To: <20030829041629.69a3be62.davem@redhat.com>
X-Enigmail-Version: 0.76.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote:

>On Fri, 29 Aug 2003 10:50:17 +0200
>Arjan van de Ven <arjanv@redhat.com> wrote:
>
>  
>
>>On Fri, 2003-08-29 at 04:14, David T Hollis wrote:
>>    
>>
>>>If a driver is converted to use ethtool_ops, it does not seem to have 
>>>the ability to support mii-tool any longer.  RedHat uses mii-tool to 
>>>check for link before running dhclient so that you don't have to wait 
>>>forever for dhclient to timeout if the connection is down (laptops, 
>>>etc). 
>>>      
>>>
>>this is legacy; the road to the future for this is ethtool + the link
>>status change notification stuff 
>>    
>>
>
>Besides, the original claim is false.  You can still support all
>the other ioctls however you want, even the MII ones, after
>enabling ethtool_ops in a driver.
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>  
>
Thanks for the pointer.  I didn't realize I could still have the old 
ioctl handler and just not worry about the ethool portion of it. 

