Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965298AbVLRXQ2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965298AbVLRXQ2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Dec 2005 18:16:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965304AbVLRXQ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Dec 2005 18:16:28 -0500
Received: from zproxy.gmail.com ([64.233.162.199]:51189 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965298AbVLRXQ1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Dec 2005 18:16:27 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=lnLo9tkVY0D2U7+ogIylveKfwNE6klD0ctVZ1JswJXjISWSW7oQHokeGFpKcU/DP198q4hJ0iLvZ9CU4wT7tFWVtRu8q30yYS+k2ZA/gpBMamupRU+Tf9HCuR7tvqbJWvtzu2Su8leYasNoVOPbZg2DgN3M5B+uBbvdMWsR75no=
Message-ID: <43A5ED9E.3050306@gmail.com>
Date: Mon, 19 Dec 2005 07:15:42 +0800
From: "Antonino A. Daplas" <adaplas@gmail.com>
User-Agent: Thunderbird 1.5 (X11/20051025)
MIME-Version: 1.0
To: Sebastian Kaergel <mailing@wodkahexe.de>
CC: gregkh@suse.de, linux-kernel@vger.kernel.org, stable@kernel.org
Subject: Re: Linux 2.6.14.4 [intelfb problem]
References: <20051215005041.GB4148@kroah.com>	<20051218204253.b32a4f61.mailing@wodkahexe.de>	<43A5D963.9020201@gmail.com> <20051218232428.01d5f315.mailing@wodkahexe.de>
In-Reply-To: <20051218232428.01d5f315.mailing@wodkahexe.de>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sebastian Kaergel wrote:
> "Antonino A. Daplas" <adaplas@gmail.com> wrote:
>> Sometimes, this is just a problem with the bootloader not recognizing
>> the option parameters.
>>
>>> image=/boot/2.6.14.4-3
>>>  append="video=intelfb"
>> 'cat /proc/cmdline' should confirm if your options where actually passed
>> unchanged to the kernel.
> 
>  $ cat /proc/cmdline 
> BOOT_IMAGE=2.6.14.4 ro root=301 lapic video=intelfb
> 
> cmdline looks fine
> 

No.  You're missing the vga=791 parameter which is required by intelfb (if
connected to a flatpanel).

Why not change the lilo.conf to something like this?

append="vga=791 video=intelfb" # video=intelfb is not required if not passing
                               # parameters to intelfb
