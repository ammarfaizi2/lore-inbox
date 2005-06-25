Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261256AbVFYULr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261256AbVFYULr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Jun 2005 16:11:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261327AbVFYULq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Jun 2005 16:11:46 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:22943 "EHLO suse.cz")
	by vger.kernel.org with ESMTP id S261256AbVFYUJl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Jun 2005 16:09:41 -0400
Date: Sat, 25 Jun 2005 22:09:53 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Alejandro Bonilla <abonilla@linuxwireless.org>
Cc: Pavel Machek <pavel@suse.cz>, Paul Sladen <thinkpad@paul.sladen.org>,
       linux-thinkpad@linux-thinkpad.org,
       Eric Piel <Eric.Piel@tremplin-utc.net>, borislav@users.sourceforge.net,
       "'Yani Ioannou'" <yani.ioannou@gmail.com>, linux-kernel@vger.kernel.org,
       hdaps-devel@lists.sourceforge.net
Subject: Re: [ltp] IBM HDAPS Someone interested? (Accelerometer)
Message-ID: <20050625200953.GA1591@ucw.cz>
References: <1119559367.20628.5.camel@mindpipe> <Pine.LNX.4.21.0506250712140.10376-100000@starsky.19inch.net> <20050625144736.GB7496@atrey.karlin.mff.cuni.cz> <42BD9EBD.8040203@linuxwireless.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42BD9EBD.8040203@linuxwireless.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 25, 2005 at 01:13:17PM -0500, Alejandro Bonilla wrote:

> I have a question here, how do you guys think that the head is parked, 
> is it done by the controller directly, which then sends the command to 
> the HD to park the head, or this is done by the operating system in some 
> kind of way?
> 
> I think the OS or user space is too slow like to react to send a park 
> command to the hard drive, so this most be done directly by the embedded 
> controller, but still I think it needs some input from the OS, to 
> initialize it's settings.

The only way to park a drive is to send a command to it through the IDE
interface. This can't be done by the controller itself, since the
controller in the ThinkPad is a classic Intel ICH chip which only passes
commands around.

The OS is definitely fast enough for this kind of task, it's doable even
in userspace, although not easy.

> i.e. after all, in windows you do have the settings in the software
> for HDAPS, but it looks like it is _not_ managed by the operating
> system at all if there is some type of action to  be taken. This is
> also probably why HDAPS won't kick in until booted, and that is
> because it needs to load its config setup by the software.

> This is what I think, please correct me if I'm saying something crazy.

It is definitely all done by the windows kernel driver.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
