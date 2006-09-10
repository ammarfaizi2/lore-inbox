Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932247AbWIJPsr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932247AbWIJPsr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Sep 2006 11:48:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932261AbWIJPsr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Sep 2006 11:48:47 -0400
Received: from smtp121.iad.emailsrvr.com ([207.97.245.121]:52410 "EHLO
	smtp141.iad.emailsrvr.com") by vger.kernel.org with ESMTP
	id S932247AbWIJPsq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Sep 2006 11:48:46 -0400
Message-ID: <450433D5.6010207@gentoo.org>
Date: Sun, 10 Sep 2006 11:48:37 -0400
From: Daniel Drake <dsd@gentoo.org>
User-Agent: Thunderbird 1.5.0.5 (X11/20060818)
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, akpm@osdl.org, torvalds@osdl.org,
       sergio@sergiomb.no-ip.org, jeff@garzik.org, cw@f00f.org,
       bjorn.helgaas@hp.com, linux-kernel@vger.kernel.org, harmon@ksu.edu,
       len.brown@intel.com, vsu@altlinux.ru, liste@jordet.net
Subject: Re: [PATCH V3] VIA IRQ quirk behaviour change
References: <20060907223313.1770B7B40A0@zog.reactivated.net> <1157811641.6877.5.camel@localhost.localdomain> <4502D35E.8020802@gentoo.org> <1157817836.6877.52.camel@localhost.localdomain> <45033370.8040005@gentoo.org> <1157848272.6877.108.camel@localhost.localdomain> <20060910002112.GA20672@kroah.com>
In-Reply-To: <20060910002112.GA20672@kroah.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> On Sun, Sep 10, 2006 at 01:31:12AM +0100, Alan Cox wrote:
>> VIA have always told me that "ACPI handles this" and we don't need
>> quirks. Various chips have different IRQ routing logic and it's all a
>> bit weird if we don't use ACPI and/or BIOS routing.
> 
> So why isn't acpi handling all of this for us?  Do people not want to
> use acpi for some reason?

It doesn't appear to be this simple in reality. Chris has reports that 
indeed enabling ACPI avoids the needs for quirks, but Gentoo have 
reports that quirks are *only* required in ACPI mode. Sergio is of the 
opinion that quirks are not required in IO-APIC setups, but Stian has 
shown that quirks are required on legacy interrupts even with a working 
IO-APIC setup.

Len Brown has some notes to add:
http://lists.openwall.net/linux-kernel/2006/07/14/147

Daniel
