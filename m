Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264025AbTIIRBS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 13:01:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264163AbTIIRBS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 13:01:18 -0400
Received: from yankee.rb.xcalibre.co.uk ([217.8.240.35]:33215 "EHLO
	yankee.rb.xcalibre.co.uk") by vger.kernel.org with ESMTP
	id S264025AbTIIRBR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 13:01:17 -0400
Envelope-to: linux-kernel@vger.kernel.org
From: Alistair J Strachan <alistair@devzero.co.uk>
To: Markus =?iso-8859-1?q?H=E4stbacka?= <midian@ihme.org>
Subject: Re: Nforce2
Date: Tue, 9 Sep 2003 18:01:17 +0100
User-Agent: KMail/1.5.9
References: <1063114472.589.4.camel@midux>
In-Reply-To: <1063114472.589.4.camel@midux>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Message-Id: <200309091801.17024.alistair@devzero.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 09 September 2003 14:34, Markus Hästbacka wrote:
> Still problems with nvidia-agp on 2.6.0-test5(-mm1). I can't track down
> the problem because my box needs a hard reboot. My card is nvidia. So
> they should work together. On 2.4.23-pre3, there's no problem anymore.
> Works fine, but why not in 2.6.0-test5? Any ideas why it crashes? Any
> fix? If you need me to investigate more. Tell me how.

I get similar crashes with minion.de's patches and the nForce2 AGPGART. I'm in 
the process of tracking it down.

For the moment you can just disable AGPGART in your kernel and use the 
provided NVAGP, Option "NvAGP" "1" in your XF86Config. You will get AGP 8x in 
XFree86, which is probably all you want.

[alistair] 06:00 PM [~] uname -r
2.6.0-test5-mm1

[alistair] 06:00 PM [~] cat /proc/driver/nvidia/version
NVRM version: NVIDIA Linux x86 nvidia.o Kernel Module  1.0-4496  Wed Jul 16 
19:03:09 PDT 2003
GCC version:  gcc version 3.3.1

[alistair] 06:00 PM [~] cat /proc/driver/nvidia/agp/status
Status:          Enabled
Driver:          NVIDIA
AGP Rate:        8x
Fast Writes:     Disabled
SBA:             Disabled

Cheers,
Alistair.
