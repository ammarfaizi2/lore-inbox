Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313293AbSEYC7O>; Fri, 24 May 2002 22:59:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313299AbSEYC7N>; Fri, 24 May 2002 22:59:13 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:63423 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S313293AbSEYC7M>;
	Fri, 24 May 2002 22:59:12 -0400
Date: Fri, 24 May 2002 19:59:03 -0700 (PDT)
From: Nivedita Singhvi <niv@us.ibm.com>
X-X-Sender: <nivedita@w-nivedita2.des.beaverton.ibm.com>
To: <cfriesen@nortelnetworks.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: how to get per-socket stats on udp rx buffer overflow?
Message-ID: <Pine.LNX.4.33.0205241949360.2424-100000@w-nivedita2.des.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Is there any way for me to see how many incoming packets 
> were dropped on a udp socket due to overflowing the input buffer?  
> I specifically want this information on a per-socket basis.

The /proc/net/snmp Udp counter InErrors includes the global
count. It would be expensive and usually unnecessary to keep
per-socket stats. Is there a real need for seeing the 
per-socket count?

If it helps, you can check the current bytes in the recv queue
in netstat output - you wont know how many bytes have been dropped,
but at least you know the amnt in the queue waiting to be read..

> Chris

thanks,
Nivedita

