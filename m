Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750731AbWEVMyM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750731AbWEVMyM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 08:54:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750807AbWEVMyM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 08:54:12 -0400
Received: from cantor2.suse.de ([195.135.220.15]:20625 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750731AbWEVMyM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 08:54:12 -0400
From: Andi Kleen <ak@suse.de>
To: Vladimir Dvorak <dvorakv@vdsoft.org>
Subject: Re: APIC error on CPUx
Date: Mon, 22 May 2006 14:54:05 +0200
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org
References: <44716A5F.3070208@vdsoft.org> <200605221403.16464.ak@suse.de> <4471AC63.8060406@vdsoft.org>
In-Reply-To: <4471AC63.8060406@vdsoft.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605221454.05874.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Can "noapic" or "nolapic" solve this ? Does it mean ( with these
> parameters ) that devices will start to use 8259 interrupt controller
> instead APIC ?

nolapic won't work on SMP (or rather forced UP mode) 

You'll not see the messages anymore, but might get silent corruption.
Or it might work around it because it will make everything a bit slower.

> 
> Is harmfull put "noapic" on "nolapic" to cmdline ?

If all devices can still be accessed noapic is just slower.

-Andi

