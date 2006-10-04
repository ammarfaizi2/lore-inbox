Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932380AbWJDMry@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932380AbWJDMry (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 08:47:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964789AbWJDMry
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 08:47:54 -0400
Received: from ra.tuxdriver.com ([70.61.120.52]:8208 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S932380AbWJDMrv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 08:47:51 -0400
Date: Wed, 4 Oct 2006 08:36:46 -0400
From: "John W. Linville" <linville@tuxdriver.com>
To: Sean <seanlkml@sympatico.ca>
Cc: jt@hpl.hp.com, Theodore Tso <tytso@mit.edu>, Jeff Garzik <jeff@garzik.org>,
       Linus Torvalds <torvalds@osdl.org>, Lee Revell <rlrevell@joe-job.com>,
       Alessandro Suardi <alessandro.suardi@gmail.com>,
       Norbert Preining <preining@logic.at>, hostap@shmoo.com,
       linux-kernel@vger.kernel.org, johannes@sipsolutions.net
Subject: Re: wpa supplicant/ipw3945, ESSID last char missing
Message-ID: <20061004123639.GA9277@tuxdriver.com>
References: <20061003180543.GD23912@tuxdriver.com> <4522A9BE.9000805@garzik.org> <20061003183849.GA17635@bougret.hpl.hp.com> <4522B311.7070905@garzik.org> <20061003214038.GE23912@tuxdriver.com> <20061003231648.GB26351@thunk.org> <20061003233138.GA2095@bougret.hpl.hp.com> <20061003202754.ce69f03a.seanlkml@sympatico.ca> <20061004003031.GA2215@bougret.hpl.hp.com> <20061003203646.60d9589a.seanlkml@sympatico.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061003203646.60d9589a.seanlkml@sympatico.ca>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 03, 2006 at 08:36:46PM -0400, Sean wrote:
> On Tue, 3 Oct 2006 17:30:31 -0700
> Jean Tourrilhes <jt@hpl.hp.com> wrote:
> 
> > 	How does that happen in practice ? Kernel has no clue on what
> > userpace version is running.
> > 
> 
> Ted mentioned that the way it works for stat is that userspace requests
> an API version and the kernel delivers it.  So old versions request old
> API and new versions request new API.  You only ever _add_ new API, and
> never remove older versions.

I think the point is that the API currently has no such facility.
Adding a new set of WE ioctls is unpalatable, both for general
ioctl-haters and because the WE ioctl collection is quite broad.
Maybe that could be solved by forcing the new WE stuff to use
the netlink-based WE facilities, but then you are expanding the
compatibility nightmare for whatever replaces WE.

John
-- 
John W. Linville
linville@tuxdriver.com
