Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310288AbSCGLRD>; Thu, 7 Mar 2002 06:17:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310285AbSCGLQx>; Thu, 7 Mar 2002 06:16:53 -0500
Received: from idefix.linkvest.com ([194.209.53.99]:56337 "EHLO
	idefix.linkvest.com") by vger.kernel.org with ESMTP
	id <S310288AbSCGLQh>; Thu, 7 Mar 2002 06:16:37 -0500
Message-ID: <3C874C00.8080309@linkvest.com>
Date: Thu, 07 Mar 2002 12:16:16 +0100
From: Jean-Eric Cuendet <jean-eric.cuendet@linkvest.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020205
X-Accept-Language: en-us
MIME-Version: 1.0
To: mingming cao <cmm@us.ibm.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Rework of /proc/stat
In-Reply-To: <3C86553E.3070608@linkvest.com> <E16ik6y-0008Qf-00@the-village.bc.nu> <3C86BEB0.4090203@us.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 07 Mar 2002 11:16:17.0018 (UTC) FILETIME=[8007D5A0:01C1C5C9]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Basically, statistic data are moved from the global kstat structure to 
> the request_queue structures, and it is allocated/freed when the 
> request queue is initialized and freed.  This way it is
>
Why do you dynamically allocate the stat structure? Wouldn't it be 
better static in the request struct?
You don't win anything with that since is you create the queue, it's to 
be accessed, so the struct will be allocated ASAP.
No?

-- 
Jean-Eric Cuendet
Linkvest SA
Av des Baumettes 19, 1020 Renens Switzerland
Tel +41 21 632 9043  Fax +41 21 632 9090
E-mail: jean-eric.cuendet@linkvest.com
http://www.linkvest.com
--------------------------------------------------------



