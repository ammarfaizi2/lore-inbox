Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263556AbUCTWXz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Mar 2004 17:23:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263557AbUCTWXz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Mar 2004 17:23:55 -0500
Received: from web10407.mail.yahoo.com ([216.136.130.99]:8634 "HELO
	web10407.mail.yahoo.com") by vger.kernel.org with SMTP
	id S263556AbUCTWXx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Mar 2004 17:23:53 -0500
Message-ID: <20040320222352.94753.qmail@web10407.mail.yahoo.com>
Date: Sat, 20 Mar 2004 14:23:52 -0800 (PST)
From: "Michael W. Shaffer" <mwshaffer@yahoo.com>
Subject: Re: Kernel 2.6.4 Hang in utime() on swap file
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> ho hum.  We do this to prevent anyone from ftruncate()ing the swapfile
> while it is in use. That can destroy filesystems. Let me think about
> it a bit.

If it's a 'feature' and we just need to know to exclude swapfiles
from backups (since they don't need to be backed up anyway), then
that's an acceptable workaround, I just wanted to make sure that
it wasn't buggy behavior.

It is especially baffling because it leaves mysteriously un-killable
processes (not even kill -9 will get them, but I guess you know that
already). I don't know the internals behind this, but is there a non-
hideous way to have utime() return an error in this case rather than
entering this unkillable sleep or whatever? That might be a little
nicer since applications trying to do this would presumably handle
the error and proceed or exit rather than hanging infinitely with no
obvious way to free them.

Thanks for explaining what's going on anyway.


__________________________________
Do you Yahoo!?
Yahoo! Finance Tax Center - File online. File on time.
http://taxes.yahoo.com/filing.html
