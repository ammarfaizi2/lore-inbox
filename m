Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932074AbWEAMaM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932074AbWEAMaM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 May 2006 08:30:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932078AbWEAMaM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 May 2006 08:30:12 -0400
Received: from mail-in-02.arcor-online.net ([151.189.21.42]:6569 "EHLO
	mail-in-02.arcor-online.net") by vger.kernel.org with ESMTP
	id S932076AbWEAMaK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 May 2006 08:30:10 -0400
In-Reply-To: <4454CF35.7010803@s5r6.in-berlin.de>
References: <4454CF35.7010803@s5r6.in-berlin.de>
Mime-Version: 1.0 (Apple Message framework v749.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <EFD1A7C4-9A9E-48EA-985E-9154428AFFE6@kernel.crashing.org>
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: How to replace bus_to_virt()?
Date: Mon, 1 May 2006 14:30:02 +0200
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
X-Mailer: Apple Mail (2.749.3)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> is there a *direct* future-proof replacement for bus_to_virt()?
>
> It appears there are already architectures which do not define a  
> bus_to_virt() funtion or macro. If there isn't a direct  
> replacement, is there at least a way to detect at compile time  
> whether bus_to_virt() exists?
>
> I am asking because the sbp2 driver uses bus_to_virt() if  
> CONFIG_IEEE1394_SBP2_PHYS_DMA=y. I would like to replace this  
> option by an automatic detection when the respective code in sbp2  
> is actually required.
>
> The current implementation is this: Sbp2 uses bus_to_virt() to map  
> from 1394 bus addresses (which are currently identical to local  
> host bus addresses) to virtual addresses.

Sounds like you should be using phys_to_virt() anyway?


Segher

