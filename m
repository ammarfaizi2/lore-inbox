Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314383AbSDTApl>; Fri, 19 Apr 2002 20:45:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314393AbSDTApk>; Fri, 19 Apr 2002 20:45:40 -0400
Received: from vestibule.its.caltech.edu ([131.215.48.17]:13793 "EHLO
	vestibule.its.caltech.edu") by vger.kernel.org with ESMTP
	id <S314383AbSDTApj>; Fri, 19 Apr 2002 20:45:39 -0400
Message-ID: <3CC0BA25.7020301@bryanr.org>
Date: Fri, 19 Apr 2002 17:45:25 -0700
From: Bryan Rittmeyer <bryanr@bryanr.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020214
X-Accept-Language: en
MIME-Version: 1.0
To: Jan Slupski <jslupski@email.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Wrong IRQ for USB on Sony Vaio (dmi_scan.c, pci-irq.c)
In-Reply-To: <Pine.LNX.4.21.0204191553110.6667-100000@venus.ci.uw.edu.pl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Slupski wrote:
> I use PCG-FX240 model of Sony Vaio, but I have proofs of other users, 
> that exactly the same problem exists on models:
> FX200, FX220, FX250, FX270, FX290, FX370, FX503, R505JS, R505JL
> These models use Intel's 82801BA controller, and Phoenix bios.

My FX150 is inflicted when using Sony's WinXP or Win2K BIOS.
The WinME BIOS it shipped with was fine... If you need to identify
problematic machines, I don't think the DMI product name check is
going to be sufficient... better match on BIOS revision also.

Note that the ACPI IRQ routing in the recent (20020329 for me)
ACPI patches is an effective workaround as well. It's turned
on by default when you enable ACPI, which you probably want to do
anyway on most of these laptops to get battery status, poweroff
on shutdown, etc.

-Bryan

