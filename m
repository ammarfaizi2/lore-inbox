Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318911AbSIKNcb>; Wed, 11 Sep 2002 09:32:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318933AbSIKNcb>; Wed, 11 Sep 2002 09:32:31 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:55044 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S318911AbSIKNca>;
	Wed, 11 Sep 2002 09:32:30 -0400
Message-ID: <3D7F46EE.4040905@mandrakesoft.com>
Date: Wed, 11 Sep 2002 09:36:46 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: steve@neptune.ca, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.20-pre6 tg3 compile errors
References: <Pine.LNX.4.44.0209102218460.3875-100000@triton.neptune.on.ca>	<3D7EAC65.8030101@mandrakesoft.com> <20020911.062510.00773243.davem@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote:
>    From: Jeff Garzik <jgarzik@mandrakesoft.com>
>    Date: Tue, 10 Sep 2002 22:37:25 -0400
>    
>    Wrap this line of code inside a
>    
>    #if TG3_VLAN_TAG_USED
>    ...line 4881 here...
>    #endif
>    
> Not sufficient, you need to have an "#else" clause that
> sets RX_MODE_KEEP_VLAN_TAG all the time.


So IOW what I said was correct, but Steve's patch was wrong :)

You don't need a #else clause because line 4882 sets 
RX_MODE_KEEP_VLAN_TAG unconditionally, if you #ifdef out line 4881.

	Jeff



