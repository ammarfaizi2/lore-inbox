Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310328AbSCGNx6>; Thu, 7 Mar 2002 08:53:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310329AbSCGNxs>; Thu, 7 Mar 2002 08:53:48 -0500
Received: from idefix.linkvest.com ([194.209.53.99]:44294 "EHLO
	idefix.linkvest.com") by vger.kernel.org with ESMTP
	id <S310328AbSCGNxe>; Thu, 7 Mar 2002 08:53:34 -0500
Message-ID: <3C8770D5.3040108@linkvest.com>
Date: Thu, 07 Mar 2002 14:53:25 +0100
From: Jean-Eric Cuendet <jean-eric.cuendet@linkvest.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020205
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Rework of /proc/stat
In-Reply-To: <E16iyHy-0002Ij-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 07 Mar 2002 13:53:25.0592 (UTC) FILETIME=[73E60D80:01C1C5DF]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

So, what could be said is that the sard (which IS in 2.4.19-per1-ac2) 
has features:
- all devices available (not only major < 16)
- stat struct is in the request_queue, not in kstat anymore
- All structs are dynamic, no static allocation of per-device structs.
So, it's all we need.

The only drawback is:
- infos are in /proc/partitions not in /proc/stat (some apps get infos 
there...)

Right?
-jec

PS: When will it be in official tree? An idea?

Alan Cox wrote:

>>>Any reason for preferring this over the sard patches in -ac ?
>>>
>>Basically, statistic data are moved from the global kstat structure to 
>>the request_queue structures, and it is allocated/freed when the request 
>>queue is initialized and freed.  This way it is
>>
>
>So does sard
>

-- 
Jean-Eric Cuendet
Linkvest SA
Av des Baumettes 19, 1020 Renens Switzerland
Tel +41 21 632 9043  Fax +41 21 632 9090
E-mail: jean-eric.cuendet@linkvest.com
http://www.linkvest.com
--------------------------------------------------------



