Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261948AbVCZD4y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261948AbVCZD4y (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Mar 2005 22:56:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261946AbVCZD4y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Mar 2005 22:56:54 -0500
Received: from smtpout.mac.com ([17.250.248.73]:51659 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S261948AbVCZD4q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Mar 2005 22:56:46 -0500
In-Reply-To: <200503260347.AXR12129@mira-sjc5-e.cisco.com>
References: <200503260347.AXR12129@mira-sjc5-e.cisco.com>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <427b3b3fe43412832df380d23113357c@mac.com>
Content-Transfer-Encoding: 7bit
Cc: greg@kroah.com, akpm@osdl.org, linux-kernel@vger.kernel.org,
       "'Chris Wright'" <chrisw@osdl.org>, torvalds@osdl.org
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: Linux 2.6.11.6
Date: Fri, 25 Mar 2005 22:56:39 -0500
To: hzhong@cisco.com
X-Mailer: Apple Mail (2.619.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mar 25, 2005, at 22:47, Hua Zhong wrote:
>>  int bt_sock_unregister(int proto)
>>  {
>> -	if (proto >= BT_MAX_PROTO)
>> +	if (proto < 0 || proto >= BT_MAX_PROTO)
>>  		return -EINVAL;
>
> Just curious: would it be better to say
>
> if ((unsigned int)proto >= BT_MAX_PTORO)

Erm, it _would_ work, but it's _much_ less clear, less typesafe,
and besides, GCC can probably optimize that test anyways.

Cheers,
Kyle Moffett

-----BEGIN GEEK CODE BLOCK-----
Version: 3.12
GCM/CS/IT/U d- s++: a18 C++++>$ UB/L/X/*++++(+)>$ P+++(++++)>$
L++++(+++) E W++(+) N+++(++) o? K? w--- O? M++ V? PS+() PE+(-) Y+
PGP+++ t+(+++) 5 X R? tv-(--) b++++(++) DI+ D+ G e->++++$ h!*()>++$ r  
!y?(-)
------END GEEK CODE BLOCK------


