Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263003AbUE3LkD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263003AbUE3LkD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 May 2004 07:40:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263134AbUE3LkD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 May 2004 07:40:03 -0400
Received: from wasp.conceptual.net.au ([203.190.192.17]:38303 "EHLO
	wasp.net.au") by vger.kernel.org with ESMTP id S263003AbUE3LkA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 May 2004 07:40:00 -0400
Message-ID: <40B9C816.5090905@wasp.net.au>
Date: Sun, 30 May 2004 15:40:06 +0400
From: Brad Campbell <brad@wasp.net.au>
User-Agent: Mozilla Thunderbird 0.6 (X11/20040502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Sau Dan Lee <danlee@informatik.uni-freiburg.de>
CC: Vojtech Pavlik <vojtech@suse.cz>, Giuseppe Bilotta <bilotta78@hotpop.com>,
       linux-kernel@vger.kernel.org, Tuukka Toivonen <tuukkat@ee.oulu.fi>
Subject: Re: keyboard problem with 2.6.6
References: <MPG.1b2111558bc2d299896a2@news.gmane.org>	<20040525201616.GE6512@gucio>	<xb7hdu3fwsj.fsf@savona.informatik.uni-freiburg.de>	<xb7aczscv0q.fsf@savona.informatik.uni-freiburg.de>	<20040529131233.GA6185@ucw.cz>	<xb7y8nab65d.fsf@savona.informatik.uni-freiburg.de>	<20040530101914.GA1226@ucw.cz> <xb765aeb1i3.fsf@savona.informatik.uni-freiburg.de>
In-Reply-To: <xb765aeb1i3.fsf@savona.informatik.uni-freiburg.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sau Dan Lee wrote:
> 
> Once in kernel space, forever in kernel space?  What's the logic?
> 
> Where  it is  now possible  to  move it  out of  kernel space  WITHOUT
> performance problems, why not move it out?

I'd just like to comment on this particular point.

One application I have used utilises the keyboard as a trigger for audio processing and lighting
control. Having the keyboard processed in the kernel gives me pretty precise timing and low latency.
(Think setting CUE points in audio tracks. 10ms matters!). I'm not going to get that with a
userspace keyboard driver. Timing is still a little jittery, but then Linux is not a RTOS, but with
the driver in userspace I'm going to get a whole lot worse response for input events.

If you want to move the keyboard processing in userspace, why not just start with a microkernel.
There has to be a kernel/user line somewhere, and the grey areas are always going to be subject to
discussion.

Brad
