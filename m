Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932654AbVKXUcJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932654AbVKXUcJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Nov 2005 15:32:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932655AbVKXUcJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Nov 2005 15:32:09 -0500
Received: from relay.uni-heidelberg.de ([129.206.100.212]:48872 "EHLO
	relay.uni-heidelberg.de") by vger.kernel.org with ESMTP
	id S932654AbVKXUcH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Nov 2005 15:32:07 -0500
Date: Thu, 24 Nov 2005 21:31:59 +0100 (CET)
From: Bogdan Costescu <Bogdan.Costescu@iwr.uni-heidelberg.de>
To: Jeff Garzik <jgarzik@pobox.com>
cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Marvell SATA fixes v2
In-Reply-To: <4384E184.3040304@pobox.com>
Message-ID: <Pine.LNX.4.63.0511242121290.28034@dingo.iwr.uni-heidelberg.de>
References: <437D2DED.5030602@pobox.com>
 <Pine.LNX.4.44.0511182241420.5095-100000@kenzo.iwr.uni-heidelberg.de>
 <20051118215209.GA9425@havoc.gtf.org> <Pine.LNX.4.63.0511211311260.22263@dingo.iwr.uni-heidelberg.de>
 <4384E184.3040304@pobox.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Nov 2005, Jeff Garzik wrote:

> Bogdan Costescu wrote:
>> With MSI and libata DEBUG turned off I had a crash
>
> I wonder if the global reset disables MSI...  may be a driver bug.

I'm sorry, but I don't follow you here: I have specified that MSI was 
disabled, so why do you expect this to have any effect ? (I could have 
made it clearer by adding a "both" before "turned off"...)

> You could play around with moving the pci_enable_msi until after the global 
> reset...

I also don't follow:

pci_enable_msi() is only called from mv_init_one(); I think that the 
global reset that you refer to is part of mv_init_host(), but this is 
already called in mv_init_one() before pci_enable_msi().

Anyway, during all the speed testing, I was running the exact same 
kernel that crashed - with more disks and more activity, and I 
couldn't crash it anymore. Could you suggest, based on the stack dump, 
how to make it more likely to crash again ?

-- 
Bogdan Costescu

IWR - Interdisziplinaeres Zentrum fuer Wissenschaftliches Rechnen
Universitaet Heidelberg, INF 368, D-69120 Heidelberg, GERMANY
Telephone: +49 6221 54 8869, Telefax: +49 6221 54 8868
E-mail: Bogdan.Costescu@IWR.Uni-Heidelberg.De
