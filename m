Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261690AbVGZMBy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261690AbVGZMBy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 08:01:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261730AbVGZMBx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 08:01:53 -0400
Received: from styx.suse.cz ([82.119.242.94]:54165 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S261720AbVGZMBK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 08:01:10 -0400
Date: Tue, 26 Jul 2005 14:01:08 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: moreau francis <francis_moreau2000@yahoo.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [INPUT] simple question on driver initialisation.
Message-ID: <20050726120108.GA2101@ucw.cz>
References: <20050726105557.GB1588@ucw.cz> <20050726114705.54469.qmail@web25802.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20050726114705.54469.qmail@web25802.mail.ukl.yahoo.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 26, 2005 at 01:47:05PM +0200, moreau francis wrote:
> hello,
> 
> --- Vojtech Pavlik <vojtech@suse.cz> a écrit :
> 
> > > What is this field for ?
> >  
> > It is intended for identifying the device based on "location" in the
> > system.
> > 
> 
> hmm, sorry but I don't understand you. I initialised this field with
> "pinpad/input0" but the only place I can grep or find it, is in
> /proc/bus/input/devices. I don't see how it can be used for identifiying
> the device...

It's also available via an ioctl() and in sysfs. This allows you to
specify in an application that you want a device plugged into a specific
port of the machine. Not many applications can use it at the moment, but
udev can use it to assign a name of the device node.

"pinpad/input0" doesn't sound right. What port is your pinpad connected
to?

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
