Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261317AbVCKUfo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261317AbVCKUfo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 15:35:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261284AbVCKUan
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 15:30:43 -0500
Received: from franklin.nevis.columbia.edu ([129.236.252.8]:26753 "EHLO
	franklin.nevis.columbia.edu") by vger.kernel.org with ESMTP
	id S261702AbVCKU0u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 15:26:50 -0500
Date: Fri, 11 Mar 2005 15:26:38 -0500 (EST)
From: Felix Matathias <felix@nevis.columbia.edu>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: select() doesn't respect SO_RCVLOWAT ?
In-Reply-To: <1110568180.17740.69.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.61.0503111434040.30914@shang.nevis.columbia.edu>
References: <Pine.LNX.4.61.0503101645190.29442@shang.nevis.columbia.edu>
 <1110568180.17740.69.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Dear Alan,

I am positive. I can setsockopt, and then, getsockopt returns the value 
that I requested.

Stevens very clearly states that SO_RCVLOWAT has a direct impact on 
select() and I assumed that this would be the case for Linux.
What is the rationale for not complying with that ? Is it the micromanagement
of select() that you dislike ? Isn't a significant reduction in the
amount of read operations a real gain in high speed networking ?

Best Regards,
Felix


On Fri, 11 Mar 2005, Alan Cox wrote:

> On Iau, 2005-03-10 at 21:58, Felix Matathias wrote:
>> Dear all,
>>
>> I am running a 2.4.21-9.0.3.ELsmp #1 kernel and I can setsockopt and
>> getsockopt correctly the SO_RCVLOWAT option
>
> The only value the code at least used to support was setting it to 1.
> Are you sure you are actually setting/checking ok ?
>

-- 

______________________________________________________________________
Felix Matathias of Columbia University, Nevis Labs

Brookhaven National Lab           cell : 631-988-3694
Bldg 1005, 3-304                  web  : http://www.matathias.com
Upton, NY, 11973                  photo: http://www.pbase.com/matathias
tel/fax :631-344-7622/3253        email: felix@nevis.columbia.edu
_______________________________________________________________________

