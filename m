Return-Path: <linux-kernel-owner+w=401wt.eu-S965110AbWLMUA3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965110AbWLMUA3 (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 15:00:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965118AbWLMUA2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 15:00:28 -0500
Received: from smtp107.sbc.mail.mud.yahoo.com ([68.142.198.206]:29422 "HELO
	smtp107.sbc.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S965110AbWLMUA1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 15:00:27 -0500
X-Greylist: delayed 399 seconds by postgrey-1.27 at vger.kernel.org; Wed, 13 Dec 2006 15:00:27 EST
X-YMail-OSG: fBPjMbAVM1md0vwGdikN5g.gRHI50Ap26sQHyEGUZ7bIpJcOstoJlYJzcgLR9GB_uOj14VQrJ1D1.8GWyHsWtbwL7qg9.m3HAh71znOnCOC9J5pyIsr33x53tyIVSD3VbmIDDwcUi8Irz.Q-
Date: Wed, 13 Dec 2006 11:53:45 -0800
From: Chris Wedgwood <cw@f00f.org>
To: Christoph Anton Mitterer <calestyo@scientia.net>
Cc: Karsten Weiss <K.Weiss@science-computing.de>, linux-kernel@vger.kernel.org,
       Erik Andersen <andersen@codepoet.org>, Andi Kleen <ak@suse.de>
Subject: Re: data corruption with nvidia chipsets and IDE/SATA drives // memory hole mapping related bug?!
Message-ID: <20061213195345.GA16112@tuatara.stupidest.org>
References: <Pine.LNX.4.64.0612021202000.2981@addx.localnet> <Pine.LNX.4.61.0612111001240.23470@palpatine.science-computing.de> <458051FD.1060900@scientia.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <458051FD.1060900@scientia.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 13, 2006 at 08:18:21PM +0100, Christoph Anton Mitterer wrote:

> booting with iommu=soft => works fine
> booting with iommu=noagp => DOESN'T solve the error
> booting with iommu=off => the system doesn't even boot and panics

> When I set IOMMU to disabled in the BIOS the error is not solved-
> I tried to set bigger space for the IOMMU in the BIOS (256MB instead of
> 64MB),.. but it does not solve the problem.

> Any ideas why iommu=disabled in the bios does not solve the issue?

The kernel will still use the IOMMU if the BIOS doesn't set it up if
it can, check your dmesg for IOMMU strings, there might be something
printed to this effect.

> 1) And does this now mean that there's an error in the hardware
> (chipset or CPU/memcontroller)?

My guess is it's a kernel bug, I don't know for certain.  Perhaps we
shaould start making a more comprehensive list of affected kernels &
CPUs?
