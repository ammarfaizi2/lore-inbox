Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261835AbTJAAwo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 20:52:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261845AbTJAAwn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 20:52:43 -0400
Received: from mailhost.tue.nl ([131.155.2.7]:37892 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id S261835AbTJAAwm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 20:52:42 -0400
Date: Wed, 1 Oct 2003 02:52:14 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Rob Landley <rob@landley.net>
Cc: Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org
Subject: Re: Keyboard dead on bootup on -test6.
Message-ID: <20031001005214.GC1520@win.tue.nl>
References: <200309301632.01498.rob@landley.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200309301632.01498.rob@landley.net>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 30, 2003 at 04:32:01PM -0500, Rob Landley wrote:

> This was the failure:
> 
> Sep 30 16:17:31 localhost kernel: atkbd.c: Unknown key pressed (raw set 0, 
> code 0xfc, data 0xfc, on isa0060/serio1).
> Sep 30 16:17:31 localhost kernel: serio: i8042 AUX port at 0x60,0x64 irq 12
> Sep 30 16:17:31 localhost kernel: serio: i8042 KBD port at 0x60,0x64 irq 1
> 
> Under -test5, that failure would have left me with a stuck key endlessly 
> repeating (and an otherwise dead keyboard).  Now at least the stuck key part 
> has gone away, but the keyboard is still dead until I power cycle the 
> machine.

I suppose this is the kernel trying to set LEDs on the mouse,
and the mouse complains.

Andries


(0xfc is a typical mouse error code; also "set 0" suggests this)

