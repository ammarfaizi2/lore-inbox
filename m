Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264389AbTLKVXr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Dec 2003 16:23:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264392AbTLKVXr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Dec 2003 16:23:47 -0500
Received: from massena-4-82-67-197-146.fbx.proxad.net ([82.67.197.146]:64640
	"EHLO perso.free.fr") by vger.kernel.org with ESMTP id S264389AbTLKVXp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Dec 2003 16:23:45 -0500
From: Duncan Sands <baldrick@free.fr>
To: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [linux-usb-devel] Re: [OOPS,  usbcore, releaseintf] 2.6.0-test10-mm1
Date: Thu, 11 Dec 2003 22:23:43 +0100
User-Agent: KMail/1.5.4
Cc: Kernel development list <linux-kernel@vger.kernel.org>,
       USB development list <linux-usb-devel@lists.sourceforge.net>
References: <Pine.LNX.4.44L0.0312111016230.1227-100000@ida.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.0312111016230.1227-100000@ida.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312112223.43056.baldrick@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> It should handle that okay (provided you retain a reference to the
> usb_device so that it doesn't get deallocated).  Although it wouldn't hurt
> to change one of the tests from
>
> 	if (dev->state != USB_STATE_ADDRESS)
>
> to
>
> 	if (dev->state > USB_STATE_ADDRESS)

By the way, my patch tests for disconnect in usbfs by doing:

if (dev->state == USB_STATE_NOTATTACHED)
	run_away();

Is this right?

Thanks,

Duncan.
