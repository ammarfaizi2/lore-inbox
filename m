Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266631AbUAWSqE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jan 2004 13:46:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266634AbUAWSqE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jan 2004 13:46:04 -0500
Received: from fw.osdl.org ([65.172.181.6]:37604 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266631AbUAWSqB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jan 2004 13:46:01 -0500
Date: Fri, 23 Jan 2004 10:46:53 -0800
From: Andrew Morton <akpm@osdl.org>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       john stultz <johnstul@us.ibm.com>
Subject: Re: keyboard and USB problems (Re: 2.6.2-rc1-mm2)
Message-Id: <20040123104653.53fe7667.akpm@osdl.org>
In-Reply-To: <20040123161946.GA6934@ucw.cz>
References: <20040123013740.58a6c1f9.akpm@osdl.org>
	<20040123160152.GA18073@ss1000.ms.mff.cuni.cz>
	<20040123161946.GA6934@ucw.cz>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech Pavlik <vojtech@suse.cz> wrote:
>
> On Fri, Jan 23, 2004 at 05:01:52PM +0100, Rudo Thomas wrote:
>  > Hi.
>  > 
>  > I don't seem to be able to type anything on the keyboard in 2.6.2-rc1-mm2. It
>  > works fine in -rc1-mm1. There are a few differences in dmesg output of mm2
>  > compared to mm1.
>  > 
>  > BogoMIPS is figured out to be 8.19 (this was already reported by another user),
> 
>  ... this the root cause of the following problems.
> 
>  > and i8042.c complaints with this:
>  > i8042.c: Can't write CTR while closing AUX.
> 
>  ... bogomips is used in udelay() and that's used for waiting. If
>  bogomips is measured lower than real, the wait takes shorter and the
>  hardware doesn't do what it should in that short time.
> 
>  Try disabling ACPI for a start ...

Disabling CONFIG_X86_PM_TIMER should fix it up too.

