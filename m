Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261256AbVBMIfn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261256AbVBMIfn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Feb 2005 03:35:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261255AbVBMIfn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Feb 2005 03:35:43 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:16356 "EHLO suse.cz")
	by vger.kernel.org with ESMTP id S261257AbVBMIfg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Feb 2005 03:35:36 -0500
Date: Sun, 13 Feb 2005 09:36:11 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: harald.hoyer@redhat.de, lifebook@conan.de,
       linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
Subject: Re: [rfc/rft] Fujitsu B-Series Lifebook PS/2 TouchScreen driver
Message-ID: <20050213083611.GE1535@ucw.cz>
References: <20050211201013.GA6937@ucw.cz> <200502130149.11183.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200502130149.11183.dtor_core@ameritech.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 13, 2005 at 01:49:10AM -0500, Dmitry Torokhov wrote:

> On Friday 11 February 2005 15:10, Vojtech Pavlik wrote:
> > +       if (set_properties) {
> > +               psmouse->vendor = "Fujitsu Lifebook";
> > +               psmouse->name = "TouchScreen";
> > +       }
> > +
> > +       psmouse->dev.evbit[0] = BIT(EV_ABS) | BIT(EV_KEY) | BIT(EV_REL);
> > +       psmouse->dev.keybit[LONG(BTN_LEFT)] = BIT(BTN_LEFT) | BIT(BTN_MIDDLE) | BIT(BTN_RIGHT);
> > +       psmouse->dev.keybit[LONG(BTN_TOUCH)] = BIT(BTN_TOUCH);
> > +       psmouse->dev.relbit[0] = BIT(REL_X) | BIT(REL_Y);
> > +       input_set_abs_params(&psmouse->dev, ABS_X, 130, 885, 0, 0);
> > +       input_set_abs_params(&psmouse->dev, ABS_Y, 272, 830, 0, 0);
> > +
> > +       psmouse->protocol_handler = lifebook_process_byte;
> > +       psmouse->disconnect = lifebook_disconnect;
> > +       psmouse->reconnect = lifebook_reconnect;
> > +       psmouse->pktsize = 3;
> > 
> 
> Hi Vojtech,
> 
> I have been trying not alter kernel state in probe routines (still has
> to touch hardware for mice that do not have separate detection routine)
> unless set_properties is set. So all of the above should be in 
> "if (set_properties)" statement.

Ok, I updated the patch.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
