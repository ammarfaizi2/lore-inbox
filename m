Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752295AbWCNFdW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752295AbWCNFdW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 00:33:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752292AbWCNFdW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 00:33:22 -0500
Received: from cicero2.cybercity.dk ([212.242.40.53]:38365 "EHLO
	cicero2.cybercity.dk") by vger.kernel.org with ESMTP
	id S1750827AbWCNFdV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 00:33:21 -0500
From: Elias Naur <elias@oddlabs.com>
Organization: Oddlabs ApS
To: Arjan van de Ven <arjan@infradead.org>
Subject: Re: [PATCH] Expose input device usages to userspace
Date: Tue, 14 Mar 2006 06:33:38 +0100
User-Agent: KMail/1.8.2
Cc: Dmitry Torokhov <dtor_core@ameritech.net>, linux-kernel@vger.kernel.org
References: <200603132154.38876.elias@oddlabs.com> <1142283779.3023.49.camel@laptopd505.fenrus.org>
In-Reply-To: <1142283779.3023.49.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603140633.38576.elias@oddlabs.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 13 March 2006 22:02, Arjan van de Ven wrote:
> On Mon, 2006-03-13 at 21:54 +0100, Elias Naur wrote:
> > Hi,
> >
> > I believe that the current event input interface is missing some kind of
> > information about the general kind of input device (Mouse, Keyboard,
> > Joystick etc.) so I added a simple ioctl to do just that. The relevant
> > line in include/linux/input.h is:
> >
> > #define EVIOCGUSAGE(len)    _IOC(_IOC_READ, 'E', 0x1c, len)         /*
> > get all usages */
> >
> > It returns a bit set with the device usages. Current usages are:
> >
> > #define USAGE_MOUSE         0x00
> > #define USAGE_JOYSTICK      0x01
> > #define USAGE_GAMEPAD       0x02
> > #define USAGE_KEYBOARD      0x03
>
> I'm not sure that this is a good idea in general.

Can you elaborate on the reasons? My thinking is that HID is going to be 
pretty much the standard for input devices, and they all expose nicely 
defined usages. Furthermore, "those other OS'es" already expose device 
usages :)

> However when you do it, at least make it a bitmap; things can be both a
> mouse and a keyboard for example.

It already is a bitmap. The USAGE_* constants are the bit indices, just like 
the EV_* constants.

 - elias
