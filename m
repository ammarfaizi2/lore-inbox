Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263172AbTLADZo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Nov 2003 22:25:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263176AbTLADZo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Nov 2003 22:25:44 -0500
Received: from 198.216-123-194-0.interbaun.com ([216.123.194.198]:3461 "EHLO
	harddata.com") by vger.kernel.org with ESMTP id S263172AbTLADZn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Nov 2003 22:25:43 -0500
Date: Sun, 30 Nov 2003 20:25:21 -0700
From: Michal Jaegermann <michal@harddata.com>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: Lukas Hejtmanek <xhejtman@mail.muni.cz>, linux-kernel@vger.kernel.org
Subject: Re: Synaptics PS/2 driver and 2.6.0-test11
Message-ID: <20031130202521.A30370@mail.harddata.com>
References: <20031130214612.GP2935@mail.muni.cz> <200311301728.10563.dtor_core@ameritech.net> <20031130223953.GR2935@mail.muni.cz> <200311301826.52978.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200311301826.52978.dtor_core@ameritech.net>; from dtor_core@ameritech.net on Sun, Nov 30, 2003 at 06:26:52PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 30, 2003 at 06:26:52PM -0500, Dmitry Torokhov wrote:
> On Sunday 30 November 2003 05:39 pm, Lukas Hejtmanek wrote:
> > On Sun, Nov 30, 2003 at 05:28:10PM -0500, Dmitry Torokhov wrote:
> >
> > I'm using ACPI both in 2.4.22 and 2.6.0. I'm using battery_applet
> > (gnome applet) for testing battery state.
> >
> > I will try it. Is acpi=off at boot time enough for that?
> 
> How often does battery_applet poll the battery?

This particular applet was written by some genius to read a state
from ACPI _every second_.  To add insult to injury it rereads a
constant information from ...battery/info on every round instead of
storing it.  As you can guess it can sink a substantial amount of
cycles and other resources especially that ACPI in BIOS is also
often on a very heavy side.

> Start with polling the
> battery less often, let's say every 3 minutes

Likely even every 3 seconds will make a difference but maybe not
enough.

   Michal
