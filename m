Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932169AbWBCKlv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932169AbWBCKlv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 05:41:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932196AbWBCKlv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 05:41:51 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:6793 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932169AbWBCKlv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 05:41:51 -0500
Date: Fri, 3 Feb 2006 11:41:29 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Olivier Galibert <galibert@pobox.com>, Dave Jones <davej@redhat.com>,
       Nigel Cunningham <nigel@suspend2.net>,
       Pekka Enberg <penberg@cs.helsinki.fi>, linux-kernel@vger.kernel.org
Subject: Re: [ 00/10] [Suspend2] Modules support.
Message-ID: <20060203104129.GC2830@elf.ucw.cz>
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <200602022131.59928.nigel@suspend2.net> <84144f020602020344p228e20b2x34226f341c296578@mail.gmail.com> <200602022228.20032.nigel@suspend2.net> <20060202154319.GA96923@dspnet.fr.eu.org> <20060202202527.GC2264@elf.ucw.cz> <20060202203155.GE11831@redhat.com> <20060202205148.GE2264@elf.ucw.cz> <20060203011839.GA58691@dspnet.fr.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060203011839.GA58691@dspnet.fr.eu.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Pá 03-02-06 02:18:39, Olivier Galibert wrote:
> On Thu, Feb 02, 2006 at 09:51:48PM +0100, Pavel Machek wrote:
> > So he instead
> > advocates merging 10 000 lines of code (+7500, contains new
> > compression algorithm and new plugin architecture). I'd like to add
> > interface to userland (+300) and remove swap writing (long term,
> > -1000).
> 
> I don't actually advocate suspend2.  I indeed have not looked at the
> patches at that point.  I do find it extremely annoying that instead
> of trying to make what exists reliable, for instance what are the

I'm trying to make what exists reliable, but I'm under some pressure
to allow things like progress bars. And for progress bars (etc) to be
feasible, it needs to be in userspace.

> rules irq grabbing/release at that point, and adding infrastructure
> for what's missing for having real reliability, f.i. communication
> with fb/drm to handle the screen power switch, you decide to go and
> move things into userspace which is going to increase the reliability
> problems immensely.  I don't even want to think about the interactions
> between freezing the userspace memory pages and running some processes
> which may malloc/mmap at the same time.

There are none. userspace helper is mlocked, and rest of userspace is
stopped.

								Pavel
-- 
Thanks, Sharp!
