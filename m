Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266417AbUBQR6F (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 12:58:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266420AbUBQR6F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 12:58:05 -0500
Received: from mailbox2.ucsd.edu ([132.239.1.54]:43273 "EHLO mailbox2.ucsd.edu")
	by vger.kernel.org with ESMTP id S266417AbUBQR6A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 12:58:00 -0500
From: Athanasios Leontaris <aleontar@ucsd.edu>
To: s0348365@sms.ed.ac.uk
Subject: Re: 2.6.2 Kernel Badness with 1.0-5336 NVIDIA driver
Date: Tue, 17 Feb 2004 09:57:51 -0800
User-Agent: KMail/1.6
Cc: linux-kernel@vger.kernel.org
References: <200402170808.21530.aleontar@ucsd.edu> <200402171754.14513.s0348365@sms.ed.ac.uk>
In-Reply-To: <200402171754.14513.s0348365@sms.ed.ac.uk>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-7"
Content-Transfer-Encoding: 7bit
Message-Id: <200402170957.51875.aleontar@ucsd.edu>
X-MailScanner: PASSED (v1.2.8 36233 i1HHvqAV051651 mailbox2.ucsd.edu)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I checked it. "RenderAccel" is not set.
Maybe FW and SBA have something to do with it, but that's just a guess.
Thanks.

On Tuesday 17 February 2004 09:54 am, Alistair John Strachan wrote:
> On Tuesday 17 February 2004 16:08, you wrote:
> > Hi to all,
> >
> > Pls cc me as I am not subscribing.
> > I know that the kernel is tainted so pls don't flame ;)
> > The kernel is 2.6.2 from www.kernel.org and I use AGPGART for AGP (_not_
> > NvAGP). Fast Writes and SBA are enabled. FC1 is the distro. The mobo is
> > Abit KG7 and the video card an FX5600.
> >
> > X stopped responding out of the blue, at a KDE 3.2 desktop, and it could
> > not be killed either. The following messages were uncovered in
> > my /var/log/messages:
>
> [snip]
>
> Please first check to see if /etc/X11/XF86Config or /etc/X11/XF86Config-4
> contains the string:
>
> Option "RenderAccel" "1"
>
> If it does, either remove the line or replace it with:
>
> Option "RenderAccel" "0"
>
> Render acceleration is still not working with the proprietary driver. I'm
> not saying it's definitely this, it just might not be related to the
> messages in syslog.
>
> I occasionally see these badness messages in syslog, but my machine never
> locks up. I was under the impression that these were only warnings.
