Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262802AbUEOFDg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262802AbUEOFDg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 May 2004 01:03:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264645AbUEOFDg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 May 2004 01:03:36 -0400
Received: from mail.telpin.com.ar ([200.43.18.243]:4513 "EHLO
	mail.telpin.com.ar") by vger.kernel.org with ESMTP id S262802AbUEOFDf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 May 2004 01:03:35 -0400
Date: Sat, 15 May 2004 02:02:20 -0300
From: Alberto Bertogli <albertogli@telpin.com.ar>
To: Greg KH <greg@kroah.com>
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: BUG when removing USB flash drive
Message-ID: <20040515050205.GA4388@telpin.com.ar>
Mail-Followup-To: Alberto Bertogli <albertogli@telpin.com.ar>,
	Greg KH <greg@kroah.com>, linux-usb-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
References: <20040514004132.GA10537@telpin.com.ar> <20040514110301.GB29423@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040514110301.GB29423@kroah.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 14, 2004 at 04:03:01AM -0700, Greg KH wrote:
> On Thu, May 13, 2004 at 09:41:32PM -0300, Alberto Bertogli wrote:
> > 
> > This is a stock 2.6.6 kernel, on a Pentium 4 with HT (the kernel is
> > compiled with both SMP and preempt).
> 
> Can you test the latest -mm tree and see if it fixes this problem for
> you?

Sure. I've just tested -mm2; sorry it took so long but I had a couple of
other things going on.

Sadly, it locks up hard (no sysrq or anything) after booting, right in the
login prompt. Sometimes I got as far as typing the username and pressing
enter, others just frozen without even being able to press a key.

So I removed the SMT scheduler because I thought it might be related, and
it didn't even got to boot at all, it seem to freeze somewhere after
the initial load, but I can't see anything because the screen goes black
(even after I disabled framebuffer, SMP and preempt just in case).

I'll see if I can get a working config tomorrow morning so I can get to do
this tests (and report that lockup too).


Thanks a lot,
		Alberto


