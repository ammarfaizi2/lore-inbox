Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932656AbWFVVrP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932656AbWFVVrP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 17:47:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932659AbWFVVrP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 17:47:15 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:25569 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932656AbWFVVrO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 17:47:14 -0400
Date: Thu, 22 Jun 2006 23:46:01 +0200
From: Pavel Machek <pavel@suse.cz>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: "Randy.Dunlap" <rdunlap@xenotime.net>,
       KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>, clameter@sgi.com,
       ntl@pobox.com, akpm@osdl.org, linux-kernel@vger.kernel.org,
       ashok.raj@intel.com, ak@suse.de, nickpiggin@yahoo.com.au, mingo@elte.hu
Subject: Re: [PATCH] stop on cpu lost
Message-ID: <20060622214601.GB4462@elf.ucw.cz>
References: <20060620125159.72b0de15.kamezawa.hiroyu@jp.fujitsu.com> <20060621225609.db34df34.akpm@osdl.org> <20060622150848.GL16029@localdomain> <20060622084513.4717835e.rdunlap@xenotime.net> <Pine.LNX.4.64.0606220844430.28341@schroedinger.engr.sgi.com> <20060623010550.0e26a46e.kamezawa.hiroyu@jp.fujitsu.com> <20060622092422.256d6692.rdunlap@xenotime.net> <20060622182231.GC4193@elf.ucw.cz> <449AF500.7000106@goop.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <449AF500.7000106@goop.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Čt 22-06-06 12:52:32, Jeremy Fitzhardinge wrote:
> Pavel Machek wrote:
> >That's what I'd prefer... as swsusp uses cpu hotplug.
> 
> Does it have to?  I presume this has been considered before, but what if 
> the other CPUs were just idled for suspend rather than "removed"?

Basically yes, it has to. Idling cpus is easy, but bringing cpus back
up during resume is not, and we'd like to reuse cpu hotplug code.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
