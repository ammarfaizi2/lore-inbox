Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262653AbTCYWtK>; Tue, 25 Mar 2003 17:49:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262768AbTCYWtK>; Tue, 25 Mar 2003 17:49:10 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:43956
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262653AbTCYWtJ>; Tue, 25 Mar 2003 17:49:09 -0500
Subject: Re: System time warping around real time problem - please help
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Fionn Behrens <fionn@unix-ag.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       george anzinger <george@mvista.com>
In-Reply-To: <1048632934.1355.12.camel@rtfm>
References: <1048609931.1601.49.camel@rtfm>
	 <Pine.LNX.4.53.0303251152080.29361@chaos> <1048627013.2348.39.camel@rtfm>
	 <3E80D4CC.4000202@mvista.com>  <1048632934.1355.12.camel@rtfm>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1048637613.29944.17.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 26 Mar 2003 00:13:36 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-03-25 at 22:55, Fionn Behrens wrote:
> > This all sounds very much like the TSCs are drifting WRT each other. 
> > Is it possible that you have some power management code (or hardware) 
> > that is slowing one cpu and not the other?
> 
> Well, I still don't really know what TSCs actually are (or what TSC
> stands for).
> 
> The only suspect in that case would be the amd76x_pm.o kernel module
> which I am admittedly using. It saves about 90Watts of power when the
> machine is idle...

If you are using amd76x_pm boot with "notsc", ditto for that matter
on dual athlons with APM or ACPI in some cases. In fact I wish people
would stop using the tsc for clock timing altogether. It simply doesn't
work on a lot of modern systems


