Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263795AbUHGRf3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263795AbUHGRf3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Aug 2004 13:35:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263806AbUHGRf3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Aug 2004 13:35:29 -0400
Received: from ppp3-adsl-39.the.forthnet.gr ([193.92.234.39]:18216 "EHLO
	ppp1-100.the.forthnet.gr") by vger.kernel.org with ESMTP
	id S263795AbUHGRfV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Aug 2004 13:35:21 -0400
From: V13 <v13@priest.com>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
Date: Sat, 7 Aug 2004 20:37:18 +0300
User-Agent: KMail/1.6.82
Cc: mj@ucw.cz, James.Bottomley@steeleye.com, axboe@suse.de,
       linux-kernel@vger.kernel.org
References: <200408071217.i77CHUKm006973@burner.fokus.fraunhofer.de>
In-Reply-To: <200408071217.i77CHUKm006973@burner.fokus.fraunhofer.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-7"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200408072037.23081.v13@priest.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 07 August 2004 15:17, Joerg Schilling wrote:
> From the > 20 platforms that libscg provides abstractions from, _most_
>
> platforms do not allow the "UNIX" /dev/something method to work with
> Generic SCSI:
>
[listt #1]
>
> These are the platforms where /dev/something could work:
>
[list #2]
>
> As you see, the vast majority does not allow the adressing method the
> people on LKML seem to prefer recently.

First of all, you're comparing non-unix to unix operating systems and you're 
trying to create a universal naming scheme. At exactly the same time, those 
operating systems that you're refering to are not able to distinguish between 
two identical USB recorders.

So, lets say for windows, you believe that when having two identical USB CDRs 
plugged in, it is better for the user to refer to them as 1,0,0 and 1,1,0 
instead of K: and L: ? For me none of this makes sense, but I believe that 
the user will prefer the letter naming scheme. 

I believe that X:Y:Z makes sense when dealing with devices that can have an ID 
by attaching a jumper but not for the 2004 devices. 

My point is that you cannot blame linux for beeing correct. The behaviour of 
the OSes that you're describing may be portable but is not user friendly or 
correct (in fact, it can be called broken).

I believe that if you were trying to create a new naming scheme you'd create 
something similar to /udev. You'd use names for devices and let the user or 
other programs associate those names to each hardware device instead of using 
numbers that some times are fixed and some times are changing between each 
boot.

You've created a great tool that is used by almost every non-windows user out 
here and it would be great if you could try to make it more usable and 
'correct'.

<<V13>>
