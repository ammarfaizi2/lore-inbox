Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290120AbSBYUVy>; Mon, 25 Feb 2002 15:21:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287565AbSBYUVp>; Mon, 25 Feb 2002 15:21:45 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:12554 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S289844AbSBYUVZ>;
	Mon, 25 Feb 2002 15:21:25 -0500
Message-ID: <3C7A9C75.F6A4BA05@zip.com.au>
Date: Mon, 25 Feb 2002 12:20:05 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18-rc2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: christophe =?iso-8859-1?Q?barb=E9?= 
	<christophe.barbe.ml@online.fr>
CC: linux-pm-devel@lists.sourceforge.net, lkml <linux-kernel@vger.kernel.org>
Subject: Re: suspend/resume and 3c59x
In-Reply-To: <20020225200056.GW12719@ufies.org>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

christophe barbé wrote:
> 
> Hi,
> 
> I use the kernel 2.4.17 and the hotplug facilities for my 3com cardbus
> (driver 3c59x). It works well when I insert and remove the card.
> But If I don't remove the card before suspending (apm -s) my laptop,
> The card is in a bad state when I resume the laptop and I need to remove
> and insert the card to get it back. I have tried to ifdown and rmmod
> before suspending but the result is the same.
> 

Did you provide the `enable_wol=1' module parameter?

	options 3c59x enable_wol=1

Despite its name, this turns on some power management
functionality.  Should have been a separate "enable_pm".

-
