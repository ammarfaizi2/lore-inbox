Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262508AbUDECCg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Apr 2004 22:02:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262997AbUDECCg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Apr 2004 22:02:36 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:15494 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262941AbUDECCd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Apr 2004 22:02:33 -0400
Message-ID: <4070BE29.9050305@us.ibm.com>
Date: Sun, 04 Apr 2004 19:02:17 -0700
From: Nivedita Singhvi <niv@us.ibm.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.2.1) Gecko/20021130
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Matt Brown <matt@mattb.net.nz>
CC: marcelo.tosatti@cyclades.com, kernel@linuxace.com,
       linux-kernel@vger.kernel.org, linux-net@vger.kernel.org,
       dlstevens@us.ibm.com, davem@redhat.com
Subject: Re: Kernel panic in 2.4.25
References: <1081129354.1611.44.camel@argon.shr.crc.net.nz>
In-Reply-To: <1081129354.1611.44.camel@argon.shr.crc.net.nz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Brown wrote:

> Was any progress made on this problem?
> 
> I am seeing the same panic as was originally reported using both kernel
> 2.4.25 and 2.4.26-rc1, I can easily reproduce it under the same
> conditions as Hasso described in the original email. 
> 
> With quagga/ospfd running I simply execute
> ifconfig eth0 down
> ifconfig eth0 up 
> in quick succession and a panic follows within 20 seconds. 
> 
> The panic does not occur if ospfd is not running, or if i pause for at
> least 10 seconds between the two commands. 
> 
> Let me know if I can provide any more information that would be helpful
> in solving this problem. 

Could you try applying the following patch:

http://marc.theaimsgroup.com/?l=linux-netdev&m=108079992001559&w=2

thanks,
Nivedita




