Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285725AbRLHB3T>; Fri, 7 Dec 2001 20:29:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285733AbRLHB3J>; Fri, 7 Dec 2001 20:29:09 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:23301 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S285725AbRLHB26>; Fri, 7 Dec 2001 20:28:58 -0500
Message-ID: <3C116CC6.2030808@zytor.com>
Date: Fri, 07 Dec 2001 17:28:38 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
Organization: Zytor Communications
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20010913
X-Accept-Language: en, sv
MIME-Version: 1.0
To: mjustice@austin.rr.com
CC: linux-kernel@vger.kernel.org
Subject: Re: highmem question
In-Reply-To: <Pine.LNX.4.30.0112071404280.29154-100000@mustard.heime.net> <9url8t$nmo$1@cesium.transmeta.com> <01120719300102.00764@bozo>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marvin Justice wrote:

> 
> While it certainly makes sense to expect a performance hit for mem above 4GB 
> on 32 bit systems I don't see why there should be any a priori reason to 
> either move to 64 bit or take a performance hit for if you need, say,  2GB of 
> RAM. The problem is that 2.4 Linux considers HIGHMEM to be anything above 
> 896MB. 
> 


The problem is that in the x86 architecture you don't have any reasonable
way of addressing the physical address space, so you need to map it into
the virtual address space.  You end up with a shortage of virtual address
space.

> 
>>From what I've read it looks like there will be changes in 2.5 to fix all 
> this.
> 


There is no way of fixing it.


