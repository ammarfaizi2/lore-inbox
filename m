Return-Path: <linux-kernel-owner+w=401wt.eu-S964939AbXAGTUj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964939AbXAGTUj (ORCPT <rfc822;w@1wt.eu>);
	Sun, 7 Jan 2007 14:20:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964956AbXAGTUj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Jan 2007 14:20:39 -0500
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:3069 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964939AbXAGTUi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Jan 2007 14:20:38 -0500
Date: Sun, 7 Jan 2007 19:20:29 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: David Woodhouse <dwmw2@infradead.org>, Tilman Schmidt <tilman@imap.cc>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: OT: character encodings (was: Linux 2.6.20-rc4)
Message-ID: <20070107192029.GE21133@flint.arm.linux.org.uk>
Mail-Followup-To: Jan Engelhardt <jengelh@linux01.gwdg.de>,
	David Woodhouse <dwmw2@infradead.org>,
	Tilman Schmidt <tilman@imap.cc>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.64.0701062216210.3661@woody.osdl.org> <Pine.LNX.4.61.0701071152570.4365@yvahk01.tjqt.qr> <20070107114439.GC21613@flint.arm.linux.org.uk> <45A0F060.9090207@imap.cc> <1168182838.14763.24.camel@shinybook.infradead.org> <20070107153833.GA21133@flint.arm.linux.org.uk> <1168187346.14763.70.camel@shinybook.infradead.org> <20070107170656.GC21133@flint.arm.linux.org.uk> <Pine.LNX.4.61.0701072009430.4365@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0701072009430.4365@yvahk01.tjqt.qr>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 07, 2007 at 08:11:38PM +0100, Jan Engelhardt wrote:
> 
> On Jan 7 2007 17:06, Russell King wrote:
> >On Mon, Jan 08, 2007 at 12:29:05AM +0800, David Woodhouse wrote:
> >
> >$ git log | head -n 1000 | tail -n 200 > o
> >$ file -i o
> >o: text/plain; charset=us-ascii
> >$ git log | head -n 1000 | tail -n 300 > o
> >$ file -i o
> >o: text/plain; charset=us-ascii
> >$ git log | head -n 1000 | tail -n 400 > o
> >$ file -i o
> >o: text/plain; charset=utf-8
> 
> I am inclined to say that "file" does not count, because it tries to guess an
> ambiguous mapping from bytes to character set. Even more, file should be
> _unable at all_ to distinguish an iso-8859-1 from an iso-8859-2 (or worse: 15)
> file. This program is soo... forget it, it's not an argument. It works well for
> headerful files, but text files don't really contain one. The next best thing
> would be html, with a proper <meta http-equiv=Content> tag.

You're discarding a perfectly reasonable argument - file itself obviously
is not good at guessing the charset, but inspecting the resulting file
manually and identifying *both* ISO-8859 and UTF-8 character sequences
in there is pretty conclusive.  As I did indeed do prior to sending
that message.

In this case, 'file' was doing a remarkably accurate job.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
