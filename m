Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263205AbUCYPVS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Mar 2004 10:21:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263204AbUCYPVS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Mar 2004 10:21:18 -0500
Received: from smtp-out.girce.epro.fr ([195.6.195.146]:19799 "EHLO
	srvsec3.girce.epro.fr") by vger.kernel.org with ESMTP
	id S263205AbUCYPU7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Mar 2004 10:20:59 -0500
Message-ID: <138101c4127c$ba50f910$3cc8a8c0@epro.dom>
From: "Colin Leroy" <colin@colino.net>
To: "Alan Stern" <stern@rowland.harvard.edu>
Cc: <linux-kernel@vger.kernel.org>, <linux-usb-devel@lists.sf.net>
References: <Pine.LNX.4.44L0.0403250936480.1023-100000@ida.rowland.org>
Subject: Re: [linux-usb-devel] Re: [OOPS] reproducible oops with 2.6.5-rc2-bk3
Date: Thu, 25 Mar 2004 16:20:38 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> That's right.  However, the oops you saw shouldn't happen so long as
> intf->cur_altsetting points to something valid.  I got the impression
that
> in the cdc-acm probe routine maybe it was a null pointer.

Yes, i think so too.

> Can you insert
> a statement in the cdc-acm probe function to print out the values of
ifcom
> and ifdata, to check that they aren't NULL?

Already done, that's what helped me find this was related to altsettings
stuff. I didn't check to see if cur_altsetting was null, but a dev_dbg()
at the beginnning of the function was appearing, and not the dev_dbg() I
had put after this block.

> > I'm not sure the change in cdc-acm (which no longer uses index 0
> > altsetting) is correct. Or is this another bug in my phone (motorola
C350)
> > which should be handled differently than other cdc-acm devices ?
>
> It's hard to say without more information.  The contents of
> /proc/bus/usb/devices or the output of lsusb with the phone plugged in
> would help.

Ok, I'll try to do that tonight.
-- 
Colin

