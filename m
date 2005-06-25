Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263393AbVFYLbt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263393AbVFYLbt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Jun 2005 07:31:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263395AbVFYLbt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Jun 2005 07:31:49 -0400
Received: from styx.suse.cz ([82.119.242.94]:56486 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S263393AbVFYLbr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Jun 2005 07:31:47 -0400
Date: Sat, 25 Jun 2005 13:31:46 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Paul Sladen <thinkpad@paul.sladen.org>
Cc: linux-thinkpad@linux-thinkpad.org, Eric Piel <Eric.Piel@tremplin-utc.net>,
       abonilla@linuxwireless.org, borislav@users.sourceforge.net,
       "'Pavel Machek'" <pavel@ucw.cz>,
       "'Yani Ioannou'" <yani.ioannou@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [ltp] IBM HDAPS Someone interested? (Accelerometer)
Message-ID: <20050625113146.GB1016@ucw.cz>
References: <1119559367.20628.5.camel@mindpipe> <Pine.LNX.4.21.0506250712140.10376-100000@starsky.19inch.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0506250712140.10376-100000@starsky.19inch.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 25, 2005 at 07:17:33AM +0100, Paul Sladen wrote:
> On Thu, 23 Jun 2005, Lee Revell wrote:
> > Yup, it's just doing port IO.  Get a kernel debugger for windows like
> > softice and this will be trivial to RE.
> > READ_PORT_USHORT / WRITE_PORT_UCHAR / READ_PORT_UCHAR
> 
> There are 3 ports involved.  The 0xed "non-existant delay port" and a pair
> of ports that are through the Super-I/O / IDE.  They are used in a
> index+value setup similar to reading/writing the AT keyboard controller.
> 
> >From what I remember, my conclusion was that these instructions were the
> ones to park the heads and then lock the IDE bus.  It's a couple of months
> ago, but somewhere I have the simplified version of what it was doing...
 
It'd rather surprise me, since parking is usually achieved through
sending a IDE command to the drive, which involves a rather different
set of ports.

The ports you mention could possibly set the IDE channel to a 'reset'
condition, although I doubt that, too.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
