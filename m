Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752385AbWKNHcr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752385AbWKNHcr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 02:32:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755267AbWKNHcr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 02:32:47 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:42706 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1752385AbWKNHcq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 02:32:46 -0500
Subject: Re: [RFC] Pushing device/driver binding decisions to userspace
From: Arjan van de Ven <arjan@infradead.org>
To: Jim Crilly <jim@why.dont.jablowme.net>
Cc: Lee Revell <rlrevell@joe-job.com>, Ben Collins <ben.collins@ubuntu.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20061113221611.GG4824@voodoo.jdc.home>
References: <1163374762.5178.285.camel@gullible>
	 <1163404727.15249.99.camel@laptopd505.fenrus.org>
	 <1163443887.5313.27.camel@mindpipe>
	 <1163449139.15249.197.camel@laptopd505.fenrus.org>
	 <20061113221611.GG4824@voodoo.jdc.home>
Content-Type: text/plain
Organization: Intel International BV
Date: Tue, 14 Nov 2006 08:32:00 +0100
Message-Id: <1163489520.15249.233.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1.1 (2.8.1.1-3.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-11-13 at 17:16 -0500, Jim Crilly wrote:
> On 11/13/06 09:18:59PM +0100, Arjan van de Ven wrote:
> > On Mon, 2006-11-13 at 13:51 -0500, Lee Revell wrote:
> > > On Mon, 2006-11-13 at 08:58 +0100, Arjan van de Ven wrote:
> > > > Now; there is a second issue. If the choice for one or the other is
> > > > consistent, we should consider fixing the kernel drivers to just not
> > > > advertise the b0rked one.. (this assumes that both drivers are in the
> > > > kernel and both are open source) 
> > > 
> > > Unfortunately it becomes political quickly.  For example the old OSS
> > > i810_audio driver is still in the kernel even though the ALSA driver
> > > supports more hardware and provides more functionality because some
> > > people consider the ALSA driver bloated.
> > 
> > I doubt distros ship both though.... I thought all distros were
> > alsa-only by now..
> > 
> 
> I know that Debian ships both because I have to switch back to the OSS
> driver whenever I want to play one of those closed source games that mmap
> /dev/dsp because the ALSA OSS emulation can't seem to handle having the
> device opened via ALSA and /dev/dsp at the same time and the aoss wrapper
> doesn't work for apps that use mmap on /dev/dsp.

and this is why shipping 2 drivers suck.
"A has a bug so I need to use B" is the wrong answer, at least long
term. The real answer is "fix A".
I know it sucks for you, but if shipping B means A doesn't get fixed, or
worse, bugs in A hardly get reported... it means the short term is
hurting the long term, and just prolongs the pain even for you...
(since switching drivers is a pain, and more and more stuff is depending
on alsa nowadays)

-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com
Test the interaction between Linux and your BIOS via http://www.linuxfirmwarekit.org

