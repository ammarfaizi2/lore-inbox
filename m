Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262932AbUE3LUY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262932AbUE3LUY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 May 2004 07:20:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263003AbUE3LUY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 May 2004 07:20:24 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:52352 "EHLO midnight.ucw.cz")
	by vger.kernel.org with ESMTP id S262932AbUE3LUT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 May 2004 07:20:19 -0400
Date: Sun, 30 May 2004 13:20:42 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Sau Dan Lee <danlee@informatik.uni-freiburg.de>
Cc: Tuukka Toivonen <tuukkat@ee.oulu.fi>, linux-kernel@vger.kernel.org
Subject: Re: keyboard problem with 2.6.6
Message-ID: <20040530112042.GB1377@ucw.cz>
References: <xb7n03qb3dd.fsf@savona.informatik.uni-freiburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xb7n03qb3dd.fsf@savona.informatik.uni-freiburg.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 30, 2004 at 12:45:02PM +0200, Sau Dan Lee wrote:

> For more imaginative innovations.
> 
> e.g. try my keyboard driver across 2 machines (using the SERIO_USERDEV
> patch from Tuukka Toivonen and me):
> 
>     master$ cat /dev/misc/isa0060/serio0 | ssh slave atkbd /proc/self/fd/0
> 
> The patch is here:
>     http://www.ee.oulu.fi/~tuukkat/tmp/linux-2.6.5-userdev.20040507.patch
> 
> The driver is here:
>     http://www.informatik.uni-freiburg.de/~danlee/fun/psaux/atkbd.c
> 
> (I haven't  tried this, as  I don't have  2 machines under  my control
> (==root) to try it out.  Please tell me the results.)
 
You can do this trivially without any patches, just by forwarding the
input events between the machines, reading evdev on one and using uinput
on the other. It will work without modification for mice, joysticks,
whatever you wish.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
