Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272857AbRIGVzc>; Fri, 7 Sep 2001 17:55:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272860AbRIGVzX>; Fri, 7 Sep 2001 17:55:23 -0400
Received: from c1313109-a.potlnd1.or.home.com ([65.0.121.190]:15 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S272857AbRIGVzJ>;
	Fri, 7 Sep 2001 17:55:09 -0400
Date: Fri, 7 Sep 2001 14:54:37 -0700
From: Greg KH <greg@kroah.com>
To: Andy Isaacson <adi@hexapodia.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: USB IRQ routing problems on Via Apollo Pro 133A
Message-ID: <20010907145437.F25421@kroah.com>
In-Reply-To: <20010906004520.A2891@hexapodia.org> <20010906202536.A11264@middle.of.nowhere> <20010907154129.B9370@hexapodia.org> <20010907135703.D25421@kroah.com> <20010907164456.A27672@hexapodia.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010907164456.A27672@hexapodia.org>
User-Agent: Mutt/1.3.21i
X-Operating-System: Linux 2.2.19 (i586)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 07, 2001 at 04:44:56PM -0500, Andy Isaacson wrote:
> 
> Are you claiming that the USB controller IRQ line isn't routed to the
> APIC?  If so, I'm curious as to any evidence you can provide to that
> effect.

Yes.  The only evidence is emperical (Randy Dunlap and I sat down with
the motherboard one night and tried loads of different combinations and
couldn't get any of them to work.  He knows the APIC code much better
than I and determined that the IRQ line isn't even routed to the
controller at all.)

Then there's the Win2000 errata that claimed that it would not work in
SMP mode with this controller at all.  I do think that VIA eventually
came out with a patch for Win2000 that did something like "noapic" on
Linux does.

Other than that, sorry, no "official" documentation at all.  There was a
lot of discussion on the linux-usb mailing lists for a while about this
problem a number of months ago if you want to go dig them up.

thanks,

greg k-h
