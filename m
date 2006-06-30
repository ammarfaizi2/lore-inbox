Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932265AbWF3QOY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932265AbWF3QOY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 12:14:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932386AbWF3QOY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 12:14:24 -0400
Received: from wx-out-0102.google.com ([66.249.82.196]:2846 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932265AbWF3QOW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 12:14:22 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=HNDpdJzkfbB9Hu0rGZRxc02sHjKYKg2ouzsW9luv+NMIBE7t1PTU/sCKzIdbcqMlAaHr3W3WUlKEwVOLURtU/7VDTPG99ExYlJmmTIxqK2goBIw6ZFdTWKNpYyPgeYKLyumy+B3rP4XCK+j/Y6YEOHAs7C/lappMA/LaBjCXkz0=
Message-ID: <39f633820606300914i170c9a25i24e834efc36703f5@mail.gmail.com>
Date: Fri, 30 Jun 2006 18:14:21 +0200
From: "Robert Nagy" <robert.nagy@gmail.com>
To: "Jesse Barnes" <jbarnes@virtuousgeek.org>
Subject: Re: Intel RAID Controller SRCU42X in SGI Altix 350
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200606300906.47077.jbarnes@virtuousgeek.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <39f633820606290818g1978866ap@mail.gmail.com>
	 <200606291342.38580.jbarnes@virtuousgeek.org>
	 <39f633820606300507h68333a66xb6750e7d6cd652b1@mail.gmail.com>
	 <200606300906.47077.jbarnes@virtuousgeek.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

no i do not have kdb. and i cannot even boot the box now. is there any
way to disable the megaraid driver with an argument?

2006/6/30, Jesse Barnes <jbarnes@virtuousgeek.org>:
> On Friday, June 30, 2006 5:07 am, Robert Nagy wrote:
> > I've tried that with two different cards. Now the error is different.
> > Even the firmware boots on the controller but then the machine resets.
> > Same thing happens if I load the EFI driver but that drops me to the
> > debugger. More info can be found at http://pastebin.ca/75652
> >
> > megaraid cmm: 2.20.2.6 (Release Date: Mon Mar 7 00:01:03 EST 2005)
> > megaraid: 2.20.4.8 (Release Date: Mon Apr 11 12:27:22 EST 2006)
> > megaraid: probe new device 0x1000:0x0407:0x8086:0x0532: bus 2:slot
> > 0:func 0 ACPI: PCI Interrupt 0002:02:00.0[A]: no GSI
> > megaraid mailbox: wait for FW to boot [ok]
> > Entered OS MCA handler. PSP=20000000fff21120 cpu=0 monarch=1
> > All OS MCA slaves have reached rendezvous
>
> This is what happens when you have PCI card in the bus next to your RAID
> card and run without my patch?  Hm...  this might be a regular driver
> bug.  Interesting that this driver might do an msleep right after the
> [ok] is printed.  Do you have kdb builtin to your kernel?  If so, maybe
> you could get a backtrace.  Otherwise you could put in some printk
> statements to see if we can figure out where the MCA is occuring...
>
> Jesse
>
