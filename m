Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263291AbTJUSam (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Oct 2003 14:30:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263292AbTJUSam
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Oct 2003 14:30:42 -0400
Received: from anchor-post-35.mail.demon.net ([194.217.242.85]:27155 "EHLO
	anchor-post-35.mail.demon.net") by vger.kernel.org with ESMTP
	id S263291AbTJUSal (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Oct 2003 14:30:41 -0400
Message-ID: <3F957DAC.6080901@superbug.demon.co.uk>
Date: Tue, 21 Oct 2003 19:40:44 +0100
From: James Courtier-Dutton <James@superbug.demon.co.uk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031019 Thunderbird/0.3
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: James Finnie <jf1@IMERGE.co.uk>
CC: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: VIA IDE performance under 2.6.0-test7/8?
References: <C0D45ABB3F45D5118BBC00508BC292DB016038F5@imgserv04>
In-Reply-To: <C0D45ABB3F45D5118BBC00508BC292DB016038F5@imgserv04>
X-Enigmail-Version: 0.81.6.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Finnie wrote:
> Hi guys;
> 
> Am having trouble getting decent IDE performance from the 2.6.0-test8 kernel
> (tested with 2.6.0-test7 kernel also, same issue).  The platform is VIA
> EPIA-ME6000 - with a VIA VT8235 southbridge.  Under 2.4.21 I get around
> 40Mb/s in hdparm -t and 70Mb/s for hdparm -T.  Under the 2.6.0-test7/8 I
> only manage 13Mb/s & 52Mb/s respectively!  I've attached my .config, and the
> output of /proc/ide/via, dmesg, and hdparm info.  I don't think I'm doing
> anything particularly stupid here, but if I am, hit me with a wet fish
> please :)
> 
> Thanks for all help,
> 
> James
> 
Can you also send the output from "cat /proc/interrupts".
It looks like you are not using IO-APIC, but instead using XT-PIC.
XT-PIC is a lot slower than IO-APIC.

Just turn on SMB support in the "make menuconf", and it should enable 
IO-APIC.

If you cannot boot using IO-APIC, you probably have one of the bad VIA 
motherboards. I have not determined if the IO-APIC issues with VIA 
VT8235 MBs is hardware or software related. All I know, is some VIA 
VT8235 MBs work, and some don't. I am still investigating why.

Cheers

James

