Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964888AbWAWStA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964888AbWAWStA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 13:49:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964890AbWAWStA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 13:49:00 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:31371 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S964888AbWAWSs7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 13:48:59 -0500
To: Hubertus Franke <frankeh@watson.ibm.com>
Cc: Dave Hansen <haveblue@us.ibm.com>, Greg KH <greg@kroah.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "Serge E. Hallyn" <serue@us.ibm.com>,
       Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org,
       Cedric Le Goater <clg@fr.ibm.com>
Subject: Re: RFC [patch 13/34] PID Virtualization Define new task_pid api
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
	<m1y819naio.fsf@ebiederm.dsl.xmission.com>
	<43D522B2.5060308@watson.ibm.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Mon, 23 Jan 2006 11:48:06 -0700
In-Reply-To: <43D522B2.5060308@watson.ibm.com> (Hubertus Franke's message of
 "Mon, 23 Jan 2006 13:38:42 -0500")
Message-ID: <m1slrelr15.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hubertus Franke <frankeh@watson.ibm.com> writes:

> That's a good idea .. right now we simply did this through a flag left by the
> call
> to the /proc/container fs ... (awkward at best, but didn't break the API).
> I have a concern wrt doing it in during fork namely the sharing of resources.
> Whe obviously are looking at some constraints here wrt to sharing. We need to
> ensure that this ain't a thread etc that will share resources
> across "containers" (which then later aren't migratable due to that sharing).
> So doing the fork_exec() atomically would avoid that problem.

Checking that we aren't sharing things to become a thread is fairly straight
forward. do_fork already has similar checks in place.

This sounds like a classic case of if you don't want that don't do that
then.

Eric





