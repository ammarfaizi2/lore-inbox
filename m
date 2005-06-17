Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262023AbVFQRR1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262023AbVFQRR1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Jun 2005 13:17:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262024AbVFQRR1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Jun 2005 13:17:27 -0400
Received: from zproxy.gmail.com ([64.233.162.204]:3377 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262023AbVFQRRW convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Jun 2005 13:17:22 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=s+NikKPPlfSdhqU4iZjYkaunKJEUN1nR4agkPdYxxW1MMwR+KHUBkRZIZhcpnXSHqbiX7DWfW3hFfGtmJrXn0M+pOKp2mptpU3cn0fWqQ5SGUozXKY4gCWf6SGuDWObYvJg0OHp47WU+9zDb6WbkOzFSwqGHQUUFHB2vXyHRFIg=
Message-ID: <9a874849050617101712b80b15@mail.gmail.com>
Date: Fri, 17 Jun 2005 19:17:19 +0200
From: Jesper Juhl <jesper.juhl@gmail.com>
Reply-To: Jesper Juhl <jesper.juhl@gmail.com>
To: Alexander Fieroch <fieroch@web.de>
Subject: Re: [2.6.12rc4] PROBLEM: "drive appears confused" and "irq 18: nobody cared!"
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, bzolnier@gmail.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, axboe@suse.de,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
In-Reply-To: <42B302C2.9030009@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <d6gf8j$jnb$1@sea.gmane.org>
	 <20050527171613.5f949683.akpm@osdl.org> <429A2397.6090609@web.de>
	 <58cb370e05061401041a67cfa7@mail.gmail.com> <42B091EE.4020802@web.de>
	 <20050615143039.24132251.akpm@osdl.org>
	 <1118960606.24646.58.camel@localhost.localdomain>
	 <42B2AACC.7070908@web.de>
	 <1119011887.24646.84.camel@localhost.localdomain>
	 <42B302C2.9030009@web.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/17/05, Alexander Fieroch <fieroch@web.de> wrote:
> Alan Cox wrote:
> >>Jun 17 12:07:49 orclex kernel: hdb: cdrom_pc_intr: The drive appears confused (ireason = 0x01)
> >>Jun 17 12:07:49 orclex kernel: irq 18: nobody cared (try booting with the "irqpoll" option.
> >
> > Something failed to clear IRQ 18, that typically means there are IRQ
> > routing problems rather than IDE ones and would explain your traces.
> >
> > Try booting with acpi=off and see what trace you get then.
> 
> acpi=off makes linux hang and not continuing booting. Hm, syslog does
> not contain the trace until that crash but the last lines before the
> hanging are:
> 
> ehci_hcd 0000:00:1d.7: USB 2.0 initialized, EHCI 1.00, driver 10 Dec 2004
> hub 1-0:1.0: USB hub found
> 
> 
> I've tried booting the kernel with parameter irqpoll as you have
> suggested but it leads to a kernel panic.
> The last line was:
> 
> kernel panic - not syncing: Aiee, killing interrupt handler!
> 
> It's not saved in syslog too, so is there any way to get the trace to a
> file?
> 
serial console & netconsole - see Documentation/serial-console.txt and
Documentation/networking/netconsole.txt

And there's also the kernel "console on line printer" option if you
want the messages printed on a printer instead.  You also have the
option of writing the text down by hand with pen & paper (using a fb
console with lots of lines help keep many messages visible for this) -
some people also use a digital camera to take a photo of the screen.


-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
