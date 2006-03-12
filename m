Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750932AbWCLUJK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750932AbWCLUJK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Mar 2006 15:09:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751725AbWCLUJK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Mar 2006 15:09:10 -0500
Received: from mail1.kontent.de ([81.88.34.36]:16085 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S1750932AbWCLUJJ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Mar 2006 15:09:09 -0500
From: Oliver Neukum <oliver@neukum.org>
To: linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] Re: 2.6.16-rc5 pppd oops on disconnects
Date: Sun, 12 Mar 2006 21:09:01 +0100
User-Agent: KMail/1.8
Cc: "Bob Copeland" <email@bobcopeland.com>,
       "Paul Fulghum" <paulkf@microgate.com>, paulus@samba.org,
       "Linux Kernel list" <linux-kernel@vger.kernel.org>,
       "Greg KH" <greg@kroah.com>
References: <b6c5339f0603100625k3410897fy3515d93fa1918c9@mail.gmail.com> <1142180789.4360.2.camel@x2.pipehead.org> <b6c5339f0603120958y7ebc2051q51e24835456d9fcd@mail.gmail.com>
In-Reply-To: <b6c5339f0603120958y7ebc2051q51e24835456d9fcd@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200603122109.02420.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Sonntag, 12. März 2006 18:58 schrieb Bob Copeland:
> On 3/12/06, Paul Fulghum <paulkf@microgate.com> wrote:
> > --- linux-2.6.16-rc5/drivers/usb/class/cdc-acm.c        2006-02-27 09:24:29.000000000 -0600
> > +++ b/drivers/usb/class/cdc-acm.c       2006-03-12 10:22:21.000000000 -0600
> > @@ -980,7 +980,7 @@ skip_normal_probe:
> >         usb_driver_claim_interface(&acm_driver, data_interface, acm);
> >
> >         usb_get_intf(control_interface);
> > -       tty_register_device(acm_tty_driver, minor, &control_interface->dev);
> > +       tty_register_device(acm_tty_driver, minor, NULL);
> >
> >         acm_table[minor] = acm;
> >         usb_set_intfdata (intf, acm);
> >
> 
> Paul,
> 
> No oops with the above patch.

I've got an itch. Is the order of interfaces in your device reversed?

	Regards
		Oliver
