Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261700AbTIOJAc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Sep 2003 05:00:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262349AbTIOJAb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Sep 2003 05:00:31 -0400
Received: from mailhost.tue.nl ([131.155.2.7]:49160 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id S261700AbTIOJAa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Sep 2003 05:00:30 -0400
Date: Mon, 15 Sep 2003 11:00:28 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: xsdg <xsdg@freenode.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test1, -test4 control key "stuck"
Message-ID: <20030915110028.B957@pclin040.win.tue.nl>
References: <20030915000411.6d35386d.xsdg@freenode.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030915000411.6d35386d.xsdg@freenode.org>; from xsdg@freenode.org on Mon, Sep 15, 2003 at 12:04:11AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 15, 2003 at 12:04:11AM +0000, xsdg wrote:

> Exhibit 1:
> kernel: atkbd.c: Unknown key (set 2, scancode 0xb6, on isa0060/serio0) pressed.
> i8042 history: 19 a2 99 0f 8f 0f 8f 1c 9c 04 84 36 09 b6 89 b6 

p g-release p-release tab tab-release tab tab-release enter enter-release 3 3-release
RShift * RShift-release 8/*-release RShift-release

That is: the Shift key gave two release events.

> atkbd.c: Unknown key (set 2, scancode 0xa5, on isa0060/serio0) pressed.
> i8042 history: a7 20 9e 21 9f 24 25 26 27 a0 a4 a5 a6 a7 a1 a5 

;-release d a-release f s-release j k l ; d-release j-release k-release
l-release ;-release f-release k-release

The k key gave two release events.

> atkbd.c: Unknown key (set 2, scancode 0xa6, on isa0060/serio0) pressed.
> i8042 history: 20 9e 21 9f 24 25 26 27 a0 a4 a5 a6 a7 a1 a5 a6 

d a-release f s-release j k l ; d-release j-release k-release
l-release ;-release f-release k-release l-release

And so did the l key.

> atkbd.c: Unknown key (set 2, scancode 0xa7, on isa0060/serio0) pressed.
> i8042 history: 9e 21 9f 24 25 26 27 a0 a4 a5 a6 a7 a1 a5 a6 a7 

And so did the ; key.

Apparently your keyboard has problems handling the situation where many
keys are down simultaneously.

No kernel problem here - just a confusing message.

(Have not seen your [1]. Please do not use attachments. Please
do not gzip. It makes reading and replying to mail much more
time consuming.)

Andries

