Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266879AbUJIOI2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266879AbUJIOI2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Oct 2004 10:08:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266885AbUJIOI2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Oct 2004 10:08:28 -0400
Received: from postfix4-1.free.fr ([213.228.0.62]:19137 "EHLO
	postfix4-1.free.fr") by vger.kernel.org with ESMTP id S266879AbUJIOI0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Oct 2004 10:08:26 -0400
Message-ID: <4167F0D7.3020502@free.fr>
Date: Sat, 09 Oct 2004 16:08:23 +0200
From: Eric Valette <eric.valette@free.fr>
Reply-To: eric.valette@free.fr
Organization: HOME
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20041007 Debian/1.7.3-5
X-Accept-Language: en
MIME-Version: 1.0
To: Albert Cahalan <albert@users.sf.net>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Inconsistancies in /proc (status vs statm) leading to wrong	documentation
 (proc.txt)
References: <1097329771.2674.4036.camel@cube>
In-Reply-To: <1097329771.2674.4036.camel@cube>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Albert Cahalan wrote:

> The documentation is incorrect. It was written to match a buggy
> implementation in early 2.6.x kernels.

Well the Documentation is said to matches 2.6.8-rc3 and is only 5 weeks 
old according to bitkeeper changesets... So at least the doc should be 
fixed.

> VmSize is the address space occupied, excluding memory-mapped IO.
> The statm value is the address space occupied.

Why removing memory-mapped IO in one case (status) and not the other 
(statm)? Memory mapped IO, may of course reserve some physical memory 
pages for establishing the mmu->phys adress translation table (if any) 
but not really the amount of space mapped.

>>May I suggest :
>> - To use consistent memory size units between status and statm,

> No way. This would instantly break the "top" program.

OK. Too bad because statm is hardly readable but I guess it is not for 
human then...

Thanks for responding,

-- eric

