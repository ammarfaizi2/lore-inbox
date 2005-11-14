Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751144AbVKNP1x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751144AbVKNP1x (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 10:27:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751152AbVKNP1x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 10:27:53 -0500
Received: from bay103-f21.bay103.hotmail.com ([65.54.174.31]:7068 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S1751144AbVKNP1w
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 10:27:52 -0500
Message-ID: <BAY103-F21A2AF88D83C3CE3CAEE19DF5A0@phx.gbl>
X-Originating-IP: [68.75.185.20]
X-Originating-Email: [dravet@hotmail.com]
In-Reply-To: <E1EbaZH-0000cM-LC@be1.lrz>
From: "Jason Dravet" <dravet@hotmail.com>
To: 7eggert@gmx.de, adaplas@gmail.com, samuel.thibault@ens-lyon.org,
       torvalds@osdl.org, akpm@osdl.org, davej@redhat.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vgacon: Workaround for resize bug in some chipsets
Date: Mon, 14 Nov 2005 09:27:51 -0600
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
X-OriginalArrivalTime: 14 Nov 2005 15:27:52.0250 (UTC) FILETIME=[FA5471A0:01C5E92F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From: Bodo Eggert <harvested.in.lkml@posting.7eggert.dyndns.org>
>Reply-To: 7eggert@gmx.de
>To: Jason Dravet <dravet@hotmail.com>, adaplas@gmail.com, 
>samuel.thibault@ens-lyon.org, torvalds@osdl.org, akpm@osdl.org, 
>davej@redhat.com, linux-kernel@vger.kernel.org
>Subject: Re: [PATCH] vgacon: Workaround for resize bug in some chipsets
>Date: Mon, 14 Nov 2005 10:24:02 +0100
>
>Jason Dravet <dravet@hotmail.com> wrote:
>
> > When I run stty rows 20 I get a screen of 80x20.  I can see the top 10 
>rows
> > and the bottom 10 rows are invisible.
>
>I asume your VGA indicates that it'll divide it's scanline counter by 2.
>Please add a printk("vgacon: mode=%2.2x\n", mode) before line 512 and 
>report
>the value. A real fix will depend on this value. In the meantime, removing
>the lines 512 and 513 from the original file should be a temporary fix.
>
>--
>Ich danke GMX dafür, die Verwendung meiner Adressen mittels per SPF
>verbreiteten Lügen zu sabotieren.

Here is the result from the printk you requested:
vgacon: mode=a3

I commented out lines 512 and 513 and the problem remains.

Thanks,
Jason


