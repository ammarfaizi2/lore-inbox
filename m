Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264472AbTEPQFf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 May 2003 12:05:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264473AbTEPQFf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 May 2003 12:05:35 -0400
Received: from h-68-165-86-241.DLLATX37.covad.net ([68.165.86.241]:10803 "EHLO
	sol.microgate.com") by vger.kernel.org with ESMTP id S264472AbTEPQFe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 May 2003 12:05:34 -0400
Subject: Re: Test Patch: 2.5.69 Interrupt Latency
From: Paul Fulghum <paulkf@microgate.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       johannes@erdfelt.com,
       USB development list <linux-usb-devel@lists.sourceforge.net>
In-Reply-To: <1053100440.1948.17.camel@toshiba>
References: <Pine.LNX.4.44L0.0305161045270.738-100000@ida.rowland.org>
	 <1053100440.1948.17.camel@toshiba>
Content-Type: text/plain
Organization: 
Message-Id: <1053101890.2606.5.camel@toshiba>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 16 May 2003 11:18:11 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-05-16 at 10:58, Paul Fulghum wrote:
> There is also the more trivial matter of removing the
> unnecessary setting of the FGR bit on wakeup.

Gack! I just thought of something else:

According to the 82371AB datasheet the controller
itself sets the USBCMD_FGR bit when a global RD is
detected. So qualifying the wakeup in software won't
prevent the controller itself from starting the
wakeup process on a false RD from an OC port. :-(

Hmmmm.... crap
Is there a way around this or are we back to
preventing the suspend?

-- 
Paul Fulghum
paulkf@microgate.com

