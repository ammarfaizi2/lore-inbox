Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752274AbWCNF0a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752274AbWCNF0a (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 00:26:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752281AbWCNF0a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 00:26:30 -0500
Received: from smtp106.sbc.mail.re2.yahoo.com ([68.142.229.99]:121 "HELO
	smtp106.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1752274AbWCNF0a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 00:26:30 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Arjan van de Ven <arjan@infradead.org>
Subject: Re: [PATCH] Expose input device usages to userspace
Date: Tue, 14 Mar 2006 00:26:28 -0500
User-Agent: KMail/1.9.1
Cc: Elias Naur <elias@oddlabs.com>, linux-kernel@vger.kernel.org
References: <200603132154.38876.elias@oddlabs.com> <1142283779.3023.49.camel@laptopd505.fenrus.org>
In-Reply-To: <1142283779.3023.49.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603140026.28522.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 13 March 2006 16:02, Arjan van de Ven wrote:
> On Mon, 2006-03-13 at 21:54 +0100, Elias Naur wrote:
> > Hi,
> > 
> > I believe that the current event input interface is missing some kind of 
> > information about the general kind of input device (Mouse, Keyboard, Joystick 
> > etc.) so I added a simple ioctl to do just that. The relevant line in 
> > include/linux/input.h is:
> > 
> > #define EVIOCGUSAGE(len)    _IOC(_IOC_READ, 'E', 0x1c, len)         /* get all 
> > usages */
> > 
> > It returns a bit set with the device usages. Current usages are:
> > 
> > #define USAGE_MOUSE         0x00
> > #define USAGE_JOYSTICK      0x01
> > #define USAGE_GAMEPAD       0x02
> > #define USAGE_KEYBOARD      0x03
> 
> 
> I'm not sure that this is a good idea in general.
> However when you do it, at least make it a bitmap; things can be both a
> mouse and a keyboard for example.
> 

No, I don't think this is needed at all - users should be interested in
what capabilities a particular device has, not what type it was assigned
by soneone.

-- 
Dmitry
