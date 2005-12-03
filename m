Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751062AbVLCUL5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751062AbVLCUL5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Dec 2005 15:11:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751067AbVLCUL5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Dec 2005 15:11:57 -0500
Received: from mail.dvmed.net ([216.237.124.58]:14572 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1750992AbVLCUL4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Dec 2005 15:11:56 -0500
Message-ID: <4391FC0A.9040202@pobox.com>
Date: Sat, 03 Dec 2005 15:11:54 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: linux-kernel@vger.kernel.org, gregkh@suse.de
Subject: Re: [PATCH 0/3] x86 PCI domain support
References: <20051203013904.GA2560@havoc.gtf.org> <20051203031533.GB14247@wotan.suse.de>
In-Reply-To: <20051203031533.GB14247@wotan.suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.1 (/)
X-Spam-Report: Spam detection software, running on the system "srv2.dvmed.net", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  Andi Kleen wrote: > On Fri, Dec 02, 2005 at 08:39:04PM
	-0500, Jeff Garzik wrote: > >>ACPI PCI support stopped short of
	supporting multiple PCI domains, >>which is something I need in order
	to support a current machine >>configuration, and something many will
	soon need, to support upcoming >>systems. >> >>This is a minimal,
	untested implementation. But it should work, >>provided your PCI op
	hooks (direct, BIOS, mmconfig) support PCI domains >>(mmconfig). > > >
	It looks like a good start. Thanks for doing this. > > It actually
	needs some more fixes - e.g. falling back to > type1 if the bus is not
	covered in MCFG (needed for the > K8 internal busses) and a workaround
	for buggy Asus BIOS with wrong MCFG. > I have that in the works. > >
	But your changes are needed too - or at least they are correct >
	according to the spec. I don't know of a system that actually > has
	different mmconfig apertures for different busses yet. > The only case
	that's interesting right now is that some busses > don't support it at
	all, but these don't need a seg number, > just a non listing in MCFG. >
	> Greg are you queueing this up? [...] 
	Content analysis details:   (0.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[69.134.188.146 listed in dnsbl.sorbs.net]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> On Fri, Dec 02, 2005 at 08:39:04PM -0500, Jeff Garzik wrote:
> 
>>ACPI PCI support stopped short of supporting multiple PCI domains,
>>which is something I need in order to support a current machine
>>configuration, and something many will soon need, to support upcoming
>>systems.
>>
>>This is a minimal, untested implementation.  But it should work,
>>provided your PCI op hooks (direct, BIOS, mmconfig) support PCI domains
>>(mmconfig).
> 
> 
> It looks like a good start.  Thanks for doing this.
> 
> It actually needs some more fixes - e.g. falling back to 
> type1 if the bus is not covered in MCFG (needed for the 
> K8 internal busses) and a workaround for buggy Asus BIOS with wrong MCFG.
> I have that in the works.
> 
> But your changes are needed too - or at least they are correct
> according to the spec. I don't know of a system that actually
> has different mmconfig apertures for different busses yet.
> The only case that's interesting right now is that some busses
> don't support it at all, but these don't need a seg number,
> just a non listing in MCFG.
> 
> Greg are you queueing this up? 

The first two patches could go in immediately, the last should probably 
wait a bit...

	Jeff



