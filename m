Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273870AbRJTSJb>; Sat, 20 Oct 2001 14:09:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273881AbRJTSJU>; Sat, 20 Oct 2001 14:09:20 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:12037 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S273870AbRJTSJJ>; Sat, 20 Oct 2001 14:09:09 -0400
Message-ID: <3BD1BDD4.2000101@zytor.com>
Date: Sat, 20 Oct 2001 11:09:24 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
Organization: Zytor Communications
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.5) Gecko/20011012
X-Accept-Language: en, sv
MIME-Version: 1.0
To: landley@trommello.org
CC: Timur Tabi <ttabi@interactivesi.com>, linux-kernel@vger.kernel.org
Subject: Re: Allocating more than 890MB in the kernel?
In-Reply-To: <Pine.LNX.4.30.0110191204210.21846-100000@hill.cs.ucr.edu> <9qq0mo$eun$1@cesium.transmeta.com> <3BD08B57.1070604@interactivesi.com> <0110200040570M.15870@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rob Landley wrote:

> 
> Each user process has 32 bit pointers for memory.  This means they only have 
> 4 gigabytes of virtual address space, regardless of how many physical pages 
> the machine has.  The kernel doesn't use segment:offset addressing.  It just 
> uses the offset.  Flat memory model.
> 


And even if it did (on i386) it wouldn't help... the segment:offset is 
folded into a single 32-bit space before paging.

	-hpa


