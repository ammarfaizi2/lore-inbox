Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261445AbVHBOBX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261445AbVHBOBX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Aug 2005 10:01:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261526AbVHBOBW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Aug 2005 10:01:22 -0400
Received: from zproxy.gmail.com ([64.233.162.199]:59893 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261445AbVHBOBV convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Aug 2005 10:01:21 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=rJ3RTg2VZRYDuB7VTGKURLZM9Ic8WtBly9CdcmvX8JgNkwj4ibOzkeTKTkiUWLeeG75wYRlczSOh5MvXkWMs0ru/NPVwvcG+fMPiYzryih9SRjQCyKCwzyORjZgPmc2fzjCOGfFXF7+aNjrEreCpj4FoeNwaHTMODHNXIvovWOg=
Message-ID: <3aa654a40508020701e605533@mail.gmail.com>
Date: Tue, 2 Aug 2005 07:01:20 -0700
From: Avuton Olrich <avuton@gmail.com>
Reply-To: Avuton Olrich <avuton@gmail.com>
To: Con Kolivas <kernel@kolivas.org>
Subject: Re: [patch] i386 dynamic ticks 2.6.13-rc4 (code reordered)
Cc: linux-kernel@vger.kernel.org, tony@atomide.com,
       tuukka.tikkanen@elektrobit.com, ck@vds.kolivas.org
In-Reply-To: <200508021443.55429.kernel@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200508021443.55429.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/1/05, Con Kolivas <kernel@kolivas.org> wrote:
> This is a code reordered version of the dynamic ticks patch from Tony Lindgen
> and Tuukka Tikkanen - sorry about spamming your mail boxes with this, but
> thanks for the code. There is significant renewed interest by the lkml
> audience for such a feature which is why I'm butchering your code (sorry
> again if you don't like me doing this). The only real difference between your
> code and this patch is moving the #ifdef'd code out of code paths and putting
> it into dyn-tick specific files.

OK, I rolled my own patch, 2.6.13-rc4-ck1-reiser4+this patch and it
appears to be running on my desktop Asus A7N8X very well:

I am running with Local APIC/IO-APIC/APIC Timer and forceapic. Time
does not appear to be running slow, and I do not appear to have a slow
boot.

sbh@rocket ~ $ cat /sys/devices/system/timer/timer0/dyn_tick_state
suitable:       1
enabled:        1
using APIC:     1

[4294683.959000] dyn-tick: Maximum ticks to skip limited to 803
[4294683.959000] dyn-tick: Timer using dynamic tick

The nvidia driver also works, and the most unexpected thing is after a
few hours of running it seems stable :)

So, to repeat I'm only reporting sucess, I'm unsure of the power
savings but this computer is on all day.

Thanks,
avuton
-- 
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
