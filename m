Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316855AbSFKGiK>; Tue, 11 Jun 2002 02:38:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316857AbSFKGiJ>; Tue, 11 Jun 2002 02:38:09 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:21969 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S316855AbSFKGiH>;
	Tue, 11 Jun 2002 02:38:07 -0400
Date: Tue, 11 Jun 2002 08:34:47 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Chris Faherty <rallymonkey@bellsouth.net>
Cc: Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org
Subject: Re: Logitech Mouseman Dual Optical defaults to 400cpi
Message-ID: <20020611083447.A6592@ucw.cz>
In-Reply-To: <20020608165243Z317422-22020+923@vger.kernel.org> <20020611045213.8B1FA59D354@kerberos.suse.cz> <20020611075643.C6425@ucw.cz> <20020611062940.8172959D354@kerberos.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 11, 2002 at 02:30:28AM -0400, Chris Faherty wrote:

> On Tuesday 11 June 2002 01:56 am, Vojtech Pavlik wrote:
> 
> > Btw, for more frequent reporting it's enough to modify the irq interrupt
> > rate in the HID driver, works for any mouse.
> 
> I want I want!  But I can't figure it out.  Can you give me an example of 
> how I would change the irq interrupt rate so that my mouse reports at 200Hz 
> in kernel 2.2.20?  Thanks.

Change the last argument of

FILL_INT_URB(hid->urbin, dev, pipe, hid->inbuf, 0, hid_irq_in, hid, endpoint->bInterval);

to 5. The normal value is 10. And it's milliseconds per poll of the
mouse. This may be made a quirk also.

-- 
Vojtech Pavlik
SuSE Labs
