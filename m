Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932329AbWGDVCg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932329AbWGDVCg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 17:02:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932398AbWGDVCg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 17:02:36 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:64016 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S932329AbWGDVCf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 17:02:35 -0400
Date: Tue, 4 Jul 2006 18:32:44 +0000
From: Pavel Machek <pavel@ucw.cz>
To: Fabio Comolli <fabio.comolli@gmail.com>
Cc: kernel list <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       mingo@redhat.com, "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: 2.6.17-mm5: lockdep prevents suspend to disk
Message-ID: <20060704183244.GB4420@ucw.cz>
References: <b637ec0b0607041258j36007132kdb7dbca1fa8f7dd5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b637ec0b0607041258j36007132kdb7dbca1fa8f7dd5@mail.gmail.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> * 2.6.17-mm5 (plus hotfix)  suspends/resume to disk 
> correctly
> * adding lockdep testsuite breaks it
> 
> Extract from dmesg:
> 
> Jul  4 21:48:08 tycho kernel: Freezing cpus ...
> Jul  4 21:48:08 tycho kernel: Stopping tasks:
> =====================================================================================
> Jul  4 21:48:08 tycho kernel:  stopping tasks timed out 
> after 20
> seconds (8 tasks remaining):
> Jul  4 21:48:08 tycho kernel:   rt-test-0
> Jul  4 21:48:08 tycho kernel:   rt-test-1
> Jul  4 21:48:08 tycho kernel:   rt-test-2
> Jul  4 21:48:08 tycho kernel:   rt-test-3
> Jul  4 21:48:08 tycho kernel:   rt-test-4
> Jul  4 21:48:08 tycho kernel:   rt-test-5
> Jul  4 21:48:08 tycho kernel:   rt-test-6
> Jul  4 21:48:08 tycho kernel:   rt-test-7

Are rt-test-X tasks kernel threads or userspace programs? (Kernel
threads need explicit try_to_freeze in them to allow suspend).

Are they normally killable?

							Pavel

-- 
Thanks for all the (sleeping) penguins.
