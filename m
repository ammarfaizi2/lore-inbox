Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264429AbUE3W7K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264429AbUE3W7K (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 May 2004 18:59:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264430AbUE3W7K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 May 2004 18:59:10 -0400
Received: from goose.mail.pas.earthlink.net ([207.217.120.18]:5766 "EHLO
	goose.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id S264429AbUE3W7H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 May 2004 18:59:07 -0400
Date: Sun, 30 May 2004 15:59:01 -0700
From: Lee Howard <faxguy@howardsilvan.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: c-d.hailfinger.kernel.2004@gmx.net, linux-kernel@vger.kernel.org
Subject: Re: 2.6.7-rc1 breaks forcedeth
Message-ID: <20040530225901.GA2399@bilbo.x101.com>
References: <20040530155715.GA2612@bilbo.x101.com> <40BA17DF.4040706@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <40BA17DF.4040706@pobox.com>; from jgarzik@pobox.com on Sun, May 30, 2004 at 10:20:31 -0700
X-Mailer: Balsa 1.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2004.05.30 10:20 Jeff Garzik wrote:
> Lee Howard wrote:
>> I use the forcedeth driver for my nVidia ethernet successfully with 
>> kernel 2.6.6.  I recently tested 2.6.7-rc1, and when using it the 
>> ethernet does not work, and I see this in dmesg:
>> 
>> eth1: forcedeth.c: subsystem: 01043:80a7 bound to 0000:00:04.0
>> NETDEV WATCHDOG: eth1: transmit timed out
>> NETDEV WATCHDOG: eth1: transmit timed out
>> NETDEV WATCHDOG: eth1: transmit timed out
>> NETDEV WATCHDOG: eth1: transmit timed out
>> NETDEV WATCHDOG: eth1: transmit timed out
>> 
>> I can ping localhost and the device's IP number, but I cannot ping 
>> other systems' IP numbers.
> 
> 
> Well, there are zero changes to the driver itself, so I would guess 
> ACPI perhaps...
> 
> Try booting with 'acpi=off' or 'noapic' or 'pci=noacpi' or similar...

I didn't have ACPI built-in to the kernel.  So, I added it, and then 
the network started working again.

So, in 2.6.6 I didn't need ACPI to have network access, but with 2.6.7 
I do.  Is this a bug or a feature?

Lee.
