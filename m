Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129169AbRAZAg2>; Thu, 25 Jan 2001 19:36:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131721AbRAZAgT>; Thu, 25 Jan 2001 19:36:19 -0500
Received: from cmn2.cmn.net ([206.168.145.10]:29814 "EHLO cmn2.cmn.net")
	by vger.kernel.org with ESMTP id <S129169AbRAZAgK>;
	Thu, 25 Jan 2001 19:36:10 -0500
Message-ID: <3A70C669.4090800@valinux.com>
Date: Thu, 25 Jan 2001 17:35:53 -0700
From: Jeff Hartmann <jhartmann@valinux.com>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.2.12-20smp i686; en-US; m18) Gecko/20001107 Netscape6/6.0
X-Accept-Language: en
MIME-Version: 1.0
To: "H. Peter Anvin" <hpa@zytor.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: x86 PAT errata
In-Reply-To: <200101251745.SAA07063@harpo.it.uu.se> <94q9ag$9bs$1@cesium.transmeta.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

H. Peter Anvin wrote:

> Followup to:  <200101251745.SAA07063@harpo.it.uu.se>
> By author:    Mikael Pettersson <mikpe@csd.uu.se>
> In newsgroup: linux.dev.kernel
> 
>> Before people get too exited about the x86 Page Attribute Table ...
>> Does Linux use mode B (CR4.PSE=1) or mode C (CR4.PAE=1) paging?
>> If so, known P6 errata must be taken into account.
>> In particular, Pentium III errata E27 and Pentium II errata A56
>> imply that only the low four PAT entries are working for 4KB
>> pages, if CR4.PSE or CR4.PAE is enabled.
>> 
> 
> 
> All of the above.  Sounds like PAT should be declared broken on these
> chips.
> 
> 	-hpa

We can do set PAT entry one to be write combined.  Currently it doesn't 
look like anyone is using write through page mapping anywhere in the 
kernel (Just PAGE_PWT set).  Am I correct in that assumption?

-Jeff

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
