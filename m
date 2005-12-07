Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751828AbVLGXfA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751828AbVLGXfA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 18:35:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751812AbVLGXe7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 18:34:59 -0500
Received: from www.eclis.ch ([144.85.15.72]:60561 "EHLO mail.eclis.ch")
	by vger.kernel.org with ESMTP id S1751828AbVLGXe6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 18:34:58 -0500
Message-ID: <439771A0.1000604@eclis.ch>
Date: Thu, 08 Dec 2005 00:34:56 +0100
From: Jean-Christian de Rivaz <jc@eclis.ch>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20051002)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: Gene Heskett <gene.heskett@verizon.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ntp problems
References: <200512050031.39438.gene.heskett@verizon.net> <200512070108.58466.gene.heskett@verizon.net> <43975A96.9090503@eclis.ch> <200512071750.20709.gene.heskett@verizon.net>
In-Reply-To: <200512071750.20709.gene.heskett@verizon.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gene Heskett a écrit :
> On Wednesday 07 December 2005 16:56, Jean-Christian de Rivaz wrote:
> 
>>Gene Heskett a écrit :
>>
>>>And, acpi is on, and ntpd is happy with the new bios.  Hurrah!
>>
>>Good news!
>>
>>I wonder if it would be a good idea to add something into the kernel or
>>into ntpd to alert the users that ntpd can't run normaly because of a
>>too fast drift ? Then a BIOS upgrade could be proposed (especially on a
>>nForce2 system). I don't know if it's even realistc.
>>
>>Regards,
> 
> 
> The drift itself wasn't what I'd call excessive, 
> something like 6 minutes in a week, which for 
> mainboard quality crystals is pretty darned good.

ntpd work only on system with a drift of maximum +/-500ppm. This post 
summarize a lot of informations about the problem:
http://marc.theaimsgroup.com/?l=linux-kernel&m=113105244509795&w=2
It was found later that an issue into the nForce2 is the root of the 
problem and that a BIOS update solve it.

6.0 / (60*24*7) * 1e6 = 595.24
6 minutes per week is near 600ppm, it's enough to trigg the problem you 
have seen. Even very cheap crystal are 100ppm at commercial temperature 
range. 100ppm is about 1 minute per week. Some crystal manufacturers 
propose now 30ppm as the default standard at commercial temperature range.

As your watch prove, good cristal can be just a few ppm (about 3.86ppm 
for your watch)

Regards,
-- 
Jean-Christian de Rivaz
