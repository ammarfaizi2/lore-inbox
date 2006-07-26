Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751301AbWGZNvo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751301AbWGZNvo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 09:51:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750732AbWGZNvo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 09:51:44 -0400
Received: from mta07-winn.ispmail.ntl.com ([81.103.221.47]:45537 "EHLO
	mtaout01-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S1751301AbWGZNvn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 09:51:43 -0400
Message-ID: <44C77544.1050205@gentoo.org>
Date: Wed, 26 Jul 2006 14:59:32 +0100
From: Daniel Drake <dsd@gentoo.org>
User-Agent: Thunderbird 1.5.0.4 (X11/20060603)
MIME-Version: 1.0
To: sergio@sergiomb.no-ip.org
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@osdl.org>,
       Chris Wedgwood <cw@f00f.org>, greg@kroah.com, jeff@garzik.org,
       harmon@ksu.edu, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Add SATA device to VIA IRQ quirk fixup list
References: <20060714095233.5678A8B6253@zog.reactivated.net>	 <44B77B1A.6060502@garzik.org> <44B78294.1070308@gentoo.org>	 <44B78538.6030909@garzik.org> <20060714074305.1248b98e.akpm@osdl.org>	 <44BA48A0.2060008@gentoo.org> <20060716183126.GB4483@kroah.com>	 <20060717003418.GA27166@tuatara.stupidest.org>	 <20060724214046.1c1b646e.akpm@osdl.org>	 <1153874577.7559.36.camel@localhost> <1153917954.29975.22.camel@bastov.localdomain>
In-Reply-To: <1153917954.29975.22.camel@bastov.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sergio Monteiro Basto wrote:
> I want put here something like:  if ( dev->irq != XT-PIC) return and
> don't quirk this dev.

I can't explain why, but this is not sufficient. Gentoo now have 2 
completely separate bug reports where the quirk is *only* needed when 
ACPI/APIC are enabled.

http://bugs.gentoo.org/138036
http://bugs.gentoo.org/141082

I'm not disputing that there are other systems where the opposite is 
true, but at least with our current level of understanding we cannot 
apply the quirk on an irq-type basis.

Daniel

