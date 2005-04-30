Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261411AbVD3UoY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261411AbVD3UoY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Apr 2005 16:44:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261422AbVD3UnZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Apr 2005 16:43:25 -0400
Received: from outpost.ds9a.nl ([213.244.168.210]:14246 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id S261414AbVD3UhZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Apr 2005 16:37:25 -0400
Date: Sat, 30 Apr 2005 22:37:23 +0200
From: bert hubert <ahu@ds9a.nl>
To: Andy Lutomirski <luto@myrealbox.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [x86_64] how worried should I be about MCEs?
Message-ID: <20050430203723.GA8122@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	Andy Lutomirski <luto@myrealbox.com>, linux-kernel@vger.kernel.org
References: <4273E7B1.6020500@myrealbox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4273E7B1.6020500@myrealbox.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 30, 2005 at 01:16:49PM -0700, Andy Lutomirski wrote:
> Every now and then, after rebooting, the kernel notices some MCEs. 
> Should I be worried about this?

If these reports are true, they would be worrying. But I find them a bit
hard to believe - the bit combinations don't appear to make sense.

I have an AMD64 machine which logs 'MCE reported' every once in a while but
otherwise functions perfectly and I haven't yet coaxed it into telling me
the content of the errors.

Might there be a bug here? How did you create this log?

> STATUS f66440000000438d MCGSTATUS 0
> MCE 1
> CPU 0 1 instruction cache from boot or resume
> ADDR 75e2bb87ec57f8e0
>   Instruction cache ECC error
>        bit32 = err cpu0
>        bit33 = err cpu1
>        bit35 = res3
>        bit43 = res11
>        bit45 = uncorrected ecc error
>        bit46 = corrected ecc error
>        bit55 = res23
>        bit56 = res24
>        bit57 = processor context corrupt
>        bit59 = misc error valid
>        bit61 = error uncorrected
>        bit62 = error overflow (multiple errors)

This would be one hell of an error - both corrected and uncorrected.

Regards,

bert

-- 
http://www.PowerDNS.com      Open source, database driven DNS Software 
http://netherlabs.nl              Open and Closed source services
