Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261342AbTJHKr2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Oct 2003 06:47:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261351AbTJHKr2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Oct 2003 06:47:28 -0400
Received: from outpost.ds9a.nl ([213.244.168.210]:33470 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id S261342AbTJHKr1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Oct 2003 06:47:27 -0400
Date: Wed, 8 Oct 2003 12:47:26 +0200
From: bert hubert <ahu@ds9a.nl>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Robert White <rwhite@casabyte.com>,
       "'Albert Cahalan'" <albert@users.sourceforge.net>,
       "'Ulrich Drepper'" <drepper@redhat.com>,
       "'Mikael Pettersson'" <mikpe@csd.uu.se>,
       "'Kernel Mailing List'" <linux-kernel@vger.kernel.org>
Subject: Re: Who changed /proc/<pid>/ in 2.6.0-test5-bk9?
Message-ID: <20031008104726.GA4655@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	Linus Torvalds <torvalds@osdl.org>,
	Robert White <rwhite@casabyte.com>,
	'Albert Cahalan' <albert@users.sourceforge.net>,
	'Ulrich Drepper' <drepper@redhat.com>,
	'Mikael Pettersson' <mikpe@csd.uu.se>,
	'Kernel Mailing List' <linux-kernel@vger.kernel.org>
References: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAA2ZSI4XW+fk25FhAf9BqjtMKAAAAQAAAAwtz+A6aJAkeufXSGK2GIiwEAAAAA@casabyte.com> <Pine.LNX.4.44.0310071743370.32358-100000@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0310071743370.32358-100000@home.osdl.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 07, 2003 at 05:54:35PM -0700, Linus Torvalds wrote:

> But the same isn't true of file descriptors or a lot of other software-
> level abstractions. There are no inherent advantages to sharing, and in
> fact sharing just gives more opportunity for race conditions, bad
> interaction etc.

I may be missing something, I'm all for the ability to have threads with
their own fd namespace, but will NPTL/Linux retain the capability to pass
fd's to other threads?

One thing I've used in tens of programs is:

void *session(void *p)
{
	int fd=(int)p;
	...
}
...

for(;;) {
	fd=accept();
	pthread_create_thread(session,(void*)fd);
}

I'd like to continue to have that ability.

Thanks.

-- 
http://www.PowerDNS.com      Open source, database driven DNS Software 
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO
