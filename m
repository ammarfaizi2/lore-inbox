Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751213AbWGQWUF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751213AbWGQWUF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jul 2006 18:20:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751216AbWGQWUF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jul 2006 18:20:05 -0400
Received: from mx1.redhat.com ([66.187.233.31]:17330 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751213AbWGQWUE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jul 2006 18:20:04 -0400
Date: Mon, 17 Jul 2006 15:19:40 -0700
From: Pete Zaitcev <zaitcev@redhat.com>
To: Benjamin Cherian <benjamin.cherian.kernel@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
       zaitcev@redhat.com
Subject: Re: Bug with USB proc_bulk in 2.4 kernel
Message-Id: <20060717151940.5cd79087.zaitcev@redhat.com>
In-Reply-To: <200607171435.22128.benjamin.cherian.kernel@gmail.com>
References: <mailman.1152332281.24203.linux-kernel2news@redhat.com>
	<200607101258.34005.benjamin.cherian.kernel@gmail.com>
	<20060710134022.c059d06c.zaitcev@redhat.com>
	<200607171435.22128.benjamin.cherian.kernel@gmail.com>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 2.2.3 (GTK+ 2.8.17; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Jul 2006 14:35:21 -0700, Benjamin Cherian <benjamin.cherian.kernel@gmail.com> wrote:

I'm skipping the discussion of the spec, but going further, here's
what we have:

> It is really looking like you are backing me into a corner to make the change 
> myself.  However, before doing so I'd like to say that I am disappointed that 
> the kernel developer list has not been more accommodating to this issue.

I understand, this is not a good situation. The problem is, it's 2.4.
It is upgraded very slowly, if at all. You came around about a year after
the fact. At the time, my initial approaches threw similar regressions
(with ADSL modems). Of course it's very tempting for me to off-load both
the work and the responsibility on you.

> Besides, the device that is being broken is a 10x CD-ROM drive!
> Who even uses these anymore? :-)

This was my reaction too, when Dell people came knocking. But apparently,
that thing is very popular. Also, they backed up their request with
a bag of money. In the end, I was glad I did "fix" that thing. Later,
it turned out to be OEM-ed by NEC, Fujitsu, and others; our own QA
uses it a lot as well. This happens because the 210PU offers significant
savings in power and space in OEM applications, and for casual users,
it's a perfect jump drive.

It's the same kind of question as, "who even uses 2.4 anymore".

By the way, did you consider an in-kernel driver? For me, it seems much
safer to reimplement the whole thing that way than to monkey with devio
again and risk more regressions.

Another option would be to change USBDEVFS_BULK to USBDEVFS_SUBMITURB.
Did you look at doing that?

Yours,
-- Pete
