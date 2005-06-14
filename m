Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261386AbVFNW3D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261386AbVFNW3D (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Jun 2005 18:29:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261387AbVFNW3D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Jun 2005 18:29:03 -0400
Received: from alpha.polcom.net ([217.79.151.115]:19171 "EHLO alpha.polcom.net")
	by vger.kernel.org with ESMTP id S261386AbVFNW27 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Jun 2005 18:28:59 -0400
Date: Wed, 15 Jun 2005 00:28:53 +0200 (CEST)
From: Grzegorz Kulewski <kangur@polcom.net>
To: John Duthie <beyondgeek@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: SATA - SCSI Partition limit
In-Reply-To: <b0fbeec4050614151973f0eec7@mail.gmail.com>
Message-ID: <Pine.LNX.4.63.0506150026280.7125@alpha.polcom.net>
References: <b0fbeec4050614151973f0eec7@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Jun 2005, John Duthie wrote:

> Problem:
>     Need to simulate CDs shares on a linux/samba File server... has a
> 120 GB SATA drive in there ...
>
> ( linux-2.6.10 )
>
> long story ...
>      Shares had the wrong size for the evil VB program
>     (Tried mounting *.iso via loopbak - it didn't like it )
>     Windows boxes that work just have lots of 700 mb partitions  ( 4
> x extended with 6 or 7 logical in each )
>     SO i thought "I know I'll just make lots of partitions"  oops ,
> SCSI sub system only allows 15 Drives
>  So now I could "Boot 2.6.11ac7 on it and specify the boot option
> "all-generic-ide" " which worked wonders last time i had a problem
> (Thanks Alan) because ide will allow more than 15 partitions.
>  But the machine is now about 500 km away from me and changing a
> linux system to boot from scsi to ide over ssh is not my idea of fun,
> 1 typo and I've got a long drive ahead :-(,
>  are there any hard reasions for the 15 partition limit on scsi (
> other than lots of dev files )
>
>  how much work would a patch to halve the number of /dev/sd? files
> and double the /dev/sd?[12]? files ( same number of devices
> minor/major ) ?
>
> I'm sure this will be a problem more people have as the SATA drives
> get bigger.......

Use device-mapper or some tool that uses it (evms). You will be able to 
have really big amount of partitions on SCSI or SATA drive. I used about 
30 partitions once. You make them normally with fdisk and then at boot 
evms will take care of them. Just remember to use /dev/evms/sdaxx instead 
of /dev/sdaxx.


Grzegorz Kulewski

