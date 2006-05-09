Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751385AbWEIKvs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751385AbWEIKvs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 06:51:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751398AbWEIKvs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 06:51:48 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:65155 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751385AbWEIKvs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 06:51:48 -0400
Subject: Re: How to read BIOS information
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Madhukar Mythri <madhukar.mythri@wipro.com>
Cc: Erik Mouw <erik@harddisk-recovery.com>, linux-kernel@vger.kernel.org
In-Reply-To: <4460273E.5040608@wipro.com>
References: <445F5228.7060006@wipro.com>
	 <1147099994.2888.32.camel@laptopd505.fenrus.org>
	 <445F5DF1.3020606@wipro.com>
	 <1147101329.2888.39.camel@laptopd505.fenrus.org>
	 <445F63B3.2010501@wipro.com> <20060508152659.GG1875@harddisk-recovery.com>
	 <4460273E.5040608@wipro.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 09 May 2006 12:03:44 +0100
Message-Id: <1147172624.3172.60.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2006-05-09 at 10:53 +0530, Madhukar Mythri wrote:
>   yeah, your are correct. but, the thing is my superiors want, even if 
> kernel not reconize/use HT, we have to capture it from BIOS...
> Thats why i asked as, how to read BIOS information?

You ask the BIOS vendor for the exact board in question.

If you want to ask the processor itself then you can use the model
specific registers. These are accessible via /dev/cpu/<cpuid>/msr so you
can perform the Intel recommended sequence for checking if the processor
has HT enabled.

It might be simpler to look in /proc/cpuinfo if you just need the basic
information

