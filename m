Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932119AbVKWSBr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932119AbVKWSBr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 13:01:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932123AbVKWSBr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 13:01:47 -0500
Received: from mail.kroah.org ([69.55.234.183]:10660 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932119AbVKWSBq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 13:01:46 -0500
Date: Wed, 23 Nov 2005 10:01:08 -0800
From: Greg KH <gregkh@suse.de>
To: Luiz Fernando Capitulino <lcapitulino@mandriva.com.br>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
       akpm@osdl.org, ehabkost@mandriva.com
Subject: Re: [RESEND 2/2] - usbserial: race-condition fix.
Message-ID: <20051123180108.GB26433@suse.de>
References: <20051122195926.18c3221c.lcapitulino@mandriva.com.br> <20051122221353.GA10311@suse.de> <20051123154650.5659b7fc.lcapitulino@mandriva.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051123154650.5659b7fc.lcapitulino@mandriva.com.br>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 23, 2005 at 03:46:50PM -0200, Luiz Fernando Capitulino wrote:
> On Tue, 22 Nov 2005 14:13:53 -0800
> Greg KH <gregkh@suse.de> wrote:
> 
> | On Tue, Nov 22, 2005 at 07:59:26PM -0200, Luiz Fernando Capitulino wrote:
> | > @@ -60,6 +61,7 @@ struct usb_serial_port {
> | >  	struct usb_serial *	serial;
> | >  	struct tty_struct *	tty;
> | >  	spinlock_t		lock;
> | > +	struct semaphore        sem;
> | 
> | You forgot to document what this semaphore is used for.
> 
>  Here goes the second patch again, with the documentation now.
> 
>  As I said before, would be good to apply these two patches now, and I
> can cleanup the spinlock usage until next week.

How will you clean it up?

>  Fixes a race-condition in the access of the port structure, described
> in detail at: http://marc.theaimsgroup.com/?l=linux-kernel&m=113216151918308&w=2

Please put the full detail in the email, so I can put it in the
ChangeLog so people have an easy place to get the proper information.

Care to redo it again?

thanks,

greg k-h
