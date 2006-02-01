Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161101AbWBAQmN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161101AbWBAQmN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 11:42:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161102AbWBAQmM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 11:42:12 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.146]:14723 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1161101AbWBAQmK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 11:42:10 -0500
Subject: Re: RFC [patch 13/34] PID Virtualization Define new task_pid api
From: Dave Hansen <haveblue@us.ibm.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
       Hubertus Franke <frankeh@watson.ibm.com>, Greg KH <greg@kroah.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "Serge E. Hallyn" <serue@us.ibm.com>,
       Arjan van de Ven <arjan@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Cedric Le Goater <clg@fr.ibm.com>
In-Reply-To: <Pine.LNX.4.64.0601312027450.7301@g5.osdl.org>
References: <20060117143258.150807000@sergelap>
	 <20060117143326.283450000@sergelap>
	 <1137511972.3005.33.camel@laptopd505.fenrus.org>
	 <20060117155600.GF20632@sergelap.austin.ibm.com>
	 <1137513818.14135.23.camel@localhost.localdomain>
	 <1137518714.5526.8.camel@localhost.localdomain>
	 <20060118045518.GB7292@kroah.com>
	 <1137601395.7850.9.camel@localhost.localdomain>
	 <m1fyniomw2.fsf@ebiederm.dsl.xmission.com>
	 <43D14578.6060801@watson.ibm.com>
	 <Pine.LNX.4.64.0601311248180.7301@g5.osdl.org>
	 <m13bj34spw.fsf@ebiederm.dsl.xmission.com>
	 <Pine.LNX.4.64.0601312027450.7301@g5.osdl.org>
Content-Type: text/plain
Date: Wed, 01 Feb 2006 08:41:46 -0800
Message-Id: <1138812107.6424.75.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-01-31 at 20:39 -0800, Linus Torvalds wrote:
> On Tue, 31 Jan 2006, Eric W. Biederman wrote:
> > Yes.  Although there are a few container lifetimes problems with that
> > approach.  Do you want your container alive for a long time after every
> > process using it has exited just because someone has squirrelled away their
> > pid.  While container lifetime issues crop up elsewhere as well PIDs are
> > by far the worst, because it is current safe to store a PID indefinitely 
> > with nothing worse that PID wrap around.
> 
> Are people really expecting to have a huge turn-over on containers? It 
> sounds like this shouldn't be a problem in any normal circumstance: 
> especially if you don't even do the "big hash-table per container" 
> approach, who really cares if a container lives on after the last process 
> exited?

Other than testing, I can't imagine a case when we'd need them created
and destroyed very often.  In fact, one of the biggest cases for needing
checkpoint/restart on a container is a very long-lived processes that is
doing important work.

-- Dave

