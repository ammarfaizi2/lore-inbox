Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264533AbTK0O57 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Nov 2003 09:57:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264534AbTK0O57
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Nov 2003 09:57:59 -0500
Received: from ftp.symdata.com ([207.44.192.51]:31456 "HELO dev.symdata.com")
	by vger.kernel.org with SMTP id S264533AbTK0O56 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Nov 2003 09:57:58 -0500
From: Simon <simon@highlyillogical.org>
Organization: highlyillogical.org
To: Marco Roeland <marco.roeland@xs4all.nl>
Subject: Re: [2.6.0-test10] cpufreq: 2G P4M won't go above 1.2G - cpuinfo_max_freq too low
Date: Thu, 27 Nov 2003 14:57:48 +0000
User-Agent: KMail/1.5.2
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
References: <200311271139.07260.simon@highlyillogical.org> <200311271323.37123.simon@highlyillogical.org> <20031127134245.GA9404@localhost>
In-Reply-To: <20031127134245.GA9404@localhost>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200311271457.48812.simon@highlyillogical.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 27 November 2003 1:42 pm, Marco Roeland wrote:

> > Seems that this is a fault of a better implementation of something... But
> > "better" to me shouldn't take away choice of cpu speed from the user? ;)
>
> One last straw you might try, is building all the different cpufreq
> drivers as modules, and trying if modprobeing one of them might work.
> They seem to all behave slightly differently with respect to what they
> assume to be true from the ACPI reported values, and what they try on
> their own.

You're a star, thankyou. It was loading p4-clockmod by default. I had all the 
pentium-related modules compiled in, and it was behaving like that... dmesg 
said it was loading p4-clockmod.

I modprobe'd speedstep-ich instead, and foom! Straight up to 2ghz.

Thanks,
Simon


