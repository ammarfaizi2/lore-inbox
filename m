Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132108AbRAPRGK>; Tue, 16 Jan 2001 12:06:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132031AbRAPRGA>; Tue, 16 Jan 2001 12:06:00 -0500
Received: from [64.64.109.142] ([64.64.109.142]:9482 "EHLO quark.didntduck.org")
	by vger.kernel.org with ESMTP id <S129831AbRAPRFu>;
	Tue, 16 Jan 2001 12:05:50 -0500
Message-ID: <3A647F39.EC62BB81@didntduck.org>
Date: Tue, 16 Jan 2001 12:04:57 -0500
From: Brian Gerst <bgerst@didntduck.org>
X-Mailer: Mozilla 4.73 [en] (WinNT; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Venkatesh Ramamurthy <Venkateshr@ami.com>
CC: "'David Woodhouse'" <dwmw2@infradead.org>,
        "'linux-scsi@vger.kernel.org'" <linux-scsi@vger.kernel.org>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        "'Alan Cox'" <alan@lxorguk.ukuu.org.uk>
Subject: Re: Linux not adhering to BIOS Drive boot order?
In-Reply-To: <1355693A51C0D211B55A00105ACCFE64E95190@ATL_MS1>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Venkatesh Ramamurthy wrote:
> 
> > When the cards are of different make the order is solely dependent on
> > the order that the drivers are initialized in the kernel.  If you have
> > modules enabled, only build the driver for your root device into the
> > kernel image and have the other modular.  This lets you control the
> > initialization order to your liking.
>         [Venkatesh Ramamurthy]  I think there should be a better way to
> handle this , compiling is one of the options, but an end-user should not
> think of compiling. The end user needs to put an another card and connect
> drives and get his system up and running. He should not think of compiling
> the drivers, if it is already part of the kernel / initrd to get his system
> running.

Why does the end-user have to compile the kernel?  Most distributions
provide a kernel with no SCSI drivers in it, but use an initrd to get
the root SCSI driver in (man mkinitrd on any Redhat box).  Just
distribute all SCSI drivers as modules and you won't have any problems.

--

				Brian Gerst
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
