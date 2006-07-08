Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964865AbWGHPKQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964865AbWGHPKQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jul 2006 11:10:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964866AbWGHPKQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jul 2006 11:10:16 -0400
Received: from nz-out-0102.google.com ([64.233.162.193]:24408 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S964865AbWGHPKP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jul 2006 11:10:15 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=f6rD8PtWQVVNKIQsNY+InGdLMoKYFcnYbwNCEheFWcW4NNntUI6I/BbscLsiDsookowY6/X52KB1gd/4mUkXXM+8pcrsf3nOfKV2oP7U2cmPc2Batus/zFJkOnTCbrwqb8mRj4WnlvpXjYP56L5KNJoaaTPUsWzcC59LYkJD06A=
Message-ID: <44AFCADA.6050805@gmail.com>
Date: Sat, 08 Jul 2006 09:10:18 -0600
From: Jim Cromie <jim.cromie@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: Chris Boot <bootc@bootc.net>
CC: kernel list <linux-kernel@vger.kernel.org>, soekris-tech@lists.soekris.com
Subject: Re: [Soekris] [RFC][PATCH] LED Class support for Soekris net48xx
References: <44AF7B00.9060108@bootc.net>
In-Reply-To: <44AF7B00.9060108@bootc.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Boot wrote:
> Hi all,
>
> After many years using Linux and hanging about on LKML without having 
> done much actual kernel hacking, I've decided to have a go! The module 
> below adds LED Class device support for the Soekris net48xx Error LED. 
> Tested only on a net4801, but should work on a net4826 as well. I'd 
> love to find a way of detecting a Soekris net48xx device but there is 
> no DMI or any Soekris-specific PCI devices.
>
> The patch is attached because Thunderbird kills tabs.
>
FWIW, the vintage scx200_gpio driver manipulates the LED just fine.

# cat /etc/modprobe.d/gpio
# assign last 2 dynamic devnums to gpio (255..240)
options scx200_gpio major=240
options pc8736x_gpio major=241

soekris:~# ll /dev/led
crw-r--r-- 1 root root 240, 20 Jun 24  2005 /dev/led

echo 1 > /dev/led


Is this insufficient ?
