Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263685AbUDOVO0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Apr 2004 17:14:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262132AbUDOVOK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Apr 2004 17:14:10 -0400
Received: from kinesis.swishmail.com ([209.10.110.86]:28171 "EHLO
	kinesis.swishmail.com") by vger.kernel.org with ESMTP
	id S263582AbUDOVMw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Apr 2004 17:12:52 -0400
Message-ID: <407EFB08.6050307@techsource.com>
Date: Thu, 15 Apr 2004 17:13:44 -0400
From: Timothy Miller <miller@techsource.com>
MIME-Version: 1.0
To: Felix von Leitner <felix-kernel@fefe.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: radeonfb broken
References: <20040415202523.GA17316@codeblau.de>
In-Reply-To: <20040415202523.GA17316@codeblau.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Felix von Leitner wrote:
> I am using the radeonfb on a Radeon 9600 Pro with a TFT display, and
> radeonfb very recently started to give me a picture at all, so I am
> quite happy about that.
> 
> However, running mplayer does not work at all on radeonfb.  mplayer
> inquires about the color depth, I am using 32 bit color depth for this,
> but radeonfb says it's DirectColor instead of TrueColor, so mplayer
> tries to initialize the palette and fails.
> 
> Also, using fbset to set the mode to 1600x1200 fails.  The mode is
> changed, but the text console resolution stays the same.  Worse, a
> "setfont" changes back to 1024x768.
> 
> Also, I cannot view images on console with fbi or fbv.
> 
> Felix


What annoys me most about the Radeon driver is the off-by-one error in 
the bmove routine.  Whenever text is copied to the right or down, it 
gets positioned incorrectly.  I posted the fix, but no one paid attention.

