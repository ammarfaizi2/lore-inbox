Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264411AbTLBWRZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Dec 2003 17:17:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264418AbTLBWQi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Dec 2003 17:16:38 -0500
Received: from mail6.bluewin.ch ([195.186.4.229]:60053 "EHLO mail6.bluewin.ch")
	by vger.kernel.org with ESMTP id S264416AbTLBWQb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Dec 2003 17:16:31 -0500
From: Raffaele Sandrini <rasa@gmx.ch>
To: linux-kernel@vger.kernel.org
Subject: Re: System clock and speedstepping
Date: Tue, 2 Dec 2003 23:16:21 +0100
User-Agent: KMail/1.5.4
References: <200311261943.38002.rasa@gmx.ch> <1070318452.23568.577.camel@cog.beaverton.ibm.com>
In-Reply-To: <1070318452.23568.577.camel@cog.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312022316.21477.rasa@gmx.ch>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 01 December 2003 23:40, john stultz wrote:
>
> The "sane timesource" is the PIT (programmable interval timer). The TSC
> is the Time-Stamp-Counter which is basically a cycle counter on the cpu.
> If you want to boot using the PIT instead of the TSC, you can override
> the default time source by using  "clock=pit" as a boot option. However
> hopefully the problem can be fixed by adjusting the cpufreq code. As I
> don't have any such hardware, would you be interested in testing
> possible patches?
>
> thanks
> -john
>

Im willing to solve it another way: There is a patch around (included in the 
mm paches) for the kernel wich introduces a ACPI timer (timesource). As im 
successfully using ACPI here ill switch over to it. A collegue of mine (who 
had equal problems) reportet that this driver solves the problem completly.

About your patches: I would surely test your patches... i think its necessray 
to have a good bug less standard implementation  of the timesource.

BTW: The time screw was huge. Especially if i ran programms wich needed all 
the recources avalible (while(1){}).

cheers,
Raffaele
-- 
Raffaele Sandrini <rasa@gmx.ch>

