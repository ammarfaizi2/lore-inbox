Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265390AbUBIS7s (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Feb 2004 13:59:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265385AbUBIS7s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Feb 2004 13:59:48 -0500
Received: from kweetal.tue.nl ([131.155.3.6]:40973 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id S265374AbUBIS7p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Feb 2004 13:59:45 -0500
Date: Mon, 9 Feb 2004 19:59:43 +0100
From: Andries Brouwer <aebr@win.tue.nl>
To: Mike Black <mblack@csi-inc.com>
Cc: Andries Brouwer <aebr@win.tue.nl>, Alex Davis <alex14641@yahoo.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Issues with linux-2.6.2
Message-ID: <20040209195943.A1101@pclin040.win.tue.nl>
References: <20040206212205.46151.qmail@web40501.mail.yahoo.com> <20040206223708.A2992@pclin040.win.tue.nl> <0a3901c3ef33$f7b52400$c8de11cc@black>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <0a3901c3ef33$f7b52400$c8de11cc@black>; from mblack@csi-inc.com on Mon, Feb 09, 2004 at 12:41:37PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 09, 2004 at 12:41:37PM -0500, Mike Black wrote:

> I'm trying to recompile util-linux-2.12 on Linux 2.6.2 and getting
> the same error as Alex.

The kernel is highly backwards compatible. It must be. It would be bad
if all old binaries suddenly stopped working.

It follows that if you translate with old headers, you get binaries that
work, but possibly do not use the latest features.


> I'm using linux-libc-headers-2.6.1.3

Using headers that are newer than the software you are compiling
can hardly improve things.


> And all this is to try and get rid of the "mount version older than kernel"
> message.

Well, the message is right: Linux 2.6.2 has NFS_MOUNT_VERSION 5
and util-linux-2.12 has NFS_MOUNT_VERSION 4.


> So what's the fix?

There are two fixes:

On the one hand that kernel message is a bug - each time we go to a
new NFS version lots of people waste a lot of time worrying about
this unfortunate kernel message, and mount has to spend guessing
the kernel version in order to avoid that message.
So, #if 0 that message and/or submit a patch removing it.

On the other hand, util-linux could use a new release.
Tell the maintainer :-)

Andries
