Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263002AbTJUHsq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Oct 2003 03:48:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263009AbTJUHsq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Oct 2003 03:48:46 -0400
Received: from as1-2-5.han.s.bonet.se ([194.236.155.59]:54544 "EHLO
	palpatine.hardeman.nu") by vger.kernel.org with ESMTP
	id S263002AbTJUHso (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Oct 2003 03:48:44 -0400
Message-ID: <3F94E4DB.3080206@2gen.com>
Date: Tue, 21 Oct 2003 09:48:43 +0200
From: =?ISO-8859-1?Q?David_H=E4rdeman?= <david@2gen.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031014 Thunderbird/0.3
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Suspend with 2.6.0-test7-mm1
References: <Pine.LNX.4.44.0310201209300.13116-100000@cherise>
In-Reply-To: <Pine.LNX.4.44.0310201209300.13116-100000@cherise>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patrick Mochel wrote:
>>Now, I wonder, what is causing the kernel to exit from the suspend 
>>immediately? Is it error in suspend code, drivers that doesn't support 
>>suspend or some program that is interrupting the sleep? How do I debug 
>>this further?
> 
> Are you using ACPI? If so, could you please send the output of
> /proc/acpi/sleep? If not, then standby will not work for you at this time.
> 

(david@hansolo:~)$ cat /proc/acpi/sleep
S0 S3 S4 S5

I am using ACPI and it seems to work fine (no error messages on boot, 
able to read battery status, AC adapter status and shutdown/reboot using 
it).

I seem to recall that "standby" is S1 in ACPI terms. Does the lack of 
"S1" in the above list mean that my hardware doesn't support standby or 
that the kernel doesn't?

Also, just to make sure, for the "mem" suspend function, it doesn't 
matter if the kernel is compiled with CONFIG_PM_DISK or 
CONFIG_SOFTWARE_SUSPEND or none of them, right? Only CONFIG_ACPI_SLEEP 
matters?

Regards,
David Härdeman
david@2gen.com

