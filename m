Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964930AbWEOOJU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964930AbWEOOJU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 10:09:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964935AbWEOOJU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 10:09:20 -0400
Received: from mail1.kontent.de ([81.88.34.36]:17871 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S964930AbWEOOJT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 10:09:19 -0400
From: Oliver Neukum <oliver@neukum.org>
To: "Jaya Kumar" <jayakumar.video@gmail.com>
Subject: Re: [PATCH/RFC 2.6.16.5 1/1] usb/media/quickcam_messenger driver v2
Date: Mon, 15 May 2006 16:09:47 +0200
User-Agent: KMail/1.8
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
References: <200605150849.k4F8nXDb031881@localhost.localdomain> <200605151235.10690.oliver@neukum.name> <70066d530605150550q55deb127w1ab2a4451b065a54@mail.gmail.com>
In-Reply-To: <70066d530605150550q55deb127w1ab2a4451b065a54@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605151609.48217.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, 15. Mai 2006 14:50 schrieb Jaya Kumar:
> On 5/15/06, Oliver Neukum <oliver@neukum.name> wrote:
> > Am Montag, 15. Mai 2006 10:49 schrieb jayakumar.video@gmail.com:
> > > +urb->status = 0;
> > > +urb->actual_length = 0;
> >
> > These are not needed. Indeed you should never write to those fields.
> >
> >         Regards
> >                 Oliver
> >
> 
> I see. Good point. I ought to have actually looked at usb_submit_urb
> and seen that it initializes status and actual_length. I'll make the
> change.
> 
> To reduce my embarrassment, I'll point out that several other media
> drivers also do this:
> 
> drivers/usb/media % egrep "urb->status.*=" *.c
> <snip>
> konicawc.c:        urb->status = 0;
> se401.c:        urb->status=0;
> stv680.c:       urb->status = 0;
> usbvideo.c:     urb->status = 0;
> w9968cf.c:      urb->status = 0;
> 
> In most of the above cases, it appears to be just before resubmitting the urb.

There's your opportunity to remove even more unnecessary kernel code.

	Regards
		Oliver
