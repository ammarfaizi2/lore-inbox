Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311354AbSCLVwH>; Tue, 12 Mar 2002 16:52:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311355AbSCLVvr>; Tue, 12 Mar 2002 16:51:47 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:39436 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S311354AbSCLVvh>; Tue, 12 Mar 2002 16:51:37 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: IO stats in /proc/partitions
Date: 12 Mar 2002 13:51:15 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <a6lt8j$md6$1@cesium.transmeta.com>
In-Reply-To: <3C8E1FFF.9090705@linkvest.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2002 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <3C8E1FFF.9090705@linkvest.com>
By author:    Jean-Eric Cuendet <jean-eric.cuendet@linkvest.com>
In newsgroup: linux.dev.kernel
>
> Hi,
> I use 2.4.19-pre2-ac4.
> 2 questions:
> - Either MD Raid ot LVM IO devices are not accounted in /proc/partitions 
> IO data. Is it normal?
> - Are the new /proc/partitions IO stats integrated in 2.4.19-pre3?
> 

If we're adding fields to /proc/partitions, I would like to
*strongly* recommend that /proc/partitions adds the following
information:

	offset and length
	parent device (if applicable)

The latter could also be used to identify parallelizable devices
(spindles) for things like fsck.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
