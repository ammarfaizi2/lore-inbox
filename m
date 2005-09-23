Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751045AbVIWOs6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751045AbVIWOs6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Sep 2005 10:48:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751049AbVIWOs6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Sep 2005 10:48:58 -0400
Received: from cantor2.suse.de ([195.135.220.15]:4244 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751045AbVIWOs6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Sep 2005 10:48:58 -0400
From: Andi Kleen <ak@suse.de>
To: Chuck Ebbert <76306.1226@compuserve.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: x86-64: Why minimum 64MB aperture?
Date: Fri, 23 Sep 2005 16:49:07 +0200
User-Agent: KMail/1.8
References: <200509230410_MC3-1-AAFB-6FC6@compuserve.com>
In-Reply-To: <200509230410_MC3-1-AAFB-6FC6@compuserve.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509231649.07354.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 23 September 2005 10:07, you wrote:
> I get this when I boot:
>
> Checking aperture...
> CPU 0: aperture @ 23a8000000 size 32 MB
> Aperture from northbridge cpu 0 too small (32 MB)
>
>
> arch/x86_64/aperture.c says this when aperture is < 64MB.
>
> I have no way of changing this in my BIOS.  The systems shares video memory
> with RAM.  All I can change is the amount of RAM allocated for video (32,
> 64 or 128 MB, currently set to 64.)

32MB is too small for IOMMU use. Linux will fix it up for you.

-Andi
