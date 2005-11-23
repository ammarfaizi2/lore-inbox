Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030235AbVKWAcw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030235AbVKWAcw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 19:32:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030274AbVKWAcw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 19:32:52 -0500
Received: from xproxy.gmail.com ([66.249.82.197]:5847 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030235AbVKWAcv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 19:32:51 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=uLQNShM2qnOx2CarS5E84dqBwHWVGn5+xgAMCQbUnhBNXfiYUZG10rwOh32ujpxa9AlpwpeBv+88kD/NMAgEHx4pWhKmvyD4rxxRN3M1cbua21E9DxFlWXjFW1wOUA4D/ROXmxvStL+U6RhwWPX7vJhV3JuimbKTYV61DJti6AE=
Message-ID: <4383B880.80301@gmail.com>
Date: Wed, 23 Nov 2005 08:32:00 +0800
From: "Antonino A. Daplas" <adaplas@gmail.com>
User-Agent: Thunderbird 1.5 (X11/20051025)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Damien Wyart <damien.wyart@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: VESA fb console in 2.6.15
References: <20051121215531.GA3429@localhost.localdomain>	<43826648.9030606@gmail.com>	<87oe4c7gbv.fsf@brouette.noos.fr> <20051122162226.41305851.akpm@osdl.org>
In-Reply-To: <20051122162226.41305851.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Damien Wyart <damien.wyart@gmail.com> wrote:
>>>> I've noticed in several versions of 2.6.15 that VESA fb console
>>>> seems completely broken : it draws screen in several very slow
>>>> steps, making the whole display almos unusable. And it crashes
>>>> *very* often, for example when switching to X. The computer is
>>>> complety locked, and doesn't even respond to SysRQ.
>>>> I use vga=0x31B as boot param.
>> * "Antonino A. Daplas" <adaplas@gmail.com> [051122 01:28]:
>>
>>> Try booting with:
>>> vga=0x31b video=vesafb:mtrr:3
>> Thanks, this works fine with this param and also without any video=
>> param. I had a default video=vesafb:mtrr:2 in my grub conf file because
>> of mtrr problems a few kernel versions earlier (had been discussed
>> extensively on this list). This setting doesn't work well in 2.6.15.
>>
> 
> Does 2.6.15-rc? work OK without any special boot options? (We want it to..)
> 

>From what I understand, before this, he needs video=vesafb:mtrr:2. (Because
his machine defaults to write-back mtrr instead of write-combining). Now it
works without any special boot options because I made vesafb default to
nomtrr because of problems like this and conflicts with X/DRI.

Tony 

