Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964830AbWBCBSl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964830AbWBCBSl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 20:18:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964831AbWBCBSl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 20:18:41 -0500
Received: from dspnet.fr.eu.org ([213.186.44.138]:23564 "EHLO dspnet.fr.eu.org")
	by vger.kernel.org with ESMTP id S964830AbWBCBSk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 20:18:40 -0500
Date: Fri, 3 Feb 2006 02:18:39 +0100
From: Olivier Galibert <galibert@pobox.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: Dave Jones <davej@redhat.com>, Nigel Cunningham <nigel@suspend2.net>,
       Pekka Enberg <penberg@cs.helsinki.fi>, linux-kernel@vger.kernel.org
Subject: Re: [ 00/10] [Suspend2] Modules support.
Message-ID: <20060203011839.GA58691@dspnet.fr.eu.org>
Mail-Followup-To: Olivier Galibert <galibert@pobox.com>,
	Pavel Machek <pavel@ucw.cz>, Dave Jones <davej@redhat.com>,
	Nigel Cunningham <nigel@suspend2.net>,
	Pekka Enberg <penberg@cs.helsinki.fi>, linux-kernel@vger.kernel.org
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <200602022131.59928.nigel@suspend2.net> <84144f020602020344p228e20b2x34226f341c296578@mail.gmail.com> <200602022228.20032.nigel@suspend2.net> <20060202154319.GA96923@dspnet.fr.eu.org> <20060202202527.GC2264@elf.ucw.cz> <20060202203155.GE11831@redhat.com> <20060202205148.GE2264@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060202205148.GE2264@elf.ucw.cz>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 02, 2006 at 09:51:48PM +0100, Pavel Machek wrote:
> Well, Olivier said I'm turning kernel into Hurd.

You're far from the only one.  There is currently a real fad into
putting as many things as possible (or not) in userspace without
seemingly thinking about things like security, long term
maintainability, usability or even compatiblity between kernel
versions and userspace versions.


> So he instead
> advocates merging 10 000 lines of code (+7500, contains new
> compression algorithm and new plugin architecture). I'd like to add
> interface to userland (+300) and remove swap writing (long term,
> -1000).

I don't actually advocate suspend2.  I indeed have not looked at the
patches at that point.  I do find it extremely annoying that instead
of trying to make what exists reliable, for instance what are the
rules irq grabbing/release at that point, and adding infrastructure
for what's missing for having real reliability, f.i. communication
with fb/drm to handle the screen power switch, you decide to go and
move things into userspace which is going to increase the reliability
problems immensely.  I don't even want to think about the interactions
between freezing the userspace memory pages and running some processes
which may malloc/mmap at the same time.

  OG.
