Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964929AbWALBL2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964929AbWALBL2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 20:11:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964930AbWALBL1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 20:11:27 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:53768 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S964929AbWALBL1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 20:11:27 -0500
Date: Thu, 12 Jan 2006 02:11:25 +0100
From: Adrian Bunk <bunk@stusta.de>
To: dtor_core@ameritech.net
Cc: Patrick Read <pread99999@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: Oops in Kernel 2.6.15 usbhid
Message-ID: <20060112011125.GO29663@stusta.de>
References: <25ac9de40601052225i48bca97dx3ad796a1cd68f1c3@mail.gmail.com> <200601100054.51198.dtor_core@ameritech.net> <25ac9de40601110021r3e8d5075v6a5a7186533a4c8a@mail.gmail.com> <d120d5000601110631j6705c71cya5faf293cac148a6@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d120d5000601110631j6705c71cya5faf293cac148a6@mail.gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 11, 2006 at 09:31:32AM -0500, Dmitry Torokhov wrote:
> On 1/11/06, Patrick Read <pread99999@gmail.com> wrote:
> > On 1/9/06, Dmitry Torokhov <dtor_core@ameritech.net> wrote:
> > > ===================================================================
> > > --- work.orig/drivers/usb/input/pid.c
> > > +++ work/drivers/usb/input/pid.c
> > > @@ -259,7 +259,7 @@ static int hid_pid_upload_effect(struct
> > >  int hid_pid_init(struct hid_device *hid)
> > >  {
> > >         struct hid_ff_pid *private;
> > > -       struct hid_input *hidinput = list_entry(&hid->inputs, struct hid_input, list);
> > > +       struct hid_input *hidinput = list_entry(hid->inputs.next, struct hid_input, list);
> > >         struct input_dev *input_dev = hidinput->input;
> > >
> > >         private = hid->ff_private = kzalloc(sizeof(struct hid_ff_pid), GFP_KERNEL);
> > >
> >
> > The above fix works like a charm.  2.6.15 is running on this very
> > computer that I'm typing on.
> >
> > Thank you for your good work.  Please ensure that this fix gets
> > incorporated in the mainline kernel.
> >
> 
> Thank you for testing it, I will forward it to Linus.

Could you also forward it stable@kernel.org for inclusion in 2.6.15.x?

> Dmitry

TIA
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

