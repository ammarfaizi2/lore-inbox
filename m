Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129067AbRBGPgG>; Wed, 7 Feb 2001 10:36:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129130AbRBGPf4>; Wed, 7 Feb 2001 10:35:56 -0500
Received: from smtp8.us.dell.com ([143.166.224.234]:5393 "EHLO
	smtp8.us.dell.com") by vger.kernel.org with ESMTP
	id <S129067AbRBGPfq>; Wed, 7 Feb 2001 10:35:46 -0500
Date: Wed, 7 Feb 2001 09:35:38 -0600 (CST)
From: Michael E Brown <michael_e_brown@dell.com>
Reply-To: Michael E Brown <michael_e_brown@dell.com>
To: <linux-kernel@vger.kernel.org>
cc: "Domsch, Matt" <Matt_Domsch@dell.com>
Subject: Re: [RFC][PATCH] block ioctl to read/write last sector
In-Reply-To: <ouplmrimuid.fsf@pigdrop.muc.suse.de>
Message-ID: <Pine.LNX.4.30.0102070926030.26194-100000@blap.linuxdev.us.dell.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7 Feb 2001, Andi Kleen wrote:

> But what happens when you e.g. run a software blocksize of 4096 and the device
> has >1 inaccessible 512 byte sector at the end?
> I think it would be better to pass in a offset in 512 byte units to a special
> ioctl (and do error checking in the driver for impossible requests)

This is a valid point.

Can you tell me how it would come about that we would have a blocksize !=
1024?

Can you show the proposed interface to the new ioctl?

I was limited in that I could only figure out how to get one userspace
char* into/out of the ioctl. How would you propose to pass in the offset?
I had problems finding documentation on the more complicated IOCTL calls,
and since I am a kernel hacking novice, I went the easiest and most direct
route.

If you tell me the proposed interface and some sample code, I can code,
test and resubmit it. Thank you for the feedback.

Michael Brown
Linux System Group
Dell Computer Corp

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
