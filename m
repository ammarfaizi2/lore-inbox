Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161161AbWHDNAd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161161AbWHDNAd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 09:00:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161193AbWHDNAd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 09:00:33 -0400
Received: from web25805.mail.ukl.yahoo.com ([217.12.10.190]:27014 "HELO
	web25805.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S1161161AbWHDNAc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 09:00:32 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.fr;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type;
  b=SftXVeuCtrKkpzEUmXv69+1QtiAHJeiDiq0pJ2m60cDebmEZtuSZFFYrmYd6Ljd86V3lhdBT+q4K9B82c/n8le0rBND5Lcbh8u2MxQPcE5BO6D+auMqHCcWpUgR9A8KSoKLiPVTypPUjVdXRIPqu4ZKmWapzSD67Plw3LquHg1g=  ;
Message-ID: <20060804130030.90361.qmail@web25805.mail.ukl.yahoo.com>
Date: Fri, 4 Aug 2006 13:00:30 +0000 (GMT)
From: moreau francis <francis_moreau2000@yahoo.fr>
Reply-To: moreau francis <francis_moreau2000@yahoo.fr>
Subject: Re : [HW_RNG] How to use generic rng in kernel space
To: Michael Buesch <mb@bu3sch.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200608012249.20324.mb@bu3sch.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Buesch wrote:
> The dataflow is as follows:

> HW-RNG -> userspace RNGD (through /dev/hwrng) -> the daemon
> checks it for sanity and puts it back into the kernel through
> /dev/random -> Your driver gets the data from the /dev/random
> entropy pools.

Is that also true for embedded systems ? I mean we may not found
any rngd on these systems.

One other question now: suppose that others drivers need to use
random data during their inits. At this time userspace appli still not
have been started. How does it work ?

> This is very neccesary, because your HW-RNG may fail and
> so you may unintentionally use non-random data, if you use
> the random data from the RNG directly.
> The data _must_ go through userspace rngd, which does FIPS
> sanity checks on the data.

Well I'm working on a secure SOC which have a randown hardware
which is supposed to return true random data. I understand that 
some self tests on the random data are needed but doing them in 
userspace is suprising.

thanks

Francis



