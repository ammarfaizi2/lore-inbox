Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756197AbWKRG75@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756197AbWKRG75 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Nov 2006 01:59:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756200AbWKRG74
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Nov 2006 01:59:56 -0500
Received: from terminus.zytor.com ([192.83.249.54]:27619 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1756198AbWKRG7z
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Nov 2006 01:59:55 -0500
Message-ID: <455EAF54.5090500@zytor.com>
Date: Fri, 17 Nov 2006 22:59:32 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: Oleg Verych <olecom@flower.upol.cz>
CC: Andi Kleen <ak@suse.de>, LKML <linux-kernel@vger.kernel.org>,
       vgoyal@in.ibm.com, akpm@osdl.org, rjw@sisk.pl, ebiederm@xmission.com,
       Reloc Kernel List <fastboot@lists.osdl.org>, pavel@suse.cz,
       magnus.damm@gmail.com
Subject: Re: [PATCH 20/20] x86_64: Move CPU verification code to common file
References: <20061117223432.GA15449@in.ibm.com> <20061117225953.GU15449@in.ibm.com> <slrnelt6h7.dd3.olecom@flower.upol.cz> <20061118063802.GE30547@bingen.suse.de> <20061118070101.GA14673@flower.upol.cz>
In-Reply-To: <20061118070101.GA14673@flower.upol.cz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg Verych wrote:
> 
> It will burn CPU, until power cycle will be done (my AMD64 laptop and
> Intel's amd64 destop PC require that). In case of reboot timeout (or
> just reboot with jump to BIOS), i will just choose another image to boot
> or will press F8 to have another boot device.
> 

That's a fairly stupid argument, since it assumes operator intervention, 
at which point you have access to the machine anyway.

A stronger argument is, again, that some bootloaders can do unattended 
fallback.

However, this test should probably be pushed earlier, into setup.S, 
where executing a BIOS-clean reboot is much easier.

	-hpa
