Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318760AbSHBJN0>; Fri, 2 Aug 2002 05:13:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318761AbSHBJN0>; Fri, 2 Aug 2002 05:13:26 -0400
Received: from [195.63.194.11] ([195.63.194.11]:18949 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S318760AbSHBJNX>; Fri, 2 Aug 2002 05:13:23 -0400
Message-ID: <3D4A4CD1.5070308@evision.ag>
Date: Fri, 02 Aug 2002 11:11:45 +0200
From: Marcin Dalecki <dalecki@evision.ag>
Reply-To: martin@dalecki.de
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.1b) Gecko/20020722
X-Accept-Language: en-us, en, pl, ru
MIME-Version: 1.0
To: Alexander Viro <viro@math.psu.edu>
CC: Petr Vandrovec <VANDROVE@vc.cvut.cz>, martin@dalecki.de,
       linux-kernel@vger.kernel.org, mingo@elte.hu
Subject: Re: IDE from current bk tree, UDMA and two channels...
References: <Pine.GSO.4.21.0208011850140.12627-100000@weyl.math.psu.edu>
Content-Type: text/plain; charset=US-ASCII;
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Uz.ytkownik Alexander Viro napisa?:
> 
> On Fri, 2 Aug 2002, Petr Vandrovec wrote:
> 
> 
>>>Uh-oh...
>>>
>>>Let me see if I got it straight:
>>>
>>>a) your disk doesn't work with half-Kb requests
>>>b) you have a partition with odd number of sectors
>>>c) hardsect_size is set to half-Kb
>>>d) old code worked since it rounded size to multiple of kilobyte.
>>>
>>>Correct?
>>
>>Yes, exactly. Replacing disk is not an option...
> 
> 
> OK.  At the very least we need a way for driver to tell what the sector
> size is.  And that can be a problem - AFAICS IDE shares the queue for
> master and slave and sector size is queue property.

Wrong. It is sharing the queue lock not the queue itself.

