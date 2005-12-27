Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750724AbVL0StP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750724AbVL0StP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Dec 2005 13:49:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751125AbVL0StP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Dec 2005 13:49:15 -0500
Received: from mgw-ext04.nokia.com ([131.228.20.96]:20553 "EHLO
	mgw-ext04.nokia.com") by vger.kernel.org with ESMTP
	id S1750724AbVL0StO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Dec 2005 13:49:14 -0500
Message-ID: <43B18C75.6030807@indt.org.br>
Date: Tue, 27 Dec 2005 14:48:21 -0400
From: Carlos Aguiar <carlos.aguiar@indt.org.br>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Anderson Lizardo <anderson.lizardo@gmail.com>
CC: David Brownell <david-b@pacbell.net>,
       Anderson Lizardo <anderson.lizardo@indt.org.br>,
       linux-omap-open-source@linux.omap.com,
       linux-arm-kernel@lists.arm.linux.org.uk, linux-kernel@vger.kernel.org,
       Anderson Briglia <anderson.briglia@indt.org.br>,
       Russell King - ARM Linux <linux@arm.linux.org.uk>,
       Tony Lindgren <tony@atomide.com>
Subject: Re: [patch 0/5] Add MMC password protection (lock/unlock) support
References: <20051213213208.303580000@localhost.localdomain>	 <200512131403.53983.david-b@pacbell.net> <5b5833aa0512141448o1014e7a5vdfd62cfdc61c7d11@mail.gmail.com>
In-Reply-To: <5b5833aa0512141448o1014e7a5vdfd62cfdc61c7d11@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 27 Dec 2005 18:48:32.0752 (UTC) FILETIME=[22CA7F00:01C60B16]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anderson Lizardo wrote:

>On 12/13/05, David Brownell <david-b@pacbell.net> wrote:
>  
>
>>Is there a writeup on how to hook this up with the key retention
>>infrastructure?  I know many folk are unfamiliar with that, and
>>I seem to recall a need for some userspace tweaks.  (Like SHA1
>>hashing of passphrases to generate MMC keys, and maybe storing
>>keys in some per-user file using some user interface.)
>>    
>>
>
>We have created a sample text-mode reference UI (using keyctl from the
>keyutils[1] package to interface with the key retention service) that
>shows how everything works together. We are setting up some web space
>to put such UI (actually a set of shell scripts) and we will provide
>links soon.
>
>Regarding the userspace tweaks, we have not gone into this aspect, but
>just provided the "core" kernel code. Usually, those integrating the
>system will dictate policies regarding password hashing, persistent
>caching etc. The policies for our reference UI were:
>
>- no hashing (password is sent/stored clear-text)
>- in-memory caching (so if the user reboots the system, the password
>will have to be re-typed).
>
>I think those policies can be done still on userspace, so the kernel
>code remains "policy-free".
>
>[1] http://people.redhat.com/~dhowells/keyutils/
>--
>Anderson Lizardo
>Embedded Linux Lab - 10LE
>Nokia Institute of Technology - INdT
>Manaus - Brazil
>
>  
>
Hi all,

As promised, you can find a simple text-mode reference UI for the MMC 
password protection
support, written in shell script, that shows how everything works 
together on the links below:

http://www.indt.org.br/10le/mmc_pwd/mmc_reference_ui-20051215.tar.gz
http://www.indt.org.br/10le/mmc_pwd/mmc_test-20051215.sh


BR,

Carlos Aguiar.



-- 
Carlos Eduardo
Software Engineer
Nokia Institute of Technology - INdT
Embedded Linux Laboratory - 10LE
Phone: +55 92 2126-1079
Mobile: +55 92 8127-1797
E-mail: carlos.aguiar@indt.org.br

