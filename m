Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263946AbUEHCf4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263946AbUEHCf4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 May 2004 22:35:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263871AbUEHCfz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 May 2004 22:35:55 -0400
Received: from fw.osdl.org ([65.172.181.6]:43930 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263946AbUEHCfy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 May 2004 22:35:54 -0400
Date: Fri, 7 May 2004 19:35:19 -0700
From: Andrew Morton <akpm@osdl.org>
To: Tuukka Toivonen <tuukkat@ee.oulu.fi>
Cc: linux-kernel@vger.kernel.org, danlee@informatik.uni-freiburg.de,
       b-gruber@gmx.de, mhakali@telia.com, Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: [PATCH] SERIO_USERDEV: direct userspace access to
 mouse/keyboard psaux serial ports
Message-Id: <20040507193519.06062655.akpm@osdl.org>
In-Reply-To: <Pine.GSO.4.58.0405072348120.21057@stekt37>
References: <Pine.GSO.4.58.0405072348120.21057@stekt37>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tuukka Toivonen <tuukkat@ee.oulu.fi> wrote:
>
> SERIO_USERDEV - Direct serial input device access for userspace
> 
>  This driver provides direct access from usespace into PS/2 (or psaux)
>  serial ports used usually for input devices such as mouses and keyboards.

I must say that last time this went around, the arguments which were made
in its favour made sense.  Let me recap:

At present, the kernel decodes the external device into logical "events"
and, if someone wants access to the raw device bitstream the kernel will
synthesize that bitstream from the decoded event stream.

But if, for example, the kernel doesn't have a decoder for the external
device, we're out of luck.

And given that the external device generates a stream of bits, the kernel
should provide some way for applications to directly access that stream
without the intervening interpretation.


Is that a decent summary of the situation?

If so then yeah, I think the kernel should have a driver which does all of
this.

