Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030479AbVIJCxo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030479AbVIJCxo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 22:53:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932605AbVIJCxo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 22:53:44 -0400
Received: from mailrly05.isp.novis.pt ([195.23.133.215]:3793 "EHLO
	mailrly05.isp.novis.pt") by vger.kernel.org with ESMTP
	id S932601AbVIJCxn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 22:53:43 -0400
Message-ID: <43224ABB.3030002@vgertech.com>
Date: Sat, 10 Sep 2005 03:53:47 +0100
From: Nuno Silva <nuno.silva@vgertech.com>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050602)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Eyal Lebedinsky <eyal@eyal.emu.id.au>
CC: list linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: RAID resync speed
References: <432240E9.9010400@eyal.emu.id.au>
In-Reply-To: <432240E9.9010400@eyal.emu.id.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Eyal Lebedinsky wrote:
> I noticed that my 3-disk RAID was syncing at about 40MB/s, now that I
> added a fourth disk it goes at only 20+MB/s. This is on an idle machine.

3*40=120

4*20=80


> Individually, each disk measures 60+MB/s with hdparm.


And concurrent hdparms? Or some dd's concurrently?


> kernel: 2.6.13 on ia32
> Controller: Promise SATAII150 TX4
> Disks: WD 320GB SATA
> 
> Q: Is this the way the raid code works? The way the disk-io is managed? Or
> could it be due to the SATA controller?

You can isolate the performance drop with some dd's. Maybe this card is 
in a pci32/33mhz and you're hitting the pci bus' limits? (120~130MB/sec).

Regards,
Nuno Silva

