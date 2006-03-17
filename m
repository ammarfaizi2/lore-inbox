Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751541AbWCQREq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751541AbWCQREq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 12:04:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751492AbWCQREq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 12:04:46 -0500
Received: from out-mta2.ai270.net ([83.244.130.113]:39649 "EHLO
	out-mta1.ai270.net") by vger.kernel.org with ESMTP id S1751480AbWCQREp convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 12:04:45 -0500
In-Reply-To: <441ADD28.3090303@garzik.org>
References: <B6C8687D-6543-42A1-9262-653C4D3C30B2@lougher.org.uk> <20060317104023.GA28927@wohnheim.fh-wedel.de> <C91BFAB7-C442-4EB7-8089-B55BB86EB148@lougher.org.uk> <20060317124310.GB28927@wohnheim.fh-wedel.de> <441ADD28.3090303@garzik.org>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=ISO-8859-1; delsp=yes; format=flowed
Message-Id: <0E3DADA8-1A1C-47C5-A3CF-F6A85FF5AFB8@lougher.org.uk>
Cc: =?ISO-8859-1?Q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Transfer-Encoding: 8BIT
From: Phillip Lougher <phillip@lougher.org.uk>
Subject: Re: [ANN] Squashfs 3.0 released
Date: Fri, 17 Mar 2006 17:04:24 +0000
To: Jeff Garzik <jeff@garzik.org>
X-Mailer: Apple Mail (2.746.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 17 Mar 2006, at 16:00, Jeff Garzik wrote:

> Jörn Engel wrote:
>> On Fri, 17 March 2006 11:16:48 +0000, Phillip Lougher wrote:
>>>> The one still painfully missing is a
>>>> fixed-endianness disk format.
>>>
>>> We had that argument last year.
>> Yes, I remember.  What I don't remember is your opinion on the  
>> matter.
>> Did we reach some sort of conclusion?
>
> Fixed endian isn't necessarily a requirement.  Detectable endian  
> is.  As long as (a) the filesystem mkfs notes the endian-ness and  
> (b) the kernel filesystem code properly handles both types of  
> endian, life is fine.
>
That's what is currently done.  There are two filesystem formats, big  
endian (donated by Squashfs magic of 'sqsh') and little endian  
(denoted by Squashfs magic of 'hsqs').  The kernel code detects the  
filesystem endianness and swaps if necessary.

> For SquashFS, though, I would think that fixed endian would be  
> easy. Since it is byte-packed, just handle endian as you unpack.
>
That's what is currently done.  The data is swapped if necessary at  
unpack time.  Afterwards no further swapping is performed.

Phillip
