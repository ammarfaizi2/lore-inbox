Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265228AbUABIKq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jan 2004 03:10:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265425AbUABIKq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jan 2004 03:10:46 -0500
Received: from smtp805.mail.sc5.yahoo.com ([66.163.168.184]:62083 "HELO
	smtp805.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S265228AbUABIKo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jan 2004 03:10:44 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Dax Kelson <dax@gurulabs.com>
Subject: Re: Synaptics 3button emulation hosed in 2.6.0-mm2
Date: Fri, 2 Jan 2004 03:10:36 -0500
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org
References: <1073024655.2516.11.camel@mentor.gurulabs.com> <1073029814.2516.39.camel@mentor.gurulabs.com> <200401020258.40092.dtor_core@ameritech.net>
In-Reply-To: <200401020258.40092.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200401020310.36979.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 02 January 2004 02:58 am, Dmitry Torokhov wrote:
> On Friday 02 January 2004 02:50 am, Dax Kelson wrote:
> > Section "InputDevice"
> >         Identifier  "Mouse0"
> >         Driver      "mouse"
> >         Option      "Protocol" "PS/2"
> >         Option      "Device" "/dev/psaux"
> >         Option      "ZAxisMapping" "4 5"
> >         Option      "Emulate3Buttons" "yes"
> > EndSection
> > Section "InputDevice"
> >         Identifier  "DevInputMice"
> >         Driver      "mouse"
> >         Option      "Protocol" "IMPS/2"
> >         Option      "Device" "/dev/input/mice"
> >         Option      "ZAxisMapping" "4 5"
> >         Option      "Emulate3Buttons" "no"
> > EndSection
>
> Here is your other trouble - /dev/input/mice gets data from _all_
> mouse-like devices in 2.6 so your touchpad data is processed twice.

Ok, it's a bit late here and I can't read anymore... Actually in 2.6
/dev/psaux and /dev/input/mice are synonims (different device node
numbers but the same underlying device).

Anyway, your touchpad data is still processed twice ;)

Dmitry
