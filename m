Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263376AbTKQHr6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Nov 2003 02:47:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263387AbTKQHr6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Nov 2003 02:47:58 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:52102 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S263376AbTKQHr5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Nov 2003 02:47:57 -0500
Date: Mon, 17 Nov 2003 08:47:48 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Zinx Verituse <zinx@epicsol.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: serio chaining in 2.6.x?
Message-ID: <20031117074748.GA27370@ucw.cz>
References: <20031117030652.GA4108@bliss>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031117030652.GA4108@bliss>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 16, 2003 at 09:06:52PM -0600, Zinx Verituse wrote:
> I have a device (the device in question is the infamous cuecat) which
> connects between the computer and a PS/2 device, and I'm trying to
> figure out a good way to chain serio devices, such as:
> 	atkbd <-> cuecat <-> lowlevel driver
> 
> The serio driver, however, is very clearly not designed for such
> chaining.  So, the question is:
> 
> What do you folks think the best method for chaining the
> serio drivers is?

You grab the port. Then you create a new one and register it. And you
forward all data that's not destined for you through to the new serio
port.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
