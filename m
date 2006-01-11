Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751195AbWAKNFy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751195AbWAKNFy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 08:05:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751384AbWAKNFx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 08:05:53 -0500
Received: from zproxy.gmail.com ([64.233.162.195]:54187 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751195AbWAKNFx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 08:05:53 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=mzaS/YObyya08/v0w91N1vVEX6OQKOacjqLNAC+ygupOnsAq+QAx9eRA6SpT7heEE8b8IBlKEj75B3tnUetgyUUGQ0z0Ce0r6137y75L0qR+xyOpS0/pf5N3bFOhCjPNlmhj83N8S90xh1bJgcJ4Z3OienQm9WzoxAzyR3YKrq4=
Message-ID: <43C502AA.1040200@gmail.com>
Date: Wed, 11 Jan 2006 21:05:46 +0800
From: "Antonino A. Daplas" <adaplas@gmail.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: Jan Engelhardt <jengelh@linux01.gwdg.de>, Dave Jones <davej@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Console debugging wishlist was: Re: oops pauser.
References: <20060105045212.GA15789@redhat.com> <Pine.LNX.4.61.0601102121400.16049@yvahk01.tjqt.qr> <43C4F8EE.10201@gmail.com> <200601111331.45940.ak@suse.de>
In-Reply-To: <200601111331.45940.ak@suse.de>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> On Wednesday 11 January 2006 13:24, Antonino A. Daplas wrote:
> 
>> In the VGA console, all buffers, including scrollback is in video RAM, but
>> the size is fixed and is very small.
> 
> I wonder if that can be fixed.

It can be done, but it will affect VGA console performance.
 
> 
>> With the framebuffer console, you can increase the size of the scrollback
>> buffer with the boot option:
>>
>> fbcon=scrollback:<n> (default is 32K)
> 
> On x86-64 vesafb is unusable slow because it does CPU scrolling cause
> it can't use the vesa BIOS - and the others don't work everywhere. So I don't
> think fbcon is an usable replacement.

How about vga16fb + fbcon? If scrolling is slow in vga16fb, fbset -vyres 800 should
increase performance significantly.

Tony
