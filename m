Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261605AbVBHRnk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261605AbVBHRnk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Feb 2005 12:43:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261607AbVBHRnk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Feb 2005 12:43:40 -0500
Received: from imag.imag.fr ([129.88.30.1]:56788 "EHLO imag.imag.fr")
	by vger.kernel.org with ESMTP id S261605AbVBHRnh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Feb 2005 12:43:37 -0500
Message-ID: <4208FC2E.4010306@naurel.org>
Date: Tue, 08 Feb 2005 18:51:42 +0100
From: =?ISO-8859-1?Q?Aur=E9lien_Francillon?= <aurel@naurel.org>
User-Agent: Mozilla Thunderbird 1.0 (X11/20050117)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Stefan Seyfried <seife@suse.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: [BUG]  linux-2.6.11-rc3 probably in ACPI  battery procfs ...
References: <4207557B.2090500@naurel.org> <4208BC68.8070700@suse.de>
In-Reply-To: <4208BC68.8070700@suse.de>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Greylist: Message not sent from an IPv4 address, not delayed by milter-greylist-1.4 (imag.imag.fr [IPv6:2001:660:5301:1e::101]); Tue, 08 Feb 2005 18:43:09 +0100 (CET)
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-Information: Please contact the ISP for more information
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stefan Seyfried wrote:
> aurelien francillon wrote:
> 
>>hi,
>>since just before linux-2.6.11-rc3  ( i think it's rc2-bk10 ) there
>>seems to have a bug in the acpi part of the proc file system :
>>reading /proc/acpi/battery/BAT0/info  takes a very long time and locks
>>up the computer, time gives:
>>cat /proc/acpi/battery/BAT0/info  0.00s user 6.76s system 12030% cpu
>>0.056 total
>>I notice it because kde reads it every 10seconds ... so the compuer gets
>>locked for ~5s every ~10s ...
> 
> 
>>computer is a dell D600 laptop,
> 
> 
> I have seen the same on a D600 and an Compaq Armada E500, not 6 seconds
> but ~1.2 seconds. Try to put a
> 
> #define ACPI_ENABLE_OBJECT_CACHE 1
> 
> at the end of include/acpi/acpi.h (before the last #endif), this sort of
> fixed it for me (now it again needs ~0.2 seconds, still way too long,
> but the same as with the last good 2.6.11-rc2-bk9).
> 
> Good luck :-)
> 
> Stefan
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


that's "fixed" it for me too,
thanks
Aurel

-- 
Lat:     45:11:43N (45.1954)
Lon:      5:43:36E ( 5.7268)
