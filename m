Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750763AbWHKIJg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750763AbWHKIJg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Aug 2006 04:09:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750767AbWHKIJg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Aug 2006 04:09:36 -0400
Received: from embla.aitel.hist.no ([158.38.50.22]:46023 "HELO
	embla.aitel.hist.no") by vger.kernel.org with SMTP id S1750763AbWHKIJf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Aug 2006 04:09:35 -0400
Message-ID: <44DC3A7C.9050903@aitel.hist.no>
Date: Fri, 11 Aug 2006 10:06:20 +0200
From: Helge Hafting <helge.hafting@aitel.hist.no>
User-Agent: Thunderbird 1.5.0.4 (X11/20060713)
MIME-Version: 1.0
To: Molle Bestefich <molle.bestefich@gmail.com>
CC: John Stoffel <john@stoffel.org>, linux-kernel@vger.kernel.org
Subject: Re: ext3 corruption
References: <62b0912f0607131332u5c390acfrd290e2129b97d7d9@mail.gmail.com>	 <62b0912f0608081647p2d540f43t84767837ba523dc4@mail.gmail.com>	 <Pine.LNX.4.61.0608090723520.30551@chaos.analogic.com>	 <62b0912f0608090822n2d0c44c4uc33b5b1db00e9d33@mail.gmail.com>	 <1A5F0A2F95110B3F35E8A9B5@dhcp-2-206.wgops.com>	 <62b0912f0608091128n4d32d437h45cf74af893dc7c8@mail.gmail.com>	 <20060810030602.GA29664@mail>	 <62b0912f0608100248w2b3c2243xec588aee8c5a9079@mail.gmail.com>	 <17627.23159.236724.190546@stoffel.org> <62b0912f0608101210k708ff3f5ua6af62e751fef7c7@mail.gmail.com>
In-Reply-To: <62b0912f0608101210k708ff3f5ua6af62e751fef7c7@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Molle Bestefich wrote:
> John Stoffel wrote:
>> Molle> And voila, that difficult task of assessing in which order to
>> Molle> do things is out of the hands of distros like Red Hat, and into
>> Molle> the hands of those people who actually make the binaries.
>>
>> *bwah hah hah!*
>
> No need to ridicule :-).
> After all, I'm just saying that there's got to be a simpler, stabler
> and more transparent way than to have all this logic sit in shell
> scripts.
Shellscripts are both simple and stable.  Still, you are not the only
one dissatisfied with the sysv init program.

Check out initng:
http://initng.thinktux.net/index.php/Main_Page
It uses config files instead of scripts.  Well, the config files
may contain scripts but they don't have to.  Dependencies
are described in a simple way in these files. Another advantage,
services that don't depend on each other start/stop in parallel,
cutting boot time to 1/3 or so. (30s from powerup to X display is easy.)

I use it on one machine.  It is kind of "unfinished" in that it
don't have config files for every service out there, but it works
and you can make your own files if your service isn't supported yet.

When I looked for a init replacement, I found several other
alternatives too.  All trying different approaches, often trying to save
time by starting up things in parallel, but with very different
approaches to dependencies.  Not all were good.  Some made the mistake
of having the dependant software having to start up all the sw
it depends on.  Consider the maintenance nightmare adding and
removing packages from such a system...

Helge Hafting
