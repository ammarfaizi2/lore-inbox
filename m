Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964978AbWEORFv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964978AbWEORFv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 13:05:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964979AbWEORFv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 13:05:51 -0400
Received: from cantor.suse.de ([195.135.220.2]:63925 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S964978AbWEORFv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 13:05:51 -0400
From: Andi Kleen <ak@suse.de>
To: "Brown, Len" <len.brown@intel.com>
Subject: Re: [PATCH for 2.6.17] [3/5] i386/x86_64: Force pci=noacpi on HP  XW9300
Date: Mon, 15 May 2006 19:05:41 +0200
User-Agent: KMail/1.9.1
Cc: torvalds@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org,
       gregkh@suse.de, jgarzik@pobox.com
References: <CFF307C98FEABE47A452B27C06B85BB670FA6C@hdsmsx411.amr.corp.intel.com>
In-Reply-To: <CFF307C98FEABE47A452B27C06B85BB670FA6C@hdsmsx411.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605151905.42105.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 15 May 2006 18:47, Brown, Len wrote:
> 
> >The system has multiple PCI segments and we don't handle that properly
> >yet in PCI and ACPI. Short term before this is fixed blacklist it to
> >pci=noacpi.
> 
> I'm okay with the patch, but it makes me wonder...
> 
> Is this the 1st/only system 

x86-

IA64/PA-RISC support subdomains successfully

> Linux has run on with multiple PCI segments? 

I think IBM summit somehow uses it too.

And there is a patch from Jeff Garzik I think to make the xw9300 subdomains 
work (or rather implement subdomain support in arch/i386/pci/*), but it 
breaks the Summit and possibly other non x86 systems. Greg 
should know details about that.

As usual the systems usually boot even without this patch, but you can't 
reach all PCI devices.

> What are your expectations for where "short-term" ends and "long-term"
> begins?

I think Greg has Jeff's patch still queued somewhere, but it needs
to be debugged to work everywhere. After that is done we can drop the blacklist 
entry. Hopefully for 2.6.19?

For 2.6.17 I don't see any alternative to blacklisting.

-Andi
