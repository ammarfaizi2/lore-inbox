Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130051AbQKCAQm>; Thu, 2 Nov 2000 19:16:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130139AbQKCAQc>; Thu, 2 Nov 2000 19:16:32 -0500
Received: from [216.161.55.93] ([216.161.55.93]:21488 "EHLO blue.int.wirex.com")
	by vger.kernel.org with ESMTP id <S130051AbQKCAQT>;
	Thu, 2 Nov 2000 19:16:19 -0500
Date: Thu, 2 Nov 2000 16:16:11 -0800
From: Greg KH <greg@wirex.com>
To: Sasi Peter <sape@iq.rulez.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.2.18pre19
Message-ID: <20001102161610.C2424@wirex.com>
Mail-Followup-To: Greg KH <greg@wirex.com>, Sasi Peter <sape@iq.rulez.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20001102132206.B2424@wirex.com> <Pine.LNX.4.10.10011030203590.31286-300000@iq.rulez.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.10.10011030203590.31286-300000@iq.rulez.org>; from sape@iq.rulez.org on Fri, Nov 03, 2000 at 02:08:53AM +0100
X-Operating-System: Linux 2.4.0-test10 (i686)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 03, 2000 at 02:08:53AM +0100, Sasi Peter wrote:
> On Thu, 2 Nov 2000, Greg KH wrote:
> 
> > Could you send the result of /proc/interrupts and 'lspci -v'?
> > Also, have you tried the alternate UHCI controller driver?
> > Or tried USB as modules, instead of compiled in?
> 
> Here you go. I did work w/ the very same hw with pre15.

Looks like USB and your sound card is on the same interrupt.  Is there
any BIOS settings you can make to move these around?

> I have never really knew what the UHCI JE was all about... So it can be
> used in place of the original UHCI? I will make a try. (and why JE?)

Long story, short answer: 2 different developers working on support for
the same device.  Both drivers work better for some people on different
devices.  JE is the author's initials (Johannes Erdfelt).

Personally for some devices I have I like one version, for others, I
like the other one.  Now if Johannes would ever fix the QUEUE_BULK bug,
I would be back to using only one driver :)

Let me know if moving the IRQs helps out.

greg k-h


-- 
greg@(kroah|wirex).com
http://immunix.org/~greg
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
