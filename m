Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263130AbTC1UgQ>; Fri, 28 Mar 2003 15:36:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263133AbTC1UgQ>; Fri, 28 Mar 2003 15:36:16 -0500
Received: from [12.47.58.223] ([12.47.58.223]:60518 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id <S263130AbTC1UgP>; Fri, 28 Mar 2003 15:36:15 -0500
Date: Fri, 28 Mar 2003 12:48:32 -0800
From: Andrew Morton <akpm@digeo.com>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 3c59x gives HWaddr FF:FF:...
Message-Id: <20030328124832.44243f83.akpm@digeo.com>
In-Reply-To: <20030328145159.GA4265@werewolf.able.es>
References: <20030328145159.GA4265@werewolf.able.es>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 28 Mar 2003 20:47:27.0060 (UTC) FILETIME=[3E04C140:01C2F56B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"J.A. Magallon" <jamagallon@able.es> wrote:
>
> Hi all...
> 
> I have just switched the network card for my internal network from a 8139
> to a 3c905C-TX/TX-M. The 3c59x driver gives the buggy FF:FF:FF:FF:FF:FF
> hardware address for the adapter. I had heard about the problem and looked
> throug LKML archives, but they just point to a non existen web page.
> I use 2.4.21-pre6+aa.
> 
> What happens ? Any solution available ?
> 

The eeprom wasn't powered up.

Please take the 2.4.20 3c59x.c and place that into the 2.5 tree and confirm
that it does the same thing (it will).

Then try disabling APCI and/or otherwise fiddling with your power management
options (maybe in BIOS too).

One person has reported that turning off ACPI fixed this.

Thanks.
