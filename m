Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264518AbTK0NXx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Nov 2003 08:23:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264519AbTK0NXw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Nov 2003 08:23:52 -0500
Received: from ftp.symdata.com ([207.44.192.51]:49369 "HELO dev.symdata.com")
	by vger.kernel.org with SMTP id S264518AbTK0NXu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Nov 2003 08:23:50 -0500
From: Simon <simon@highlyillogical.org>
Organization: highlyillogical.org
To: Marco Roeland <marco.roeland@xs4all.nl>
Subject: Re: [2.6.0-test10] cpufreq: 2G P4M won't go above 1.2G - cpuinfo_max_freq too low
Date: Thu, 27 Nov 2003 13:23:32 +0000
User-Agent: KMail/1.5.2
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
References: <200311271139.07260.simon@highlyillogical.org> <20031127121801.GB9098@localhost>
In-Reply-To: <20031127121801.GB9098@localhost>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200311271323.37123.simon@highlyillogical.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Thursday November 27th 2003 Simon wrote:
> > I have a P4 2ghz (in a thinkpad), but it's not running at over about
> > 1.2ghz now.

On Thursday 27 November 2003 12:18 pm, Marco Roeland wrote:
> It turned out to be an ACPI problem. Booting on 2.6 with "acpi=off" lead
> to the correct 1.8GHz determination instead of only 1.2GHz, but no working
> ACPI of course. On 2.4.21 booting either with of without ACPI made no
> difference and lead on both occasions to 1.8GHz.
>
> After upgrading the BIOS to the latest version I could finally run 2.6
> with ACPI and at full capacity.

I tried both of these, but the BIOS update changed nothing, and "acpi=off" 
just switched off acpi. The only thing I can tell is that my battery icon in 
KDE has disappeared... My CPU speed remains unaffected. *sigh*

On Thursday 27 November 2003 12:15 pm, Marc Staudacher wrote off-list:
> Is it the case that you're running the notebook i) with the battery
> inserted and ii) ac-powered?
>
> It is custom to IBM Thinkpads that they only run at full speed if it is
> the case that i) and ii).
>
> According to IBM the battery is necessary because it is possible that
> the power supply does not generate enough energy in certain cases
> (maximal load-scenarios). Thus, the maximal processor speed is
> automatically restricted if the battery is not inserted.
>
> The ACPI changes between 2.4.21-ac2 and 2.6.0-test10 might account for
> the different behaviour you experience.

Yes, it is. I left my battery at home today, but borrowed one off a colleague. 
Inserting it did not change anything (at least after a minute or so) but 
rebooting with the battery insterted did speed the machine up. Similarly, 
after removing the battery, the CPU stayed at full speed.

Is there anything I can do about this apart from go back to 2.4 (I've grown to 
like CONFIG_PREEMPT too much for that!) or run with the battery in all the 
time? - I've a string of past laptops where the batteries only last 5 minutes 
because of running with battery + ac power all the time, so I've been in the 
habit of always removing it these days... - I've never had a problem running 
it at max speed with 2.4.

Seems that this is a fault of a better implementation of something... But 
"better" to me shouldn't take away choice of cpu speed from the user? ;)

Thanks,
Simon


