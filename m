Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314595AbSD3R1z>; Tue, 30 Apr 2002 13:27:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314685AbSD3R1y>; Tue, 30 Apr 2002 13:27:54 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:32647 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S314595AbSD3R1x>; Tue, 30 Apr 2002 13:27:53 -0400
Date: Tue, 30 Apr 2002 11:26:08 -0700
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: Arjan van de Ven <arjanv@redhat.com>, Dave Hansen <haveblue@us.ibm.com>
cc: Russell King <rmk@arm.linux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: devfs: BKL *not* taken while opening devices
Message-ID: <52760000.1020191168@flay>
In-Reply-To: <20020430125214.A19533@devserv.devel.redhat.com>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> I like the idea.  But, while we're at it, does anyone have a good enough 
>> grasp of locking the the TTY layer that we can start peeling some of the 
>> BKL out of there?  Somebody was doing tests over a serial console here 
>> and the lockmeter data showed horrible BKL contention and hold times.
> 
> I really really doubt that fixing contention will make serial ports go
> faster... it'll just move to another lock since I suspect we're
> just waiting for hardware

No, but it might make other things who are waiting for the BKL go faster.

M.

