Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266322AbUAHWHf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 17:07:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266323AbUAHWHe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 17:07:34 -0500
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:21735 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id S266322AbUAHWHD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 17:07:03 -0500
From: Darren Williams <dsw@gelato.unsw.edu.au>
To: Dominik Strasser <dominik@die-strassers.de>,
       Linux Kern <linux-kernel@vger.kernel.org>
Date: Fri, 9 Jan 2004 09:06:56 +1100
Subject: Re: Mouse wheel does not work with 2.6
Message-ID: <20040108220656.GA27582@cse.unsw.EDU.AU>
References: <3FFD50F8.1020805@die-strassers.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FFD50F8.1020805@die-strassers.de>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dominik

Are you using under X or console?

I can confirm that MX600 logitech cordless USB works
under  2.6.0 RH 9, I do not have the exact details on config
file here. From memory I have
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y

and set XFree86Config
# **********************************************************************
# Core Pointer's InputDevice section
# **********************************************************************
                                                                                                                                                             
Section "InputDevice"
                                                                                                                                                             
# Identifier and driver
                                                                                                                                                             
    Identifier  "Mouse1"
    Driver      "mouse"
    Option "Protocol"    "ImPS/2"
    Option "Device"      "/dev/psaux"
    Option "ZaxisMapping" "4 5"

I also attach the mouse via one of those usb=>ps2 adapter things
supplied by logitech.


Darren


On Thu, 08 Jan 2004, Dominik Strasser wrote:

> Hi,
> my mouse, which is a Logitech cordless wheel mouse does not work fully 
> under 2.6.
> The wheel doesn't work; no events are sent.
> 
> The mouse is correctly identified:
> 
> mice: PS/2 mouse device common for all mice
> 
> input: PS2++ Logitech Wheel Mouse on isa0060/serio1
> 
> I already tried with "psmouse_proto=imps" as kernel parameter, but 
> without success.
> 
> Any hints anybody ?
> 
> Regards
> 
> Dominik
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
--------------------------------------------------
Darren Williams <dsw AT gelato.unsw.edu.au>
Gelato@UNSW <www.gelato.unsw.edu.au>
--------------------------------------------------
