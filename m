Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264594AbSIQVHO>; Tue, 17 Sep 2002 17:07:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264605AbSIQVHO>; Tue, 17 Sep 2002 17:07:14 -0400
Received: from pc1-cwma1-5-cust128.swa.cable.ntl.com ([80.5.120.128]:58104
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S264594AbSIQVHN>; Tue, 17 Sep 2002 17:07:13 -0400
Subject: Re: Linux hot swap support
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Bloch, Jack" <Jack.Bloch@icn.siemens.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <180577A42806D61189D30008C7E632E8793A60@boca213a.boca.ssc.siemens.com>
References: <180577A42806D61189D30008C7E632E8793A60@boca213a.boca.ssc.siemens.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 17 Sep 2002 22:15:03 +0100
Message-Id: <1032297303.20463.8.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-09-17 at 20:28, Bloch, Jack wrote:
> I have a cPCI system running a Red Hat 2.4.18-3 Kernel. am running on a
> Pentium III 700Mhz machine, but we have some of our own cPCI HW. I wrote the
> drivers according to the Linux Device Driver 2nd edition (i.e. hot swap
> compliant). But what I am missing is :
> 
> What SW will call my device insert/device remove routines?
> Do I need some 3rd party SW?

If you are using pci_module_init and related routines the hot plug
drivers will call the probe/remove routines for you. That would normally
be the PCI hotplug layer and a driver for the relevant board which
detects and adds/removes devices

