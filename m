Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263398AbVFYOr5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263398AbVFYOr5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Jun 2005 10:47:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263397AbVFYOr5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Jun 2005 10:47:57 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:64748 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S263398AbVFYOrn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Jun 2005 10:47:43 -0400
Date: Sat, 25 Jun 2005 16:47:36 +0200
From: Pavel Machek <pavel@suse.cz>
To: Paul Sladen <thinkpad@paul.sladen.org>
Cc: linux-thinkpad@linux-thinkpad.org, Eric Piel <Eric.Piel@tremplin-utc.net>,
       abonilla@linuxwireless.org, "'Vojtech Pavlik'" <vojtech@suse.cz>,
       borislav@users.sourceforge.net,
       "'Yani Ioannou'" <yani.ioannou@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [ltp] IBM HDAPS Someone interested? (Accelerometer)
Message-ID: <20050625144736.GB7496@atrey.karlin.mff.cuni.cz>
References: <1119559367.20628.5.camel@mindpipe> <Pine.LNX.4.21.0506250712140.10376-100000@starsky.19inch.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0506250712140.10376-100000@starsky.19inch.net>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!


> > Yup, it's just doing port IO.  Get a kernel debugger for windows like
> > softice and this will be trivial to RE.
> > READ_PORT_USHORT / WRITE_PORT_UCHAR / READ_PORT_UCHAR
> 
> There are 3 ports involved.  The 0xed "non-existant delay port" and a pair
> of ports that are through the Super-I/O / IDE.  They are used in a
> index+value setup similar to reading/writing the AT keyboard
> > controller.

I think you got it... 2ports seem like enough for some kind of small
u-controller...

> >From what I remember, my conclusion was that these instructions were the
> ones to park the heads and then lock the IDE bus.  It's a couple of months
> ago, but somewhere I have the simplified version of what it was doing...

Don't think so... parking heads will go through IDE layer...
								Pavel

-- 
Boycott Kodak -- for their patent abuse against Java.
