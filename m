Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261610AbUCVXR1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Mar 2004 18:17:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261703AbUCVXR1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Mar 2004 18:17:27 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:42768 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261610AbUCVXRY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Mar 2004 18:17:24 -0500
Date: Mon, 22 Mar 2004 23:17:18 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Muli Ben-Yehuda <mulix@mulix.org>, Jos Hulzink <jos@hulzink.net>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: OSS: cleanup or throw away
Message-ID: <20040322231718.G11212@flint.arm.linux.org.uk>
Mail-Followup-To: Adrian Bunk <bunk@fs.tum.de>,
	Muli Ben-Yehuda <mulix@mulix.org>, Jos Hulzink <jos@hulzink.net>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <200403221955.52767.jos@hulzink.net> <20040322202220.GA13042@mulix.org> <20040322215921.GU16746@fs.tum.de> <20040322220326.GF13042@mulix.org> <20040322222329.GW16746@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040322222329.GW16746@fs.tum.de>; from bunk@fs.tum.de on Mon, Mar 22, 2004 at 11:23:29PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 22, 2004 at 11:23:29PM +0100, Adrian Bunk wrote:
> On Tue, Mar 23, 2004 at 12:03:27AM +0200, Muli Ben-Yehuda wrote:
> > On Mon, Mar 22, 2004 at 10:59:21PM +0100, Adrian Bunk wrote:
> > > Wouldn't it be better to get the ALSA drivers working in such cases?
> > 
> > It would; but until they do, ditching OSS is a regression. 
> >...
> 
> Clearly.
> 
> Ditching OSS at the beginning of 2.7 will give several years to identify 
> and fix such regressions.

Seriously, ALSA has some issues at the moment which OSS doesn't have.
The main one is that OSS does not require mmap() access, whereas ALSA
native does at present - and there are architectures where the ALSA
method of mmap() both the ring buffer and the control data does not
work.

These issues aren't simple to resolve - as can be seen from the
recent lkml threads on the subject.  I've been seriously considering
submitting the existing OSS drivers I have here for ARM hardware
instead of trying to convert them to ALSA drivers first, and
considering whether I should be writing new OSS drivers in
preference to ALSA drivers.

That's not to say I don't want to see ALSA progress though - which is
why I'm working to try to get these issues resolved.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
