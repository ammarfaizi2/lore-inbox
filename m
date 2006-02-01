Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422667AbWBAQR7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422667AbWBAQR7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 11:17:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964987AbWBAQR7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 11:17:59 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:6288 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S964980AbWBAQR6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 11:17:58 -0500
Date: Wed, 1 Feb 2006 17:17:47 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Aritz Bastida <aritzbastida@gmail.com>
cc: Greg KH <greg@kroah.com>, Antonio Vargas <windenntw@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Right way to configure a driver? (sysfs, ioctl, proc, configfs,....)
In-Reply-To: <7d40d7190602010744vc2eaf3fm@mail.gmail.com>
Message-ID: <Pine.LNX.4.61.0602011716150.22529@yvahk01.tjqt.qr>
References: <7d40d7190601261206wdb22ccck@mail.gmail.com>  <20060127050109.GA23063@kroah.com>
  <7d40d7190601270230u850604av@mail.gmail.com> 
 <69304d110601270834q5fa8a078m63a7168aa7e288d1@mail.gmail.com> 
 <7d40d7190601300323t1aca119ci@mail.gmail.com>  <20060130213908.GA26463@kroah.com>
  <Pine.LNX.4.61.0602011553410.22529@yvahk01.tjqt.qr>  <20060201151145.GA3744@kroah.com>
 <7d40d7190602010744vc2eaf3fm@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>As I said in previous messages, my driver is a kind of virtual network
>device (imagine something like "snull" in LDD3) and my question was:
>what would be the right way to configure it? I know, i know, there is
>not a unique question for that, but I'm sure at least there are
>suggestions. Some years ago, maybe there was no alternative other than
>using system calls or ioctls, but the spectrum is a lot wider now.
>
>I try to resume here the different ways that could be used, and their
>original purpose:
>
>* SYSFS: this is to export system information
>* CONFIGFS: this is to configure kernel modules/subsystems.

So there basically is an "exportfs" (sysfs) and an "importfs" (configfs). 
[This has nothing to do with the nfs-exportfs for the moment.]
Can't these be merged to have a "importexportfs", would make things 
simpler. Especially with system parameters (exported stuff, /sys) can be 
changed (aka imported).


Jan Engelhardt
-- 
