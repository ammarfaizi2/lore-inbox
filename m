Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263104AbVCXRAr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263104AbVCXRAr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 12:00:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263102AbVCXRAr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 12:00:47 -0500
Received: from tiu.fh-brandenburg.de ([195.37.0.8]:11633 "EHLO
	tiu.fh-brandenburg.de") by vger.kernel.org with ESMTP
	id S263104AbVCXRAK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 12:00:10 -0500
Date: Thu, 24 Mar 2005 18:00:04 +0100
From: Markus Dahms <dahms@fh-brandenburg.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BUG] Lockup using ALi SATA controller (sata_uli)
Message-ID: <20050324170004.GA18726@fh-brandenburg.de>
References: <20050321224410.GA27760@fh-brandenburg.de> <20050322222606.760e03e4.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050322222606.760e03e4.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Andrew Morton,

>>  I have a reproducable lockup of my system using an ALi SATA controller
>>  and writing some 100 MB to the attached disk.
>> ...
>>  Do you have some hints?
> As a test you might like to try an uniprocessor kernel - we do have a
> deadlock on the sata error recovery paths at present.

The UP kernel didn't change anything, same error on console. In addition
this kernel crashes every second time or so immediately after boot
(some pci stuff in backtrace), I'll try catch some error messages....

> Or ensure that you've enabled the io-apci in Kconfig and boot with
> nmi_watchdog=1.

Except the line "testing NMI watchdog ... OK." in the boot messages
I don't see any difference. :-(

thanks anyway,

	Markus

-- 
A CRAY is the only computer that runs an endless loop in just 4 hours...
