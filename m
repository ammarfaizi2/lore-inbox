Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267378AbUJNVaD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267378AbUJNVaD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 17:30:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266896AbUJNV3z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 17:29:55 -0400
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:23815 "EHLO
	pollux.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S267409AbUJNVZJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 17:25:09 -0400
Date: Thu, 14 Oct 2004 22:25:04 +0100 (BST)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: "mobil@wodkahexe.de" <mobil@wodkahexe.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc4 No local APIC present or hardware disabled
In-Reply-To: <20041014135946.1de129f0.mobil@wodkahexe.de>
Message-ID: <Pine.LNX.4.58L.0410141223010.17897@blysk.ds.pg.gda.pl>
References: <20041012195448.2eaabcea.mobil@wodkahexe.de>
 <Pine.LNX.4.58L.0410132311190.17462@blysk.ds.pg.gda.pl>
 <20041014135946.1de129f0.mobil@wodkahexe.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Oct 2004, mobil@wodkahexe.de wrote:

> i tested your patch, but it did not apply correctly to a clean 2.6.9-rc4
> tree for me. (patch -Np1 -i ../patch-2.6.9-rc4-lapic-5)

 Strange.

> I applyed it manually, and when rebooting, i get the following:
>  Local APIC won't be reenabled, ...
>  You can...
> 
> When booting with 'pci=noacpi':
>  Local APIC won't be reenabled, ...
>  You can...
> 
> When booting with 'acpi=off':
>  no output when running dmesg|grep -i apic

 Thanks, these are expected results.  Note that with 2.6.9 someone decided
to disable APIC-related messages by default, so you won't get any
information from the log unless you pass e.g. "apic=debug".

  Maciej
