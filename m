Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965046AbVIALtn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965046AbVIALtn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 07:49:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965088AbVIALtn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 07:49:43 -0400
Received: from pilet.ens-lyon.fr ([140.77.167.16]:32164 "EHLO
	relaissmtp.ens-lyon.fr") by vger.kernel.org with ESMTP
	id S965046AbVIALtn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 07:49:43 -0400
Message-ID: <4316EAD1.70300@ens-lyon.org>
Date: Thu, 01 Sep 2005 13:49:37 +0200
From: Brice Goglin <Brice.Goglin@ens-lyon.org>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050602)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: DervishD <lkml@dervishd.net>
Cc: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: USB Storage speed regression since 2.6.12
References: <20050901113614.GA63@DervishD>
In-Reply-To: <20050901113614.GA63@DervishD>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le 01.09.2005 13:36, DervishD a écrit :
>     I don't know if this is a known issue, but usb-storage speed for
> 'Full speed' devices dropped from 2.6.11.12 (more than 800Kb/s) to
> 2.6.12 (less than 250Kb/s). The problem still exists in 2.6.13.
> 
>     The lack of speed seems to affect only the OHCI driver. My test
> was done over a PCI USB 2.0 card, ALi chipset, OHCI driver (well
> EHCI+OHCI) and using a full speed device capable of 12MBps. The
> average measured speeds are:
> 
>     - 2.4.31:           about 450Kb/seg
>     - 2.6.11-Debian:    about 800Kb/seg
>     - 2.6.11.12:        about 820Kb/seg
>     - 2.6.12.x:         about 200Kb/seg
>     - 2.6.13:           about 200Kb/seg

Are you mounting this storage with vfat and 'sync' option ?
IIRC, sync support for vfat was added around 2.6.12, making
write way slower since it's now really synchron.

Brice
