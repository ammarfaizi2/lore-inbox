Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318562AbSHEPzt>; Mon, 5 Aug 2002 11:55:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318563AbSHEPzt>; Mon, 5 Aug 2002 11:55:49 -0400
Received: from 12-231-243-94.client.attbi.com ([12.231.243.94]:55310 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S318562AbSHEPzt>;
	Mon, 5 Aug 2002 11:55:49 -0400
Date: Mon, 5 Aug 2002 08:56:58 -0700
From: Greg KH <greg@kroah.com>
To: Marek Michalkiewicz <marekm@amelek.gda.pl>
Cc: marcelo@conectiva.com.br, mdharm-usb@one-eyed-alien.net, mwilck@freenet.de,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] USB storage: Datafab KECF-USB, Sagatek DCS-CF
Message-ID: <20020805155658.GE27306@kroah.com>
References: <20020626145741.GD4611@kroah.com> <E17bLKe-0001p2-00@alf.amelek.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E17bLKe-0001p2-00@alf.amelek.gda.pl>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.2.21 (i586)
Reply-By: Mon, 08 Jul 2002 14:36:57 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 04, 2002 at 03:22:04PM +0200, Marek Michalkiewicz wrote:
> Hi,
> 
> > Heh, send this to me again after 2.4.19-final is out, and I'll
> > reconsider it :)
> 
> Over a month later, here it is - this drivers/usb/storage/unusual_devs.h
> entry appears to be sufficient to make my Sagatek DCS-CF work:
> 
> /* aka Sagatek DCS-CF */
> UNUSUAL_DEV(  0x07c4, 0xa400, 0x0000, 0xffff,
> 		"Datafab",
> 		"KECF-USB",
> 		US_SC_SCSI, US_PR_BULK, NULL,
> 		US_FL_FIX_INQUIRY ),

That's a wide range for this device, do you really need 0x0000 - 0xffff
for this?

And send a patch to Matt, if he agrees with it, he'll send it on to me.

thanks,

greg k-h
