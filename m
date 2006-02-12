Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751219AbWBRM54@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751219AbWBRM54 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Feb 2006 07:57:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751243AbWBRMzO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Feb 2006 07:55:14 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:26523 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S1751219AbWBRMzG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Feb 2006 07:55:06 -0500
Date: Sun, 12 Feb 2006 18:26:08 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Michael_E_Brown@Dell.com
Cc: mjg59@srcf.ucam.org, akpm@osdl.org, Matt_Domsch@Dell.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [RESEND] Add Dell laptop backlight brightness display
Message-ID: <20060212172607.GA1609@openzaurus.ucw.cz>
References: <35C9A9D68AB3FA4AB63692802656D9EC9277C0@ausx3mps303.aus.amer.dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <35C9A9D68AB3FA4AB63692802656D9EC9277C0@ausx3mps303.aus.amer.dell.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> You can get and set laptop brighness on Dell with the proper SMI call.
> 
> To do the proper SMI call requires parsing SMBIOS structure 0xDA, a
> vendor-proprietary structure, and getting the SMI index and io port and
> magic values. Then, you need to know how to setup the registers and
> input/output buffers for the call. All of this is already present in
> libsmbios.

Perhaps authors of libsmbios could help here?

> Reading nvram is not a valid way to get brighness unless you also do
> similar work (parse specific vendor-proprietary SMBIOS structures) to
> ensure that you are reading the correct location. This location is
> subject to change from BIOS to BIOS and machine to machine. The fact
> that you may have observed it in the same location on a few laptops does
> not change this fact.

Well, folks reverse-engineering your machines had no idea until now...

> In fact, I have the same objection to the I8K driver in the kernel. It
> has hardcoded SMI calls, that are subject to change. There is a proper
> way to get the correct IO ports to make this safe, but it is not
> currently being done.

Could you or someone at Dell submit patches to correct this?
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

