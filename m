Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750703AbWCMVDI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750703AbWCMVDI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 16:03:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750789AbWCMVDI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 16:03:08 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:13988 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750703AbWCMVDG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 16:03:06 -0500
Subject: Re: [PATCH] Expose input device usages to userspace
From: Arjan van de Ven <arjan@infradead.org>
To: Elias Naur <elias@oddlabs.com>
Cc: Dmitry Torokhov <dtor_core@ameritech.net>, linux-kernel@vger.kernel.org
In-Reply-To: <200603132154.38876.elias@oddlabs.com>
References: <200603132154.38876.elias@oddlabs.com>
Content-Type: text/plain
Date: Mon, 13 Mar 2006 22:02:58 +0100
Message-Id: <1142283779.3023.49.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-03-13 at 21:54 +0100, Elias Naur wrote:
> Hi,
> 
> I believe that the current event input interface is missing some kind of 
> information about the general kind of input device (Mouse, Keyboard, Joystick 
> etc.) so I added a simple ioctl to do just that. The relevant line in 
> include/linux/input.h is:
> 
> #define EVIOCGUSAGE(len)    _IOC(_IOC_READ, 'E', 0x1c, len)         /* get all 
> usages */
> 
> It returns a bit set with the device usages. Current usages are:
> 
> #define USAGE_MOUSE         0x00
> #define USAGE_JOYSTICK      0x01
> #define USAGE_GAMEPAD       0x02
> #define USAGE_KEYBOARD      0x03


I'm not sure that this is a good idea in general.
However when you do it, at least make it a bitmap; things can be both a
mouse and a keyboard for example.


