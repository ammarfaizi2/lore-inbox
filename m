Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751211AbWAKMYY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751211AbWAKMYY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 07:24:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751403AbWAKMYY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 07:24:24 -0500
Received: from zproxy.gmail.com ([64.233.162.195]:32733 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751211AbWAKMYX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 07:24:23 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=s1mklcqehecgZp9ngjskDN4qsS38vCuowyryM8dhEGMq4Q0tZGsOZLok6eI6BRkKC2/x7MWsRA4x+5BfBqLqb+hmRfbb9XjSoWC23NXygBpqjq9EjK+rWZ1WHi4iGeKEv5oMtjzNFtb/LVEz3j9FMNDtkLsoPRkItjW1dmEpQ2s=
Message-ID: <43C4F8EE.10201@gmail.com>
Date: Wed, 11 Jan 2006 20:24:14 +0800
From: "Antonino A. Daplas" <adaplas@gmail.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
CC: Andi Kleen <ak@suse.de>, Dave Jones <davej@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Console debugging wishlist was: Re: oops pauser.
References: <20060105045212.GA15789@redhat.com> <p73vewtw8bh.fsf@verdi.suse.de> <Pine.LNX.4.61.0601102121400.16049@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0601102121400.16049@yvahk01.tjqt.qr>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt wrote:
>> Ok - here's my personal wishlist. If someone is interested ...
>>
>> What I would like to have is a "more" option for the kernel that makes
>> it page kernel output like "more" and asks you before scrolling
>> to the next page.
> 
> An oops is usually a condition you can recover from in some/most/depends 
> cases (e.g. a null deref in a filesystem "only" makes that vfsmount 
> (filesystem at all?) blocked), so if the kernel is waiting for user input 
> on a non-panic condition, this means userspace stops too, which is not 
> too good if the kernel is still 'alive'.
> It's like we are entering kdb although everything is fine enough to go 
> through a proper `init 6`.
> 
>> What would be also cool would be to fix the VGA console to have 
>> a larger scroll back buffer.  The standard kernel boot output 
>> is far larger than the default scrollback, so if you get a hang
>> late you have no way to look back to all the earlier 
>> messages.
>>
>> (it is hard to understand that with 128MB+ graphic cards and 512+MB
>> computers the scroll back must be still so short...) 
> 
> I doubt this scrollback buffer is implemented as part of the video cards. 
> It is rather a kernel invention, and therefore uses standard RAM. But the 
> idea is good, preferably make it a CONFIG_ option.

In the VGA console, all buffers, including scrollback is in video RAM, but
the size is fixed and is very small.

With the framebuffer console, you can increase the size of the scrollback
buffer with the boot option:

fbcon=scrollback:<n> (default is 32K)

Tony
